import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';
import 'package:genie/src/backend/modeles/produit.dart';
import 'package:genie/src/frontend/screens/screen1.dart';

void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //await GenieFirebase.add("produits", {'nom': "riz", 'prix': 25} );
  Produit p = Produit(id: '12', image: 'assets/images/D5.jpg', nom: 'Pro24', description: "Dans la culture occidentale moderne, le dessert est le dernier plat servi au cours d'un repas, typiquement composé d'aliments sucrés : fruits, pâtisseries, sorbets, flans, etc. Ils peuvent être consommés avec une fourchette ou avec une cuillère à dessert, d'une taille intermédiaire entre la cuillère à café et la cuillère à soupe. Dans une acception plus ancienne, le dessert comprenait aussi le fromage.", type: TypeProduit.dessert, prix: 5);
  //await GenieFirebase.add("produit", p.toMap());
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Au Restau',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Au Restau'),
    );
  }
}
