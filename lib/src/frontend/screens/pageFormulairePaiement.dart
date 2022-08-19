import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class FormulairePaiement extends StatefulWidget {
  const FormulairePaiement({Key? key}) : super(key: key);

  @override
  State<FormulairePaiement> createState() => _FormulairePaiementState();
}

class _FormulairePaiementState extends State<FormulairePaiement> {

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController? _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  late bool checkedValue = false;



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

  final List<Map<String, dynamic>> _items = [
    {
      'value' : 'Entree',
      'label' : 'Entree'
    },
    {
      'value' : 'Plat de résistance',
      'label' : 'Plat de résistance'
    },
    {
      'value' : 'Dessert',
      'label' : 'Dessert'
    },
    {
      'value' : 'Boisson',
      'label' : 'Boisson'
    }
  ];

  List<String> item = [
    'assets/images/t.jpg',
    'assets/images/D6.jpg',
    'assets/images/E16.jpg',
    'assets/images/b.jpg',
    'assets/images/D9.jpg',
    'assets/images/R17.jpg',
    'assets/images/tc.jpg',
  ];

  /*Widget carou() = Container(
    height: MediaQuery.of(context).size.height/4,
    child: CarouselSlider (
      boxFit: BoxFit.fill,
      images: [
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
        'assets/images/t.jpg',
      ]
    ),
  );*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ggdhdhjhjedhjhjd'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _oFormKey,
          child: Column(
            children: [
              Container(
                child: Center(
                  child: CarouselSlider(
                    carouselController: CarouselController(),
                    options: CarouselOptions(
                        height: 300.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 1),
                      //autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    items: item.map((e) {
                      return Builder(
                          builder: (BuildContext) {
                            return Container(
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:3),
                                    child: Image.asset(e, fit: BoxFit.cover,),
                                  ),
                                  height: MediaQuery.of(context).size.width,
                                ),
                              ),
                            );
                           /* return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 0.5),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                              ),
                              child: Image.asset(e, fit: BoxFit.cover,),
                              //child: Text("Texte $e", style: TextStyle(fontSize: 16.0),
                              );*/

                          }
                      );
                    }).toList(),
                  ),
                ),
              ),
              Column(
                children: [
                  SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    labelText: 'choix',
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
                    onSaved: (val) => setState(() => _valueSaved = val ?? ''),
                  ),

                  CheckboxListTile(
                    title: Text("isFavorite"),
                      value: checkedValue,
                      onChanged: (newValue){
                      setState( () {
                        checkedValue = newValue!;
                  });
                  },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
