import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../routes/routes.dart';
import '../dtos/dtoCmd.dart';
class Panier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _Panier();
}

class _Panier extends State<Panier> {
  double totale=0;
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

  Future<DtoCmd> createPost(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return DtoCmd.fromJson(json.decode(response.body));
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
            Container(
              margin: EdgeInsets.fromLTRB(0, 7, 17, 0),
              child: Badge(
                badgeContent: Text("0"),
                child: Icon(
                  Icons.shopping_basket,
                  size: 35,
                ),
              ),
            )
          ],
          backgroundColor: Colors.deepOrange[200],
          title: new Text(
            "Commandes",
            style: TextStyle(fontFamily: "Merriweather"),
          ),
        ),
        body: Column(children: <Widget>[
          Container(
            child: Image(image: AssetImage("assets/images/commande.jpg"),),
          ),
          Container(padding: EdgeInsets.only(top: 10),
            child: Center(
              child: RaisedButton(
                color: Colors.deepOrange[200],
                onPressed: () async {
                  DtoCmd newPost = new DtoCmd(
                      date:new DateTime.now(),totale:totale, etat:'nonlivre');
                  DtoCmd p = await createPost(Routes.apiUrl+'lgncmd',
                      body: newPost.toMap());

                  print(newPost.toMap());
                },
                child: Text('Passer la commande', style: TextStyle(fontSize: 20)),
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
