
import 'package:flutter/material.dart';
import 'package:genie/src/frontend/widgets/produitCard.dart';

import '../../backend/modeles/commande.dart';
import '../screens/pageDescriptionProduit.dart';

class CommandeCard extends StatefulWidget {
  final Commande commande;
  final int index;
  const CommandeCard({Key? key, required this.commande, required this.index}) : super(key: key);

  @override
  State<CommandeCard> createState() => _CommandeCardState();
}

class _CommandeCardState extends State<CommandeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Détails sur la commande',
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
              SizedBox(height: 10,),

              Text('Commande',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              ),

              SizedBox(height: 10,),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("Id: ${widget.commande.id}", style: TextStyle(fontSize: 15),),
                              SizedBox(height: 10,),
                              Text("Table: ${widget.commande.table}", style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          if(widget.commande.etat != EtatCommande.servi )
                          Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Changer état',)
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      if(widget.commande.emporter)
                        Text('Type: Emporter', style: TextStyle(fontSize: 15) ),
                      if(!widget.commande.emporter)
                        Text('Type: Servir sur place', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10,),
                      Text('Etat: ${widget.commande.EtatString()}', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10,),
                      Text("Composée de:", style: TextStyle(fontSize: 15))
                      //Text("data")
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(delegate: SliverChildListDelegate(List.generate(widget.commande.produitsCommandees.length, (int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DescriptionProduit(produit: widget.commande.produitsCommandees[index], inPanier: false, boutton: false,)));
                            },
                            child: ProduitCard(produit: widget.commande.produitsCommandees[index], boutton: false,),
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
