import 'package:email_validator/email_validator.dart';
//import 'package:fluter1/screens/pageMenu.dart';
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/dataProduits.dart';
import 'package:genie/src/backend/base_donnees/firebase_commande.dart';
import 'package:genie/src/backend/base_donnees/local_db_manager.dart';
import 'package:genie/src/backend/modeles/commande.dart';
import 'package:genie/src/backend/modeles/commandeItem.dart';
import 'package:genie/src/frontend/screens/pageMenu.dart';
import 'package:select_form_field/select_form_field.dart';

class FormulaireCommande extends StatefulWidget {
  final List<CommandeItem> items;
  const FormulaireCommande({Key? key, required this.items}) : super(key: key);

  @override
  State<FormulaireCommande> createState() => _FormulaireCommandeState();
}

class _FormulaireCommandeState extends State<FormulaireCommande> {
  late LocalBdManager localBdManager = LocalBdManager();

  late String _nom;
  late bool _emporter = false;
  late int _numTab;


  final _key = GlobalKey<FormState>();

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;
  final List<Map<String, dynamic>> _items = [
    {
      'value' : 'Servir sur table',
      'label' : 'Servir sur table'
    },
    {
      'value' : 'Emporter',
      'label' : 'Emporter'
    },
  ];
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        _controller?.text = 'circleValue';
      });
    });
  }

  @override
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    _controller = TextEditingController(text: '2');

    _getValue();
  }


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
                      padding: const EdgeInsets.only(left: 15.0),
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

                                  Container(
                                    height: MediaQuery.of(context).size.height/3+30,
                                    width: MediaQuery.of(context).size.width-10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:3),
                                          child: Image.asset('assets/images/t.jpg', fit: BoxFit.cover,),
                                        ),
                                        height: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10,),

                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length !=0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez le num??ro de votre table";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _numTab = int.parse(v!);
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

                                  CheckboxListTile(
                                    title: Text("Emporter"),
                                    value: _emporter,
                                    onChanged: (newValue){
                                      setState( () {
                                        _emporter=  newValue!;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                  /*SelectFormField(
                                    type: SelectFormFieldType.dropdown,
                                    labelText: 'Choisissez le type de commande',
                                    items: _items,
                                    /*onChanged: (val) {
                                    print(val);
                                    },
                                    onSaved: (val) => print(val),*/
                                    dialogCancelBtn: 'Annuler',
                                    enableSearch: true,
                                    dialogSearchHint: 'Search item',
                                    onChanged: (val) => setState(() => _valueChanged = val),
                                    validator: (val) {
                                      setState(() => _valueToValidate = val ?? '');
                                      return null;
                                    },
                                    onSaved: (val) {
                                      setState(() => _valueSaved = val ?? '');
                                      _type = _valueSaved;
                                    }
                                  ),*/

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length != 0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez nom";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _nom = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Nom:'), hintText: "Ex: Brel",

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


                                  SizedBox(width: MediaQuery.of(context).size.width/3,),

                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_key.currentState!.validate()) {
                                          _key.currentState!.save();
                                          //print(_numTab);
                                          //print(_emporter);
                                         // print(_nom);
                                          Commande c = Commande(id: '', table: _numTab, commandeItems: widget.items,
                                              nomClient: _nom, emporter: _emporter);
                                          await FirebaseCommande.addCommande(c);
                                          await localBdManager.viderPanier();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PageMenu()));
                                        }
                                      },
                                      child: Text('Envoyer'),
                                    ),
                                  )

                                  /*TextFormField(
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
                                  ),*/

                                  //SizedBox(height: 12,),
                                  /*SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length >= 8) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez votre num??ro";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _tel = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('T??l??phone:'), hintText: "Ex: +229 66660101",

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

                                  SizedBox(height: 15,),*/

                                  /*TextFormField(
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
                                  ),*/
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
