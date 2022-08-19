//import 'package:fluter1/widgets/boutonComptage.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/local_db_manager.dart';
import 'package:genie/src/backend/modeles/commandeItem.dart';
import '../../backend/modeles/produit.dart';
//import '../modeles/produit.dart';

class PanierCard extends StatefulWidget {
  final CommandeItem item;
  const PanierCard({Key? key, required this.item,}) : super(key: key);

  @override
  State<PanierCard> createState() => _PanierCardState();
}

class _PanierCardState extends State<PanierCard> {
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
                  child: Container(child: Image.asset(widget.item.produit!.image, fit: BoxFit.fill,),
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
                              widget.item.produit!.nom,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.orange
                              ),
                            ),
                            Text(widget.item.produit!.typeString(),
                              style: TextStyle(
                                  color: Colors.grey
                              ),),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange,
                                    size: 25.0,
                                  ),
                                  Text(widget.item.produit!.score.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
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
                            child: Text('\$' +widget.item.produit!.prix.toString()),
                          ),

                          SizedBox(height: 0),

                          Row(
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  if(widget.item.quantity > 1)
                                  setState(() {
                                    widget.item.quantity--;
                                  });
                                  localBdManager.updateProduitInPanier(widget.item);
                                },
                                child: Icon(Icons.remove, color: Colors.white, size: 20,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                                fillColor: Colors.orange,
                                constraints: BoxConstraints(minWidth: 10, minHeight: 10),
                              ),

                              Text(widget.item.quantity.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15
                                ),
                              ),

                              RawMaterialButton(
                                onPressed: ()  { if(widget.item.quantity<10)
                                  setState(() {
                                  widget.item.quantity++;
                                  localBdManager.updateProduitInPanier(widget.item);
                                });
                                },
                                //constraints: BoxConstraints.tight(1),
                                child: Icon(Icons.add, color: Colors.white, size: 20,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                                fillColor: Colors.orange,
                                constraints: BoxConstraints(minWidth: 10, minHeight: 10),
                              )
                            ],

                          ),

                          SizedBox(height: 0),

                          ElevatedButton(
                              onPressed: () {
                                        print('Debut suppression');
                                         localBdManager.deleteProduitFromPanier(widget.item.id);
                                        print('Le produit a été supprimé');
                              },

                              child: Text('Supprimer',
                                style: TextStyle(
                                    fontSize: 10
                                ),)
                          ),
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
