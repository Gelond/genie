
import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_commande.dart';
import 'package:genie/src/frontend/widgets/produitCard.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../backend/modeles/commande.dart';
import '../screens/pageDescriptionProduit.dart';
import 'commandeItemCard.dart';

class CommandeCard extends StatefulWidget {
  final Commande commande;
  final int index;
  final bool cuisinier;
  const CommandeCard({Key? key, required this.commande, required this.index, required this.cuisinier}) : super(key: key);

  @override
  State<CommandeCard> createState() => _CommandeCardState();
}

class _CommandeCardState extends State<CommandeCard> {

  late int etat;
  final _key = GlobalKey<FormState>();

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;

  final List<Map<String, dynamic>> _items = [
    {
      'value' : '0',
      'label' : 'Commandée'
    },
    {
      'value' : '1',
      'label' : 'En cours de traitement'
    },
    {
      'value' : '2',
      'label' : 'Prête'
    },
    {
      'value' : '3',
      'label' : 'Servie'
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Détails sur la commande',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),

          leading: new IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back,)
          ),

          centerTitle: true,
        ),

        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 10,),

              Text('Commande',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              ),

              SizedBox(height: 12,),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Id: ${widget.commande.id}", style: TextStyle(fontSize: 15),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Text("Table: ${widget.commande.table}", style: TextStyle(fontSize: 15)),
                      SizedBox(height: 12,),
                      if(widget.commande.emporter)
                        Text('Type: Emporter', style: TextStyle(fontSize: 15) ),
                      if(!widget.commande.emporter)
                        Text('Type: Servir sur place', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 12,),
                      Text('Etat: ${widget.commande.EtatString()}', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 12,),

                      if(widget.commande.etat != EtatCommande.servi && widget.cuisinier == true)
                        Form(
                          child: Column(
                            children: [
                              //key: _key,
                              SelectFormField(
                                type: SelectFormFieldType.dropdown,
                                labelText: "Changer l'état de commande",
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
                                onSaved: (val) async
                                {
                                      setState(() {
                                        _valueSaved = val ?? '';
                                        widget.commande.etat = EtatCommande
                                            .values[int.parse(_valueSaved)];
                                        print(val);
                                      });
                                      await FirebaseCommande.updateCommande(
                                          widget.commande);
                                    }),
                            ],
                          )
                      ),

                      SizedBox(height: 10,),
                      Text("Composée de:", style: TextStyle(fontSize: 15))
                      //Text("data")
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate(
                            List.generate(widget.commande.commandeItems.length, (int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  DescriptionProduit(produit: widget.commande.commandeItems[index].produit!,
                                    inPanier: false, boutton: false,)));
                            },
                            child: CommandeItemCard(produit: widget.commande.commandeItems[index].produit!,
                              quantite: widget.commande.commandeItems[index].quantity,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                            child: Divider(),
                          )
                        ],
                      );
                    }
                    )
                    )
                    ),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}
