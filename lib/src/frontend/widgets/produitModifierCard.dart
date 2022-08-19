import 'package:flutter/material.dart';

import '../../backend/modeles/produit.dart';

class ProduitModifyCard extends StatefulWidget {
  final Produit produit;
  const ProduitModifyCard({Key? key, required this.produit}) : super(key: key);

  @override
  State<ProduitModifyCard> createState() => _ProduitModifyCardState();
}

class _ProduitModifyCardState extends State<ProduitModifyCard> {
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
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange,
                                    size: 18.0,
                                  ),
                                  Text(widget.produit.score.toString(),
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
                            child: Text('\$' +widget.produit.prix.toString()),
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
