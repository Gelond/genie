//import 'package:fluter1/widgets/boutonComptage.dart';
import 'package:flutter/material.dart';
import '../../backend/modeles/produit.dart';
//import '../modeles/produit.dart';

class PanierCard extends StatefulWidget {
  final Produit produit;
  const PanierCard({Key? key, required this.produit}) : super(key: key);

  @override
  State<PanierCard> createState() => _PanierCardState();
}

class _PanierCardState extends State<PanierCard> {
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
                  child: Container(child: Image.asset(widget.produit.image, fit: BoxFit.fill,),
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
                              widget.produit.nom,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.orange
                              ),
                            ),
                            Text(widget.produit.typeString(),
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
                                  Text(widget.produit.score.toString(),
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
                            child: Text('\$' +widget.produit.prix.toString()),
                          ),

                          SizedBox(height: 0),

                          Row(
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    widget.produit.quantity--;
                                    if(widget.produit.quantity <= 1)
                                      widget.produit.quantity = 1;
                                  });
                                },
                                child: Icon(Icons.remove, color: Colors.white, size: 20,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                                fillColor: Colors.orange,
                                constraints: BoxConstraints(minWidth: 10, minHeight: 10),
                              ),

                              Text(widget.produit.quantity.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15
                                ),
                              ),

                              RawMaterialButton(
                                onPressed: ()  { setState(() {
                                  widget.produit.quantity++;
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
                          //SizedBox(height: 10,),

                          /*GetBuilder(
                            builder: () {
                              return BoutonComptage(
                                onIncrementSelected: () =>
                                    produit.quantity++,
                                onDecrementSelected: ()
                                {
                                  produit.quantity--;
                                  if(produit.quantity < 0)
                                    return 0;
                                  else return produit.quantity;
                                },
                                label: Text(
                                  produit.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              );
                            },
                          ),*/

                          SizedBox(height: 0),

                          ElevatedButton(
                              onPressed: () {},
                              child: Text('Supprimer',
                                style: TextStyle(
                                    fontSize: 10
                                ),)
                          ),
                          /*ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.delete)
                          )*/
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
