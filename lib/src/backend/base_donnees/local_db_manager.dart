import 'dart:async';

import 'package:genie/src/backend/base_donnees/firebase_produit.dart';
import 'package:genie/src/backend/modeles/commandeItem.dart';
import 'package:genie/src/backend/modeles/produit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';


class LocalBdManager {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    } else {
      return await initDb();
    }
  }

  static Future close() async {
    if (_db != null) {
      await _db!.close();
    }
  }

  initDb() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'genie_produits_panier.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE produits_panier (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
              ' idproduit TEXT, quantity INTEGER)',
        );

      },
      onUpgrade: (db, oldV, newV) async {
        if (newV > oldV) {
          //
        }
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

  Future<void> insertProduitInPanier(CommandeItem c) async {
    final dab = await db;

    CommandeItem? item = await produitInPanier(c.idProduit);
    if(item == null){
      await dab.insert(
        'produits_panier',
        c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('le produit a été ajouté');
    }
    else print('le produit est déjà dans le panier');
  }

  Future<List<CommandeItem>> produitsInPanier() async {
    // Get a reference to the database.
    final dab = await db;
    List<CommandeItem> listCommandeItem = [];

    final List<Map<String, dynamic>> maps =
    await dab.query('produits_panier',);

    maps.forEach((m) async {
      Produit? p =  await FirebaseProduit.getProduit(m['idproduit']);

      listCommandeItem.add(
          CommandeItem(
            id: m['id'],
            idProduit: m['idproduit'],
            quantity: m['quantity'],
            produit: p
            //date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date'])
          )
      );
    });

    return listCommandeItem;
  }

  Future<void> updateProduitInPanier(CommandeItem s) async {
    // Get a reference to the database.
    final dab = await db;


    await dab.update(
      'produits_panier',
      s.toMap(),

      where: 'id = ?',

      whereArgs: [s.id],
    );
  }

  Future<void> deleteProduitFromPanier(int id) async {
    // Get a reference to the database.
    final dab = await db;

   // CommandeItem? item = await produitInPanier(c.idProduit);


    await dab.delete(
      'produits_panier',

      where: 'id = ?',

      whereArgs: [id],
    );
  }

  Future<CommandeItem?> produitInPanier(String idproduit) async {
    // Get a reference to the database.
    final dab = await db;


    final List<Map<String, dynamic>> maps =
    await dab.query('produits_panier', where: 'idproduit = ?', whereArgs: [idproduit]);
    if (maps.isEmpty) {
      return null;
    }

    return CommandeItem(
      id: maps[0]["id"],
      idProduit: maps[0]["idproduit"],
      quantity: maps[0]["quantity"],
      produit: maps[0]["produit"],
    );
  }

  Future<void> viderPanier() async {
    // Get a reference to the database.
    final dab = await db;

    // CommandeItem? item = await produitInPanier(c.idProduit);

    await dab.delete(
      'produits_panier'

    );
  }

/*
  Modifie legerement insertProduitInPanier apres avoir creé produitInPanier
  Dans insertProduitInPanier tu fais ce test pour voir si le ptoduit etait ajouté avant d'ajouter sinon:
  CommandeItem item = await produitInPanier(c.idpproduit);
  if(item) {
      tu ajoutes pas
  }
  else{
        tu ajouter
  }*/


}