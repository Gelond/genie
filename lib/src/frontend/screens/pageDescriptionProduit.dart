
import 'package:flutter/material.dart';

import '../../backend/modeles/produit.dart';

class DescriptionProduit extends StatefulWidget {
  const DescriptionProduit({Key? key, required this.produit, required this.inPanier, required this.boutton}) : super(key: key);

  final Produit produit;
  final bool inPanier;
  final bool boutton;
  @override
  State<DescriptionProduit> createState() => _DescriptionProduitState();
}

class _DescriptionProduitState extends State<DescriptionProduit> {
  bool isFav = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,

        title: Text('Description du produit',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20.0,
          ),
        ),

        leading: new IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height/2.5,
              width: MediaQuery.of(context).size.width*0.97,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top:3),
                    child: Image.asset(widget.produit.image, fit: BoxFit.cover,),
                  ),
                  height: MediaQuery.of(context).size.width*0.8,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(itemCount:1,itemBuilder: (BuildContext context, int i)
            {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),

                                  Text(widget.produit.typeString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.orange,
                                          size: 25.0,
                                        ),

                                        Text(widget.produit.score.toString(),
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 15
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(child:
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$' +widget.produit.prix.toString(),
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width/3),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Positioned(
                                    right: -10.0,
                                    bottom: 3.0,
                                    child: RawMaterialButton(
                                      onPressed: (){},
                                      fillColor: Colors.white,
                                      shape: CircleBorder(),
                                      elevation: 4.0,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          isFav
                                              ?Icons.favorite
                                              :Icons.favorite_border,
                                          color: Colors.orange,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              widget.produit.description,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                              ),
                              //textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                              //maxLines: 2,
                            ),
                          ),
                          if(widget.boutton)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 5),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: widget.inPanier ? Text('Supprimer', style: TextStyle(fontSize: 13)) : Text('Ajouter au panier',)
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),

    );
  }
}
