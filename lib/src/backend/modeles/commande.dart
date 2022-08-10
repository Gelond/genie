import 'package:genie/src/backend/modeles/produit.dart';

enum EtatCommande
{
  commandee,
  traitement,
  pret,
  servi
}

class Commande
{
  String id;
  int table;
  bool emporter;
  List<Produit> produitsCommandees;
  EtatCommande etat;

  Commande( {required this.id, required this.table, this.emporter = false, required this.produitsCommandees, this.etat = EtatCommande.commandee} );

  String EtatString()
  {
    if(etat == TypeProduit.entree)
      return 'Commandée';

    else if(etat == EtatCommande.traitement)
      return 'En cours de traitement';

    else if(etat == EtatCommande.pret)
      return 'Prête';

    else
      return 'Servie';
  }
}
