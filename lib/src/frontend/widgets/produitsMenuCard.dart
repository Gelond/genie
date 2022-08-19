import 'package:flutter/material.dart';
import 'package:genie/src/frontend/widgets/produitCard.dart';

import '../../backend/modeles/produit.dart';
import '../screens/pageDescriptionProduit.dart';

class ProduitsMenuCard extends StatefulWidget {
  final List<Produit> produits;
  const ProduitsMenuCard({Key? key, required this.produits}) : super(key: key);

  @override
  State<ProduitsMenuCard> createState() => _ProduitsMenuCardState();
}

class _ProduitsMenuCardState extends State<ProduitsMenuCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Les produits du menu',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),

          leading: new IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back,)
          ),

          centerTitle: true,
        ),

        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(delegate: SliverChildListDelegate(List.generate(widget.produits.length, (int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DescriptionProduit(produit: widget.produits[index], inPanier: false, boutton: false,)));
                            },
                            child: ProduitCard(produit: widget.produits[index], boutton: false,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                            child: Divider(),
                          )
                        ],
                      );
                    }
                    )
                    )
                    ),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}
