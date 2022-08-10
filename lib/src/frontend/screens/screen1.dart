import 'package:flutter/material.dart';
import 'package:genie/src/frontend/screens/pageConnexion.dart';
import 'package:genie/src/frontend/screens/pageMenu.dart';
import 'package:genie/src/frontend/widgets/customText.dart';

import '../../backend/base_donnees/dataProduits.dart';
import '../../backend/base_donnees/firebase_management.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Au Restau',
          style: TextStyle(
            fontSize: 20
          ),
          ),
          centerTitle: true,

          actions: [
            DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  items: [

                    DropdownMenuItem(
                      child: Text('Menu', style: TextStyle(color: Colors.white),),
                      value: 'Menu',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PageMenu()));
                      },
                    ),

                    DropdownMenuItem(
                      child: Text('Commandes', style: TextStyle(color: Colors.white),),
                      value: 'Commandes',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SeConnecter()));
                      },
                    )
                  ],
                  onChanged: (val) => {},
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.more_vert, color: Colors.white, size: 25,),
                  ),
                )
            )
          ],
        ),

        drawer: Drawer(
          backgroundColor: Colors.white,
          width: MediaQuery.of(context).size.width/2.3,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Text('Se connecter',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    //color: Colors.black,
                  ),
                ),
                /*decoration: BoxDecoration(
                  //color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/r.png')
                    )
                ),*/
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Gérant'),
                onTap: () async {
                  await GenieFirebase.add('produits', produits.first.toMap());
                }
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Cuisinier'),
                onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>SeConnecter()))},
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
                        width: MediaQuery.of(context).size.width-10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top:3),
                              child: Image.asset('images/restau.jpg', fit: BoxFit.cover,),
                            ),
                            height: MediaQuery.of(context).size.width,
                          ),
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

            new CustomText('Buen Provecho', factor: 2.0, color: Colors.black),

          ],
        )
    );
  }
}