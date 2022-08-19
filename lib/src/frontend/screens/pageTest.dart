import 'package:flutter/material.dart';
import 'package:genie/src/backend/base_donnees/firebase_management.dart';

class TestFutureBuilder extends StatefulWidget {
  const TestFutureBuilder({Key? key}) : super(key: key);

  @override
  State<TestFutureBuilder> createState() => _TestFutureBuilderState();
}

class _TestFutureBuilderState extends State<TestFutureBuilder> {
  @override
  /*
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: GenieFirebase.getAllDocOfCollection('produits').asStream(),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snap){
            if (snap.hasData) {
              return ListView(children: List.generate(snap.data!.length, (index) {
              return ListTile(title: Text(snap.data![index]['nom']),);
            }) );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }

      ),
    );
  }
  */
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GenieFirebase.getAllDocOfCollection('produits'),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snap){
          if (snap.hasData) {
            return ListView(children: List.generate(snap.data!.length, (index) {
            return ListTile(title: Text(snap.data![index]['nom']),);
          }) );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
