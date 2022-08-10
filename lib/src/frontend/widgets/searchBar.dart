import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SearchBar() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
    child: CupertinoSearchTextField(
        padding: EdgeInsets.all(15),
        prefixInsets: EdgeInsets.only(left: 15),
        placeholder: 'Rechercher',
        prefixIcon: Icon(Icons.search),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: List.generate(4, (index) {
              return BoxShadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  color: Colors.grey.shade100
              );
            }))
    ),
  );
}