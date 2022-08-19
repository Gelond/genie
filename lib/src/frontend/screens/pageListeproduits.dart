import 'package:flutter/material.dart';
import 'package:genie/src/frontend/screens/pageDescriptionProduit.dart';
import 'package:genie/src/frontend/screens/pageFormulaireAjouterProduit.dart';
import 'package:genie/src/frontend/screens/pageModifierProduit.dart';

import '../../backend/base_donnees/dataMenus.dart';
import '../../backend/base_donnees/firebase_produit.dart';
import '../../backend/modeles/menu.dart';
import '../../backend/modeles/produit.dart';
import '../widgets/produitCard.dart';
import '../widgets/produitsMenuCard.dart';

class ListePoduits extends StatefulWidget {
  const ListePoduits({Key? key}) : super(key: key);

  @override
  State<ListePoduits> createState() => _ListePoduitsState();
}

class _ListePoduitsState extends State<ListePoduits> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les produits',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 23.0,
              fontWeight: FontWeight.bold
          ),
        ),
        //backgroundColor: Colors.blueGrey.shade50,
        leading: new IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back,)
        ),
        centerTitle: true,

        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.add, size: 30,),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
              builder: (context)=> FormulaireAjouterProduit())).then((value) {
                setState(() {

                });
              });
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: FutureBuilder(
            future: FirebaseProduit.getProduits(),
            builder: (BuildContext context, AsyncSnapshot<List<Produit>> snap){
              if (snap.hasData) {
                return ListView(children: List.generate(snap.data!.length, (index) {
                  return Column(
                    children: [
                      ListTile(title: Text(snap.data![index].nom),
                      trailing: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            onChanged: (String? v){
                              if(v=='modifier'){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    FormulaireModifierProduit(produit: snap.data![index]))).then((value) {
                                      setState(() {

                                      });
                                });

                              }
                              else if(v=='supprimer'){
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsAlignment:
                                      MainAxisAlignment.spaceAround,
                                      title: Text('Voulez-vous vraiment supprimer ?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              FirebaseProduit.deleteProduit(snap.data![index].id).then((value) {
                                                setState(() {

                                                });
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Supprimer"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 184, 50, 10),
                                                shape: StadiumBorder(),
                                                padding: EdgeInsets.all(8.0))),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Annuler"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255, 10, 184, 39),
                                                shape: StadiumBorder(),
                                                padding: EdgeInsets.all(8.0)))
                                      ],
                                    )).then((value) {
                                  setState(() {});
                                });

                              }
                            },
                            dropdownColor: Colors.blueGrey,
                            items: [
                              DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Text('Modifier', style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                value: 'modifier',
                                /*onTap: ()=> (value){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FormulaireModifierProduit(produit: snap.data![index])));
                                  },*/
                              ),
                              DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Text('Supprimer', style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                value: 'supprimer',
                                /*onTap: () => (value){
                                  FirebaseProduit.deleteProduit(snap.data![index].id).then((value) {
                                    setState(() {

                                    });
                                  });
                                  },*/
                              )
                            ],
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.more_vert, size: 25,),
                            ),
                          )
                      ),
                        onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>DescriptionProduit( produit: snap.data![index], inPanier: false, boutton: false,)));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                        child: Divider(),
                      ),
                    ],
                  );
                }) );
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
      ),
      )
    );
  }
}