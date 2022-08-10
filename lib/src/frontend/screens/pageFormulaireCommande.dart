import 'package:email_validator/email_validator.dart';
//import 'package:fluter1/screens/pageMenu.dart';
import 'package:flutter/material.dart';

class FormulaireCommande extends StatefulWidget {
  const FormulaireCommande({Key? key}) : super(key: key);

  @override
  State<FormulaireCommande> createState() => _FormulaireCommandeState();
}

class _FormulaireCommandeState extends State<FormulaireCommande> {

  late String _nom;
  late String _email;
  late String _tel;
  late String _type;
  late String _numTab;

  final _key = GlobalKey<FormState>();

  final RegExp emailRule = RegExp(r"[a-z0-9\._]+@[a-z0-9\._] +\.+[a-z]+");

  /*validationForm()
  {
    if( _key.currentState!.validate() )
      {
        _key.currentState!.save();
        debugPrint('$_numTab');
        debugPrint('$_nom');
        debugPrint('$_mail');
        debugPrint('$_address');
        debugPrint('$_tel');
        _key.currentState!.reset();
      }
    else
      {
        debugPrint('Erreur');
      }
  }*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Formulaire de commande',
            style: TextStyle(
                fontSize: 20.0
            ),

          ),
          //centerTitle: true,
          leading: new IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back,)
          ),
          /*actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: new Icon(Icons., size: 30.0, ),
            )
          ],*/
        ),

        body: Center(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  //SizedBox(height: 0,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all( 20.0),
                      child: Text('Remplissez ce formulaire pour valider votre commande...',
                        style: TextStyle(
                          //color: Colors.redAccent,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold
                        ),),
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                              key: _key,
                              child: Column(
                                children: [

                                  //SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length !=0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez le numéro de la table";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _numTab = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Table:'), hintText: "Ex: 25",

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(color: Colors.green),
                                          )
                                      )
                                  ),

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length >= 8) {
                                          return null;
                                        }
                                        else {
                                          return "Choisissez le type de commande";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _type = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Type de commande:'), hintText: "Ex: Emporter",

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(color: Colors.green),
                                          )
                                      )
                                  ),

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length != 0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez nom et Prénom";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _nom = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Nom et Prénom:'), hintText: "Ex: John Junior",

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(color: Colors.green),
                                          )
                                      )
                                  ),

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,

                                      validator: (String? v) {
                                        if (v != null && EmailValidator.validate(v) ) {
                                          return null;
                                        }
                                        else {
                                          return "Email invalide";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _email = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Email:'), hintText: "Ex: john.junior@gmail.com",

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(color: Colors.green),
                                          )
                                      )
                                  ),

                                  //SizedBox(height: 12,),
                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length >= 8) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez votre numéro";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _tel = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Téléphone:'), hintText: "Ex: +229 66660101",

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(0.0),
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            borderSide: BorderSide(color: Colors.green),
                                          )
                                      )
                                  ),

                                  SizedBox(height: 15,),

                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 25.0),
                                        child: ElevatedButton(
                                          onPressed: ()=>  Navigator.pop(context),
                                          child: Text("Annuler"),
                                        ),
                                      ),

                                      SizedBox(width: MediaQuery.of(context).size.width/3,),

                                      ElevatedButton(
                                        onPressed: () {
                                          if (_key.currentState!.validate()) {
                                            print(_numTab);
                                            print(_nom);
                                            print(_email);
                                            //print(_address);
                                            print(_tel);
                                          }
                                        },
                                        child: Text('Envoyer'),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
