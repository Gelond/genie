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
  int disponibility;
  TypeProduit type;
  bool isFavorite;
  int score = 0;

  Produit ( { required this.id, required this.image, required this.nom, required this.description,
    required this.type, required this.prix, required this.disponibility, this.score = 0,
    this.isFavorite = false });

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
        "nom" : nom, "image": image, "description": description, "prix": prix,
        "disponibility": disponibility, "type": type.index, "score": score, 'isFavorite': isFavorite
      };
  }

  static Produit fromMap(Map<String, dynamic> map)
  {
    return Produit(id: map["id"], image: map["image"], nom: map["nom"],
        description: map["description"], isFavorite: map["isFavorite"],
        type: TypeProduit.values[int.parse(map['type'].toString())],
        prix: double.parse(map["prix"].toString()), disponibility: int.parse(map["disponibility"].toString()) ,
        score: int.parse(map["score"].toString()));
  }

 /* int typeToInt()
  {
    if(type == TypeProduit.entree)
      return 0;

    else if(type == TypeProduit.resistant)
      return 1;

    else if(type == TypeProduit.dessert)
    {
      return 2;
    }
    else
      return 3;
  }*/

 /* static TypeProduit typeFromInt(int i)
  {
    if(i == 0)
      return TypeProduit.entree;

    else if(i==1)
      return TypeProduit.resistant;

    else if(i==2)
    {
      return TypeProduit.dessert;
    }
    else
      return TypeProduit.boisson;
  }*/
}
