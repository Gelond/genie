import 'package:genie/src/backend/base_donnees/dataProduits.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';
import 'package:genie/src/backend/modeles/commande.dart';

import '../modeles/produit.dart';

class FirebaseCommande
{
  static Future<List<Commande>> getCommandes() async
  {
    List<Commande> listCommandes = [];
    print('Debut getCommandes');
    List<Map<String, dynamic>> listMap = await GenieFirebase.getAllDocOfCollection("commandes");

    listMap.forEach((element) async {
      listCommandes.add(await Commande.fromMap(element));
    });
    //final p =  listMap.map((m) => Commande.fromMap(m)).toList();
    print('Fin getCommandes');
    return listCommandes;

  }

  static Future<Commande?> getCommande(String id) async
  {
    Map<String, dynamic>? commandeMap = await GenieFirebase.getDocument("commandes/$id");
    if(commandeMap!=null)
      return await Commande.fromMap(commandeMap);

    //else return null;
  }

  static Future<void>addCommande(Commande p) async
  {
    await GenieFirebase.add("commandes", p.toMap());
  }

  static Future<bool> deleteCommande(String id) async
  {
    return await GenieFirebase.deleteDocument("commandes/$id");
  }

  static Future<void> updateCommande(Commande commande) async
  {
    await GenieFirebase.dbbInstance.doc('commandes/${commande.id}').update(commande.toMap());
  }

  static Future<List<Commande>> getCommandesClient(int table) async
  {
    List<Commande> listCommandes = [];
    print('Debut getCommandes');
    List<Map<String, dynamic>> listMap = await GenieFirebase.filterInt('commandes', 'table', table);

    listMap.forEach((element) async {
      listCommandes.add(await Commande.fromMap(element));
    });
    //final p =  listMap.map((m) => Commande.fromMap(m)).toList();
    print('Fin getCommandes');
    return listCommandes;

  }
}