import 'package:genie/src/backend/modeles/commandeItem.dart';
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
  List<CommandeItem> commandeItems;
  EtatCommande etat;
  String nomClient;

  Commande( {required this.id, required this.table, this.emporter = false,
    required this.commandeItems, this.etat = EtatCommande.commandee, required this.nomClient} );

  String EtatString()
  {
    if(etat == EtatCommande.commandee)
      return 'Commandée';

    else if(etat == EtatCommande.traitement)
      return 'En cours de traitement';

    else if(etat == EtatCommande.pret)
      return 'Prête';

    else
      return 'Servie';
  }

  Map<String, dynamic> toMap()
  {
    return
      {
        "table": table, "emporter": emporter, "commandeItems": commandeItems.map((e) => e.toMap()).toList(),
        "etat": etat.index, "nomClient": nomClient
      };
  }

  static Future<Commande> fromMap(Map<String, dynamic> map) async
  {
    List<CommandeItem> list = [];

    final listMap = map["commandeItems"];
    print("******************************************************************************************************");
    print(listMap);

    listMap.forEach((element) async {
      CommandeItem c = await CommandeItem.fromMap(element);
      list.add(c);
      
    });

    return Commande(id: map["id"], table: map["table"], commandeItems: list,
        etat: EtatCommande.values[int.parse(map['etat'].toString())], nomClient: map["nomClient"]);
  }
}
