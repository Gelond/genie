import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/frontend/screens/pageCommandes.dart';

class SeConnecter extends StatefulWidget {
  const SeConnecter({Key? key}) : super(key: key);

  @override
  State<SeConnecter> createState() => _SeConnecterState();
}

class _SeConnecterState extends State<SeConnecter> {

  late String _login = '';
  late String _pw = '';
  //late String _type;
  final _key = GlobalKey<FormState>();
  bool _isSecret = true;
  final RegExp loginRule = RegExp(r"[a-z0-9\._]+@[a-z0-9\._] +\.+[a-z]+");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Connexion',
              style: TextStyle(
                  fontSize: 23.0
              ),
            ),

            leading: new IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back,)
            ),
          ),

          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/4-10,
                      width: MediaQuery.of(context).size.width-10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top:3),
                            child: Image.asset('assets/images/con.png', fit: BoxFit.cover,),
                          ),
                          height: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Form(
                        key: _key,
                        child: Column(
                          children: [

                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                //cursorColor: Colors.blue,

                                /*onChanged: (value) => setState(() {
                                _login = value;
                              }
                              ),*/

                                validator: (String? v) {
                                  if( v != null && EmailValidator.validate(v) )
                                  {
                                    return null;
                                  }
                                  else
                                  {
                                    return "Login invalide";
                                  }
                                },
                                onSaved: (String? v) {
                                  _login = v!;
                                },
                                decoration: InputDecoration(
                                    label: Text('Login:'), hintText: "Ex: personnel12@gmail.com",

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

                            SizedBox(height: 10,),

                            TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) => setState(() {
                                  _pw = value;
                                }),
                                obscureText: _isSecret,
                                validator: (String? v)
                                {
                                  if (v != null && v.length >= 8 )
                                  {
                                    return null;
                                  }

                                  /*else if( v.length >= 8 )
                                    {
                                      return "Mot de passe incorrect";
                                    }*/

                                  else {
                                    return "Mot de passe invalide";
                                  }
                                },
                                onSaved: (String? v) {
                                  _pw = v!;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () => setState(() {
                                        _isSecret = !_isSecret;
                                      }),
                                      child: Icon( !_isSecret ? Icons.visibility : Icons.visibility_off),
                                    ),

                                    label: Text('Password:'), hintText: "Ex: ............",

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

                            SizedBox(height: 10,),

                            RaisedButton(
                              elevation: 10,

                              onPressed: ()
                              {
                                if (_key.currentState!.validate())
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Commandes()));
                                  print(_login);
                                  print(_pw);
                                }
                              },

                              color: Colors.blue.shade600,
                              child: Text('Se connecter',
                                style: TextStyle(
                                  // fontSize: ,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            InkWell(
                                child: Text('Mot de passe oublié ?',
                                  style: TextStyle(
                                    color: Colors.blue.shade400,
                                    fontSize: 20,
                                  ),
                                ),

                                onTap: () =>{}
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
