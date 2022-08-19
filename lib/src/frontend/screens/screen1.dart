import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_personnel.dart';
import 'package:genie/src/backend/base_donnees/genieAuth.dart';
import 'package:genie/src/backend/modeles/personnel.dart';
import 'package:genie/src/frontend/screens/pageCommandes.dart';
import 'package:genie/src/frontend/screens/pageCommandesClients.dart';
import 'package:genie/src/frontend/screens/pageConnexion.dart';
import 'package:genie/src/frontend/screens/pageListeMenus.dart';
import 'package:genie/src/frontend/screens/pageListeproduits.dart';
import 'package:genie/src/frontend/screens/pageMenu.dart';
import 'package:genie/src/frontend/widgets/customText.dart';
import 'package:provider/provider.dart';

import '../../backend/base_donnees/dataProduits.dart';
import '../../backend/base_donnees/firebase_management.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int? numTab;
  final _key = GlobalKey<FormState>();

  List<String> item = [
    'images/restau.jpg',
    'assets/images/D8.jpg',
    'assets/images/a13.jpg',
    'assets/images/a4.jpg',
    'assets/images/a3.jpg',
    'assets/images/a6.jpg',
    'assets/images/a18.jpg',
    'assets/images/R18.jpg',
    'assets/images/a7.jpg',
    'assets/images/R14.jpg',
    'assets/images/a9.jpg',
    'assets/images/D6.jpg',
    'assets/images/a16.jpg',
    'assets/images/b.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('GéoFood',
          style: TextStyle(
            fontSize: 20
          ),
          ),
          centerTitle: true,
        ),

        drawer: Drawer(
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width/2,
          child: ListView(
            children: [
              SizedBox(height: 12,),

              if(user == null)
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Se connecter', style: TextStyle(fontSize: 13),),
                onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>SeConnecter()))},
              ),

              if(user != null)
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Se deconnecter', style: TextStyle(fontSize: 10),),
                onTap: () async {
                  await GenieAuthService.auth.signOut();
                  setState(() {

                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text('Menu', style: TextStyle(fontSize: 13),),
                onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>PageMenu()))},
              ),
              if(user == null)
              ListTile(
                leading: Icon(Icons.food_bank),
                title: Text('Commandes', style: TextStyle(fontSize: 13),),
                onTap: () {

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actionsAlignment:
                        MainAxisAlignment.spaceAround,
                        title: Text('Entrez le numero de votre table'),
                        content: Form(
                          key: _key,
                          child: TextFormField(
                            validator: (String? v) {
                              if (v != null && v.length !=0) {
                                return null;
                              }
                              else {
                                return "Entrez le numéro de votre table";
                              }
                            },
                            onSaved: (String? v) {
                              numTab = int.parse(v!);
                            },
                          ),
                        ),

                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  _key.currentState!.save();
                                Navigator.of(context).pop(numTab);
                                }
                              },
                              child: Text("Ok"),
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
                    if(value != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          CommandesClient(kitchen: false, numTab: value,)));
                    }
                  });

                  },
              ),

              if(user != null)
                FutureBuilder(
                  future: FirebasePersonnel.getPersonnelByUid(user!.uid),
                  builder: (BuildContext context, AsyncSnapshot<Personnel?> snap){
                    if (snap.hasData) {
                      if(snap.data!.type == TypePersonnel.gerant)
                        {
                          return ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Gérant', style: TextStyle(fontSize: 13),),
                            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>ListeMenus()))},
                          );
                        }
                      else
                        {
                          return ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Cuisinier', style: TextStyle(fontSize: 13),),
                            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>Commandes(kitchen: true)))},
                          );
                        }
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
            ],
          ),
        ),

        body: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Card(
                    child: Padding(padding: const EdgeInsets.all(8.0),
                      child: new Text('Welcome',
                        style: TextStyle(
                            color: Colors.deepPurple.shade700,
                            fontStyle: FontStyle.italic,
                            fontSize: 60.0
                        ),
                      ),
                    ),
                    elevation: 10.0,
                    color: Colors.blueGrey.shade50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: new ListView(
                children: [
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                    Padding(padding: const EdgeInsets.all(15.0),
                      child: new Text('Ici, nous vous proposons de meuilleurs déjeuners, plats et desserts, élaborés dans un décor feutré en plein coeur.\nNous avons le plaisir de vous proposer une large selection de menus, servie sur place ou à emporter. Notre écailler sera ravi de vous conseiller sur nos menus.',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                      Container(
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width+50,

                        child: CarouselSlider(
                          carouselController: CarouselController(),
                          options: CarouselOptions(
                            height: 300.0,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 1),
                            //autoPlayAnimationDuration: const Duration(seconds: 1),
                          ),
                          items: item.map((e) {
                            return Builder(
                                builder: (BuildContext) {
                                  return Container(
                                    //height: MediaQuery.of(context).size.height/4,
                                    //width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:3),
                                          child: Image.asset(e, fit: BoxFit.cover,),
                                        ),
                                        height: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  );
                                }
                            );
                          }).toList(),
                        ),
                      ),

                    new RaisedButton(
                      elevation: 10.0,
                      onPressed: ()
                      {
                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)
                        {
                          return new PageMenu();
                        }));
                      },
                      child: new Text('Consultez le menu',
                        textScaleFactor: 2.0,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          //fontSize: 10.0,
                          color: Colors.deepPurple,
                        ),
                      ),
                      color: Colors.blueGrey.shade50,
                    ),

                    /*new FlatButton(
                        onPressed: null,
                        child: new CustomText('Statut', factor: 1.5, color: Colors.deepPurple)
                    ),*/

                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width/1.3,),

                          /*ElevatedButton(
                              onPressed: ()=>{},

                              child: Text('Statut',
                                style: TextStyle(
                                  // fontSize: 13
                                ),)
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            new CustomText('Buen Provecho !', factor: 2.0, color: Colors.black),

          ],
        )
    );
  }
}