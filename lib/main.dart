import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';
import 'package:genie/src/backend/base_donnees/genieAuth.dart';
import 'package:genie/src/backend/modeles/produit.dart';
import 'package:genie/src/frontend/screens/pageCommandesClients.dart';
import 'package:genie/src/frontend/screens/pageFormulaireAjouterProduit.dart';
import 'package:genie/src/frontend/screens/pageFormulaireCommande.dart';
import 'package:genie/src/frontend/screens/pageFormulairePaiement.dart';
import 'package:genie/src/frontend/screens/pageInscription.dart';
import 'package:genie/src/frontend/screens/pageListeMenus.dart';
import 'package:genie/src/frontend/screens/pageListeproduits.dart';
import 'package:genie/src/frontend/screens/pageTest.dart';
import 'package:genie/src/frontend/screens/screen1.dart';
import 'package:genie/src/frontend/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(create: (context)=>GenieAuthService.authStateChanges,
            initialData: GenieAuthService.auth.currentUser)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        //home: ListePoduits(),
        //home: FormulaireAjouterProduit(),
        //home: FormulairePaiement(),
        //home: FormulaireCommande(),
        //home: CommandesDesClients(),
        //home: Inscription(),
        home: const MyHomePage(title: ''),
        //home: Welcome(),
      ),
    );
  }
}
