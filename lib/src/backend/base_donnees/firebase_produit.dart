import 'package:genie/src/backend/base_donnees/dataProduits.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';

import '../modeles/produit.dart';

class FirebaseProduit
{
  static Future<List<Produit>> getProduits() async
  {
    print('Debut getProduits');
    List<Map<String, dynamic>> listMap = await GenieFirebase.getAllDocOfCollection("produits");
    final p =  listMap.map((m) => Produit.fromMap(m)).toList();
    print('Fin getProduits');
    return p;

  }

  static Future<Produit?> getProduit(String id) async
  {
    Map<String, dynamic>? produitMap = await GenieFirebase.getDocument("produits/$id");
    if(produitMap!=null)
      return Produit.fromMap(produitMap);

    //else return null;
  }

  static Future<void>addProduit(Produit p) async
  {
    await GenieFirebase.add("produits", p.toMap());
  }

  static Future<bool> deleteProduit(String id) async
  {
    return await GenieFirebase.deleteDocument("produits/$id");
  }

  static Future<void> updateProduit(Produit produit) async
  {
    await GenieFirebase.dbbInstance.doc('produits/${produit.id}').update(produit.toMap());
  }
}