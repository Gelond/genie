import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/local_db_manager.dart';
import 'package:genie/src/backend/modeles/commandeItem.dart';
import 'package:genie/src/frontend/screens/pageDescriptionProduit.dart';
import 'package:genie/src/frontend/screens/pageFormulaireCommande.dart';

import '../../backend/modeles/produit.dart';
import '../widgets/customTabBar.dart';
import '../widgets/panierCard.dart';

class AfficherPanier extends StatefulWidget {


  const AfficherPanier({Key? key}) : super(key: key);

  @override
  State<AfficherPanier> createState() => _AfficherPanierState();
}

class _AfficherPanierState extends State<AfficherPanier> {

  List<CommandeItem> panier = [];
  int _selectedIndex = 0;
  List<String> tabBars = ['Tous', 'Entrées', 'Plats de résistance', 'Desserts', 'Boissons'];
  List<CommandeItem> produitsInPanier = [];

  void _trier(int index)
  {
    produitsInPanier = panier;
    if (index == 0) {
      produitsInPanier = panier;
    }

    else if (index == 1) {
      var list = panier.where((p) => p.produit!.type == TypeProduit.entree);
      produitsInPanier = list.toList();
    }

    else if (index == 2) {
      var list = panier.where((p) => p.produit!.type == TypeProduit.resistant);
      produitsInPanier = list.toList();
    }
    else if (index == 3) {
      var list = panier.where((p) => p.produit!.type == TypeProduit.dessert);
      produitsInPanier = list.toList();
    }
    else {
      var list = panier.where((p) => p.produit!.type == TypeProduit.boisson);
      produitsInPanier = list.toList();
    }
  }
  LocalBdManager localBdManager = LocalBdManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localBdManager.produitsInPanier().then((value) {
      setState(() {
        panier = value;
        produitsInPanier = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBars.length,

      child: Scaffold(
        appBar: AppBar(
          title: Text('Votre panier',
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

          //leading: Icon(Icons.restaurant_menu),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: new Icon(Icons.shopping_basket, size: 35.0,),
            )
          ],

          centerTitle: true,
        ),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: Colors.white,
              title: Container(
                  height: 100.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: TabBar(
                  tabs: List.generate(tabBars.length, (index) {
                    if (_selectedIndex == index)
                      return CustomTab(
                        text: tabBars[index],
                        isSelected: true,
                      );
                    else
                      return CustomTab(text: tabBars[index]);
                  }),
                  isScrollable: true,
                  onTap: (index) {
                    print("tap");
                    setState(() {
                      _selectedIndex = index;
                      _trier(_selectedIndex);
                    });
                  },
                  indicatorColor: Colors.blueGrey.shade50,
                ),
              ),
            ),

            /*setState(() {
                          _selectedIndex = index;
                          _trier(_selectedIndex);
                        }*/

            SliverList(delegate: SliverChildListDelegate(List.generate(produitsInPanier.length, (int index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          DescriptionProduit(produit: produitsInPanier[index].produit!,
                            inPanier: true, boutton: true,)));
                    },
                    child: PanierCard(item: produitsInPanier[index]),
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



            SliverToBoxAdapter(
              child: Column(
                children: [
                  if(panier.isEmpty) Text("Aucun produit n'a été ajouté"),
                  if(panier.isNotEmpty)
                  ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FormulaireCommande(items: panier,)));
                      },
                      child: Text('Valider le panier',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
