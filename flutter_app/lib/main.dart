import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/productMagasinsList.dart';
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner:false,
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => new Home(),
        "/prodmagspage": (BuildContext context) => new ProductMagasinsList(),
      },
      initialRoute: "/home",
      title: 'Flutter Nav',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}