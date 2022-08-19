import 'package:flutter/material.dart';
import 'package:genie/src/frontend/screens/pageCommandes.dart';
import 'package:genie/src/frontend/screens/pageCommandesClients.dart';
import 'package:genie/src/frontend/screens/pageFormulairePaiement.dart';
import 'package:genie/src/frontend/screens/pageMenu.dart';

import '../../backend/base_donnees/dataMenus.dart';
import '../../backend/modeles/menu.dart';
import '../widgets/produitCard.dart';
import '../widgets/produitsMenuCard.dart';

class ListeMenus extends StatefulWidget {
  const ListeMenus({Key? key}) : super(key: key);

  @override
  State<ListeMenus> createState() => _ListeMenusState();
}

class _ListeMenusState extends State<ListeMenus> {
  int _selectedIndex = 0;
  List<Menu> menusAff = menus;
  @override
  Widget build(BuildContext context) {
    int l = menusAff.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Les menus',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 23.0,
              fontWeight: FontWeight.bold
          ),
        ),
        //backgroundColor: Colors.blueGrey.shade50,
        /*leading: new IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back,)
        ),*/
        centerTitle: true,

        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.add, size: 30,),
            ),

            onTap: () {},
          )
        ],
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width/2,
        child: ListView(
          children: [
            SizedBox(height: 12,),

            ListTile(
              leading: Icon(Icons.money),
              title: Text('Paiement', style: TextStyle(fontSize: 13),),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  FormulairePaiement()))}
            ),

            ListTile(
              leading: Icon(Icons.table_restaurant),
              title: Text('Réservation', style: TextStyle(fontSize: 13),),
              onTap: () => {},
            ),

            ListTile(
              leading: Icon(Icons.food_bank),
              title: Text('Commandes', style: TextStyle(fontSize: 13),),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Commandes(kitchen: false)))},
            ),

            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Menu', style: TextStyle(fontSize: 13),),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>PageMenu()))},
            ),
          ],
        ),
      ),

      body: DefaultTabController(
        length: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomScrollView(
            slivers: [

              SliverList(delegate: SliverChildListDelegate(List.generate(menusAff.length, (int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProduitsMenuCard(produits: menusAff[index].produits,)));
                            },
                            child: Row(
                              children: [
                                Text("${menusAff[index].nom}     ${menusAff[index].date}     ",),
                                //SizedBox(width: 5,),
                              ],
                            )
                          ),

                          InkWell(
                              onTap: () {

                              },
                              child: Icon(Icons.more_vert, size: 25,)
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                        child: Divider(),
                      )
                    ],
                  ),
                );
              }
              )
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}