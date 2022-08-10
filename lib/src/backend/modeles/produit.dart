import 'package:flutter/material.dart';

enum TypeProduit
{
  entree,
  resistant,
  dessert,
  boisson
}
class Produit
{
  String id;
  String image;
  String nom;
  String description;
  double prix;
  int quantity;
  TypeProduit type;
  //String? categorie;
  bool isFavorite = false;
  int score = 0;

  Produit ( { required this.id, required this.image, required this.nom, required this.description,
    required this.type, required this.prix, this.quantity = 1, this.score = 0, this.isFavorite = false });

  String typeString()
  {
    if(type == TypeProduit.entree)
      return 'Entrée';

    else if(type == TypeProduit.resistant)
      return 'Plat de résistance';

    else if(type == TypeProduit.dessert)
      {
        return 'Dessert';
      }
    else
      return 'Boisson';
  }

  Map<String, dynamic> toMap()
  {
    return
      {
        "nom" : nom, "image": image, "description": description, "prix": prix, "type": type, "score": score
      };
  }

  static Produit fromMap(Map<String, dynamic> map)
  {
    return Produit(id: map["id"], image: map["image"], nom: map["nom"], description: map["description"], type: map["type"], prix: map["prix"], score: map["score"]);
  }
}
