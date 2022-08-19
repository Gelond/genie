import 'package:genie/src/backend/modeles/produit.dart';
import 'package:genie/src/backend/modeles/produit.dart';

class Menu
{
  String id;
  String nom;
  String date;
  List<Produit> produits;

  Menu({required this.id, required this.nom, required this.date, required this.produits });

  Map<String, dynamic> toMap()
  {
    return
      {
        "id" : id, "nom": nom, "date": date, "produits": produits
      };
  }

  static Menu fromMap(Map<String, dynamic> map)
  {
    return Menu(id: map["id"], nom: map["nom"], date: map["date"], produits: map["produits"]);
  }

}