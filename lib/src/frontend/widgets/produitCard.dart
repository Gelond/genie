import 'package:flutter/material.dart';
import 'package:genie/src/backend/modeles/commandeItem.dart';

import '../../backend/base_donnees/local_db_manager.dart';
import '../../backend/modeles/produit.dart';

class ProduitCard extends StatelessWidget {

  final Produit produit;
  final bool boutton;
  ProduitCard({Key? key, required this.produit, this.boutton = true}) : super(key: key);

  LocalBdManager localBdManager = LocalBdManager();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(child: Image.asset(produit.image, fit: BoxFit.fill,),
                    height: 90.0, width: 90.0,)
              ),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produit.nom,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.orange
                              ),
                            ),
                            Text(produit.typeString(),
                              style: TextStyle(
                                  color: Colors.grey
                              ),),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange,
                                    size: 18.0,
                                  ),
                                  Text(produit.score.toString(),
                                    style: TextStyle(
                                        color: Colors.orange
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('\$' +produit.prix.toString()),
                          ),

                          SizedBox(height: 30,),

                          if(boutton)
                          ElevatedButton(
                              onPressed: () async {
                                await localBdManager.insertProduitInPanier(
                                    CommandeItem(idProduit: produit.id, quantity: 1, id: 0));
                                //print('Le produit a ??t?? ajout??');
                              },
                              child: Text('Ajouter au panier',
                              style: TextStyle(
                                fontSize: 8
                              ),
                              )
                          )
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}