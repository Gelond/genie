import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_produit.dart';
import 'package:genie/src/backend/modeles/produit.dart';
import 'package:select_form_field/select_form_field.dart';

class FormulaireAjouterProduit extends StatefulWidget {
  const FormulaireAjouterProduit({Key? key}) : super(key: key);

  @override
  State<FormulaireAjouterProduit> createState() => _FormulaireAjouterProduitState();
}

class _FormulaireAjouterProduitState extends State<FormulaireAjouterProduit> {

  late String image;
  late String _nom;
  late double _prix;
  late int _type;
  late int _disponibility;
  late String _description;
  late bool _isFavorite = false;
  late bool checkedValue = true;

  final _key = GlobalKey<FormState>();

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;

  final List<Map<String, dynamic>> _items = [
    {
      'value' : '0',
      'label' : 'Entrée'
    },
    {
      'value' : '1',
      'label' : 'Plat de résistance'
    },
    {
      'value' : '2',
      'label' : 'Dessert'
    },
    {
      'value' : '3',
      'label' : 'Boisson'
    }
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
          //centerTitle: true,

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
                    child: Container(
                      height: MediaQuery.of(context).size.height/5,
                      width: MediaQuery.of(context).size.width-10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top:3),
                            child: Image.asset('assets/images/ap.jpg', fit: BoxFit.cover,),
                          ),
                          height: MediaQuery.of(context).size.width,
                        ),
                      ),
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

                                  TextFormField(
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length !=0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez le nom du produit";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _nom = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Nom:'), hintText: "Ex: Pizza",

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
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length !=0) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez le prix du produit";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _prix = double.parse(v!);
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Prix(\$):'), hintText: "Ex: 20",

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

                                  SelectFormField(
                                    type: SelectFormFieldType.dropdown,
                                    labelText: 'Choisissez le type du produit',
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
                                    onSaved: (val) => setState(() {
                                      _valueSaved = val ?? '';
                                      _type =  int.parse(_valueSaved);
                                    }),
                                  ),

                                  /*TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length != 0) {
                                          return null;
                                        }
                                        else {
                                          return "Choississez le type du produit";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _type = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Type:'), hintText: "Ex: Plat de résistance",

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

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,

                                      validator: (String? v) {
                                        if (v != null && v.length !=0 ) {
                                          return null;
                                        }
                                        else {
                                          return "Entrez la quantité disponible";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _disponibility = int.parse(v!);
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Disponibilité:'), hintText: "Ex: 95",

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
                                    title: Text("isFavorite"),
                                    value: _isFavorite,
                                    onChanged: (newValue){
                                      setState( () {
                                        _isFavorite=  newValue!;
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,

                                      validator: (String? v) {
                                        if (v != null && v.length !=0 ) {
                                          return null;
                                        }
                                        else {
                                          return "Saisissez une description";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _description = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Description:'), hintText: "Ex: Pizza est bonne",

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

                                  /*SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,

                                      validator: (String? v) {
                                        if (v != null && v.length !=0 ) {
                                          return null;
                                        }
                                        else {
                                          return "Choisissez";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        _description = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('Description:'), hintText: "Ex: Pizza est bonne",

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

                                  SizedBox(height: 12,),

                                  TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      validator: (String? v) {
                                        if (v != null && v.length !=0) {
                                          return null;
                                        }
                                        else {
                                          return "image";
                                        }
                                      },
                                      onSaved: (String? v) {
                                        image = v!;
                                      },
                                      decoration: InputDecoration(
                                          label: Text('image:'), hintText: "images.png",

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
                                        onPressed: () async {
                                          if (_key.currentState!.validate()) {
                                            _key.currentState!.save();

                                            Produit p = Produit(id: '', image: 'assets/images/$image', nom: _nom, description: _description,
                                                type: TypeProduit.values[_type], prix: _prix, disponibility: _disponibility, isFavorite: _isFavorite);

                                            await FirebaseProduit.addProduit(p);
                                            Navigator.pop(context);
                                            //print(_nom);
                                            //print(_prix);
                                            //print(_type);
                                            //print(_disponibility);
                                            //print(_description);
                                            //print(_isFavorite);
                                          }
                                        },
                                        child: Text('Ajouter'),
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
