import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../routes/routes.dart';
import '../dtos/dtoPanAdd.dart';
import '../pages/panier.dart';
import 'package:toast/toast.dart';
class PanAdd extends StatefulWidget {
  final int id;
  final double idm;
  PanAdd({Key key, @required this.id, @required this.idm}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _PanAdd(id: id, idm: idm);
}

class _PanAdd extends State<PanAdd> {
  final int id;
  final double idm;
  int selectitem = 1;
  double totale=0;
  _PanAdd({Key key, @required this.id, @required this.idm});
  final String url = Routes.apiUrl + "getProdsBySt/";
  List data;
  Future<String> getprod(String id, String idm) async {
    var res = await http.get(Uri.parse(url + id + '/' + idm),
        headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["data"];
    });

    return "Success!";
  }

  Future<PanDto> createPost(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
print(response.statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return PanDto.fromJson(json.decode(response.body));
    });
  }

// Call Web services
  /*new RaisedButton(
  onPressed: () async {
  Post newPost = new Post(
      userId: "123", id: 0, title: titleControler.text, body: bodyControler.text);
  Post p = await createPost(CREATE_POST_URL,
  body: newPost.toMap());
  print(p.title);
},*/
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            GestureDetector(

              child: Container(
                margin: EdgeInsets.fromLTRB(0, 7, 17, 0),
                child: Badge(
                  badgeContent: Text("0"),
                  child: Icon(
                    Icons.shopping_basket,
                    size: 35,
                  ),
                ),
              ) ,
              onTap:(){Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Panier(),
                ),
              );}
            )

          ],
          backgroundColor: Colors.deepOrange[200],
          title: new Text(
            "Panier",
            style: TextStyle(fontFamily: "Merriweather"),
          ),
        ),
        body:

        Column(children: <Widget>[
          Container(
            child: Image(image: AssetImage("assets/images/images.jpg"),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
            child: new Text(
              "Ajout du produit au panier :",
              style: TextStyle(fontFamily: "Merriweather", fontSize: 20),
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: CupertinoPicker(
              backgroundColor: Colors.grey[350],
              children: <Widget>[
                Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
              itemExtent: 50, //height of each item
              looping: true,
              onSelectedItemChanged: (int index) async {
                setState(() {
                  this.selectitem = index + 1;
                  this.totale=totale+(idm*selectitem);
                });
              },
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Total :" +' '+totale.toString()+' DH',
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
              )),
          Container(padding: EdgeInsets.only(top: 10),
            child: Center(
              child: RaisedButton(
                color: Colors.deepOrange[200],
                onPressed: () async {
                  PanDto newPost = new PanDto(
                      IdProd:id, totale:totale, QtCmd:this.selectitem);
                  PanDto p = await createPost(Routes.apiUrl+'lgnpan',
                      body: newPost.toMap());

                  print(newPost.toMap());
                  Toast.show("Produit ajouté", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                },
                child: Text('Ajouter au panier', style: TextStyle(fontSize: 20)),
              ),
            ),
          )
        ]));
  }

  @override
  void initState() {
    super.initState();
    //this.getprod(this.id.toString(), this.idm.toString());
  }
}
