import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_personnel.dart';
import 'package:genie/src/backend/modeles/personnel.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  FirebaseAuth auth = FirebaseAuth.instance;
  late Personnel courentPerson;

  final CollectionReference collectionReferenceection =
  FirebaseFirestore.instance.collection('users');



  bool _isSecret = true;
  bool _isSecret1 = true;
  String _nom = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    /*FirebaseAuth.instance.currentUser!.then((FirebasePersonnel personnel) {
      setState(() {
        this.courentPerson = personnel as Personnel;
      });
    });*/

    String getId(){
      if(courentPerson != null)
        return courentPerson.id;
      else return "Pas de personnel";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 23.0,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Image.asset("assets/images/i2.jpg", height: 100.0, width: 100.0,),
                SizedBox(height: 10.0,),
                Center(
                  child: Text('Créer un compte personnel',
                  style: Theme.of(context).textTheme.titleLarge,),
                ),
                SizedBox(height: 30.0,),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => setState(() {
                    _nom = value;
                  }),
                  decoration: InputDecoration(
                        label: Text('Nom complet'), hintText: "Ex: John Junior",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.green),
                        )
                    ),
                  //validator: (val) => val.isEmpty ? 'Entrer le nom complet' : null,
                  validator: (String? v) {
                    if (v != null && v.length !=0) {
                      return null;
                    }
                    else {
                      return "Entrez un nom complet";
                    }
                  },
                  onSaved: (v) => _nom = v!,
                ),

                SizedBox(height: 10.0,),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => setState(() {
                    _email= value;
                  }),
                    decoration: InputDecoration(
                        label: Text('Email'), hintText: "Ex: john.junior224@gmail.com",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.green),
                        )
                    ),
                  validator: (String? v) {
                    if( v != null && EmailValidator.validate(v) )
                    {
                      return null;
                    }
                    else
                    {
                      return "email invalide";
                    }
                  },
                  onSaved: (v) => _email = v!,
                ),

                SizedBox(height: 10.0,),

                TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                  onChanged: (value) => setState(() {
                    _email= value;
                  }),
                  obscureText: _isSecret,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () => setState(() {
                            _isSecret = !_isSecret;
                          }),
                          child: Icon( !_isSecret ? Icons.visibility : Icons.visibility_off),
                        ),
                        label: Text('Mot de passe'), hintText: "Ex: .........",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.green),
                        )
                    ),
                  validator: (String? v) {
                    if (v != null && v.length > 7) {
                      return null;
                    }
                    else {
                      return "Entrez un mot de passe d'au moins 8 caractères";
                    }
                  },
                  onSaved:  (v) => _password = v!,
                ),

                //SizedBox(height: 10.0,),

                /*TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: _isSecret1,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () => setState(() {
                            _isSecret1 = !_isSecret1;
                          }),
                          child: Icon( !_isSecret1 ? Icons.visibility : Icons.visibility_off),
                        ),
                        label: Text('Confirmez le mot de passe'), hintText: "Ex: .........",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.green),
                        )
                    ),

                  validator: (String? v) {
                    if (v != null && v == _password) {
                      return null;
                    }
                    else {
                      return "Le mot de passe ne correspond pas";
                    }
                  },
                  onChanged: (v) => _password = v,
                ),*/

                SizedBox(height: 20.0,),

                RaisedButton(
                  elevation: 10,
                  onPressed: () {
                    if(_key.currentState!.validate())
                      {
                        print(_nom);
                        print(_email);
                      }
                  },
                  color: Colors.blueGrey.shade500,
                  child: Text("S'nscrire",
                    style: TextStyle(
                      // fontSize: ,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
