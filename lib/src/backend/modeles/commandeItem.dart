import 'package:genie/src/backend/modeles/produit.dart';

import '../base_donnees/firebase_produit.dart';

class CommandeItem
{
  String idProduit;
  int quantity;
  int id;
  Produit? produit;

  CommandeItem({required this.idProduit, required this.quantity, required this.id, this.produit} );

  Map<String, dynamic> toMap()
  {
    return
      {
        "idproduit" : idProduit, "quantity" : quantity,
      };
  }

  static Future<CommandeItem> fromMap(Map<String, dynamic> map) async
  {
    Produit? p =  await FirebaseProduit.getProduit(map['idproduit']);
    print("*****************************************************************************************");
    print(map["quantity"]);

    return CommandeItem(idProduit: map["idproduit"], quantity: int.parse(map["quantity"].toString()), id: 0, produit: p);
  }
}