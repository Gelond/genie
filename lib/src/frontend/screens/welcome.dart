import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_personnel.dart';
import 'package:genie/src/backend/modeles/personnel.dart';
import 'package:genie/src/frontend/screens/pageCommandes.dart';
import 'package:genie/src/frontend/screens/pageConnexion.dart';
import 'package:genie/src/frontend/screens/screen1.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if(user == null)
      return SeConnecter();
    else {
      return FutureBuilder(
          future: FirebasePersonnel.getPersonnelByUid(user.uid),
          builder: (BuildContext context, AsyncSnapshot<Personnel?> snap){
            if (snap.hasData) {
              return MyHomePage(title: '');
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }
      );
    }
  }
}
