import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';
import 'package:genie/src/frontend/screens/pageDescriptionProduit.dart';
import 'package:genie/src/frontend/screens/pageVoirPanier.dart';
import 'package:genie/src/frontend/screens/screen1.dart';

import '../../backend/base_donnees/firebase_produit.dart';
import '../../backend/modeles/produit.dart';
import '../widgets/customTabBar.dart';
import '../widgets/favoriteCard.dart';
import '../widgets/produitCard.dart';
import '../widgets/searchBar.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({Key? key}) : super(key: key);

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {


  int _selectedIndex = 0;
  List<String> tabBars = ['Tous', 'Entrées', 'Plat de résistantces', 'Desserts', 'Boissons'];
  List<Produit> produits = [];
  List<Produit> produitsAff = [];
  List<Produit> produitsFavoris = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseProduit.getProduits().then((value) {
      setState(() {
        produits = value;
        produitsAff = produits;
      });
    }
    );
  }

  void _trier(int index) async {
    produitsAff = produits;
    if (index == 0) {
      produitsAff = produits;
    }

    else if (index == 1) {
      var list = produits.where((p) => p.type == TypeProduit.entree);
      produitsAff = list.toList();
    }

    else if (index == 2) {
      var list = produits.where((p) => p.type == TypeProduit.resistant);
      produitsAff = list.toList();
    }
    else if (index == 3) {
      var list = produits.where((p) => p.type == TypeProduit.dessert);
      produitsAff = list.toList();
    }

    else if (index == 4) {
      var list = produits.where((p) => p.type == TypeProduit.boisson);
      produitsAff = list.toList();
    }
  }


  @override
  Widget build(BuildContext context) {
    produitsFavoris = produits.where((element) => element.isFavorite).toList();

    return DefaultTabController(
        length: tabBars.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Menu du jour',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              //backgroundColor: Colors.blueGrey.shade50,
              leading: new IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: ''))),

                  icon: Icon(Icons.arrow_back,)
              ),

              //leading: Icon(Icons.restaurant_menu),

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: new Icon(
                    Icons.restaurant_menu, size: 35, semanticLabel: 'Personnel',),
                )
              ],

              centerTitle: true,
            ),


            body: new CustomScrollView(
              //color: Colors.blue.shade50,
              //margin: EdgeInsets.only(top: 5.0),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: SearchBar(onChange: (value){
                      setState(() {
                        produitsAff = produits.where((element) =>
                            element.nom.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    }),
                  ),
                ),

                if(produitsFavoris.isNotEmpty)

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Les produits favoris',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 5.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        DescriptionProduit(produit: produitsFavoris[i],
                                          inPanier: false, boutton: true,)));
                                  },
                                  child: FavoriteCard(produit: produitsFavoris[i])
                              ),
                            );
                          },
                          itemCount: produitsFavoris.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),

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

                SliverList(delegate: SliverChildListDelegate(
                    List.generate(produitsAff.length, (int index) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    DescriptionProduit(produit: produitsAff[index],
                                      inPanier: false, boutton: true,)));
                              },
                              child: ProduitCard(produit: produitsAff[index])
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0.0),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push( context, new MaterialPageRoute(builder: ( BuildContext context) {
                              return new AfficherPanier();
                            }
                            )
                            );
                          },
                          child: Text('Voir le panier',
                            //textScaleFactor: 1.5,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            )
        )
    );
  }
}
