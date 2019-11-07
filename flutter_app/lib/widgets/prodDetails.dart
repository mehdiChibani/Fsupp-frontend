import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Widget ProdDetails() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(child: Text("Pain Briochée  ",
          style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
      ),
      Container(child: Text("Boulangerie   ",
        style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
    ],
  );
}