import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../routes/routes.dart';
import '../pages/prodtypebymag.dart';
class MagsbyCateg extends StatefulWidget {
  final int id;
  MagsbyCateg({Key key, @required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState()=> new _MagsbyCateg(id: id);}
class _MagsbyCateg extends State<MagsbyCateg>{
  final int id;
  _MagsbyCateg({Key key, @required this.id});
  final String url =Routes.apiUrl+"getmagsbytype/";
  List data;
  Future<String> getmags(String id) async{
    var res=await http.get(Uri.parse(url+id), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["data"];
    });

    return "Success!";
  }
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
            "Magasins",
            style: TextStyle(fontFamily: "Merriweather"),
          ),
        ),
        body:
        ListView.builder(
            itemCount: data==null?0 : data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProdTypesbyMag(id:data[index]["idMag"] ),
                    ),
                  );},
                  child:
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300])
                        ),
                        padding: EdgeInsets.fromLTRB(3,0,8,0),
                        height: 100,
                        child:FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    width: 255,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 2.0),
                                                  child: Container(child: Text(data[index]["nomSt"]+" ",
                                                    style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
                                                ),
                                                Container(child: Text(data[index]["nomCateg"],
                                                  style: TextStyle(color: Colors.black54, fontSize: 20.0,fontWeight: FontWeight.bold),)),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                                Column(crossAxisAlignment:CrossAxisAlignment.end,children: <Widget>[
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(left: 20),
                                    height: 180,
                                    child: ClipRRect(
                                      borderRadius: new BorderRadius.circular(24.0),
                                      child: Image.network(Routes.imgs+data[index]["imageSt"],alignment: Alignment.center,fit: BoxFit.fill,),
                                    ),
                                  )
                                ],),
                              ],
                            ),
                          ),)
                    ),

                  ));
            }
        )
/*
        ListView.builder(
            itemCount: data==null?0 : data.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 5),
            itemBuilder: (BuildContext context, int index) { return new
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Color(0x802196F3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child:Image(
                          image: new NetworkImage(
                              "http://192.168.1.6/fsupApi/images/"+data[index]["image"],),
                          width: 100,
                          height: 200,
                        ) ,padding: EdgeInsets.only(left: 10),)
                      ,
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(padding:EdgeInsets.fromLTRB(7,14,0,0),
                                  child: Text(
                                    data[index]["nom"],
                                    style: TextStyle(
                                        color: Color(0xffe6020a),
                                        fontWeight: FontWeight.bold,fontSize: 24),
                                  )
                              ),
                              Container(
                                  child: Text(
                                      data[index]["reference"],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,fontSize: 20),
                                  )),
                            ],
                          )),
                      Container(
                        alignment:Alignment(1.0,0.0),
                        child: Icon(Icons.arrow_forward_ios,color: Colors.blueGrey,),),
                    ],
                  ),
                ),
              ),
            );
            }
        ),*/
    );
  }
  @override
  void initState() {
    super.initState();
    this.getmags(this.id.toString());
  }
}
