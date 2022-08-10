
import 'package:flutter/material.dart';

import '../../backend/base_donnees/dataCommandes.dart';
import '../../backend/modeles/commande.dart';
import '../widgets/commandeCard.dart';
import '../widgets/customTabBar.dart';
import '../widgets/searchBar.dart';

class Commandes extends StatefulWidget {
  const Commandes({Key? key}) : super(key: key);

  @override
  State<Commandes> createState() => _CommandesState();
}

class _CommandesState extends State<Commandes> {

  int _selectedIndex = 0;
  List<String> tabBars = ['Toutes', 'Non traitées', 'En cours de traitement', 'Prêtes', 'Servies'];
  //List<Produit> produitsAff = produitsCommandees;
  List<Commande> commandesAff = commandes;

  void _trier(int index)
  {
    if (index == 0) {
      commandesAff = commandes;
    }

    else if (index == 1) {
      var list = commandes.where((c) => c.etat == EtatCommande.commandee);
      commandesAff = list.toList();
    }

    else if (index == 2) {
      var list = commandes.where((c) => c.etat == EtatCommande.traitement);
      commandesAff = list.toList();
    }
    else if (index == 3) {
      var list = commandes.where((c) => c.etat == EtatCommande.pret);
      commandesAff = list.toList();
    }

    else if (index == 4) {
      var list = commandes.where((c) => c.etat== EtatCommande.servi);
      commandesAff = list.toList();
    }
  }

  @override
  Widget build(BuildContext context) {

    MaterialStateProperty<Color> getColor(Color color, Color colorPressed){
      final getColor = (Set<MaterialState> states) {
        if(states.contains(MaterialState.pressed ))
          return colorPressed;

        else
          return color;
      };
      return MaterialStateProperty.resolveWith(getColor);
    }

    return DefaultTabController(
      length: tabBars.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Les commandes',
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

          /*actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: new Icon(Icons, size: 35.0, semanticLabel: 'Personnel',),
            )
          ],*/

          centerTitle: true,
        ),

        body: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(

              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SearchBar(),
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
            //SizedBox(height: 10,),

            SliverList(delegate: SliverChildListDelegate(List.generate(commandesAff.length, (int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CommandeCard(commande: commandesAff[index], index: index)));
                      },
                      child: Text("Commande ${index +1}: Id ${commandesAff[index].id}", style: TextStyle(fontSize: 23),),
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
    );
  }
}
