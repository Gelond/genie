import 'package:genie/src/backend/modeles/produit.dart';
import 'package:genie/src/backend/modeles/produit.dart';

class Menu
{
  String id;
  String image;
  String nom;
  List<Produit> produits;

  Menu({required this.id, required this.image, required this.nom, required this.produits });
}