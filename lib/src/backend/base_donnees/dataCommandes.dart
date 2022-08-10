
import '../modeles/commande.dart';
import 'dataProduits.dart';

List<Commande> commandes = [
  Commande(id: '3', table: 5, emporter: true, etat: EtatCommande.commandee, produitsCommandees: panier),
  //Commande(id: '20', table: 15, emporter: false, etat: EtatCommande.pret, produitsCommandees: produitsCommandees),
  Commande(id: '8', table: 30, emporter: false, etat: EtatCommande.traitement, produitsCommandees: panier),
  Commande(id: '18', table: 25, emporter: true, etat: EtatCommande.servi, produitsCommandees: produits),
];