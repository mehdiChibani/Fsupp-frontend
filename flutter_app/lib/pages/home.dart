import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/products.dart';
import '../widgets/MyDrawer.dart';
import '../routes/routes.dart';
import '../pages/magsbycateg.dart';
class Home  extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new _HomeState();
  }
  class _HomeState extends State<Home>{
    final String url =Routes.apiUrl+"categ";
    List data;
    Future<String> getCategs() async{
      var res=await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

      setState(() {
        var resBody = json.decode(res.body);
        data = resBody["data"];
      });

      return "Success!";
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlutterStatusbarcolor.setStatusBarColor(Colors.deepOrange[300]);
    return new
    SafeArea(child:
    Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0,7,17,0),
            child: Badge(
              badgeContent: Text("0"),
              child: Icon(Icons.shopping_basket,size: 35,),
            ),
          )

        ],
        backgroundColor: Colors.deepOrange[200],
        title: new Text("Acceuil",style: TextStyle(
        fontFamily: "Merriweather"
      ),),),
      drawer: MyDrawer(),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
      new Column(
        children: <Widget>[
          Row(children: <Widget>[
            SizedBox(width: 25,),
            Text("F_",style: TextStyle(fontFamily: "Pacifico",fontSize: 30,color: Colors.grey[800]),),
            Text("suPp",style: TextStyle(fontFamily: "Pacifico",fontSize: 30,color: Colors.grey[700]),),
          ],),
          SizedBox(height: 10,),
        Container(
          height: 170.0,
          child: ListView.builder(
              itemCount: data==null?0 : data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return new
                GestureDetector(onTap: (){Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MagsbyCateg(id:data[index]["idCateg"] ),
                  ),
                );},child:  Container(
                  height: 190,
                  width: 190,
                  child:
                  Card(
                    child: Hero(
                      tag: 'tag'+data[index]["nomCateg"]
                      ,child: InkWell(
                      child: GridTile(
                        footer: Container(
                          height: 40,
                          color: Colors.white54,
                          child: Text(data[index]["nomCateg"], style: TextStyle(fontFamily: "SourceSansPro",fontSize: 25,),),
                        ),
                        child: Image.network(Routes.imgs+data[index]["image"],fit: BoxFit.fill,),
                      ),
                    ),
                    ),

                  ),
                ),)
               ;}

          ),
        ),
          Column(children: <Widget>[
            Products()
          ],)



        ],
      ),)

      ),
    );
        
    
  }
    @override
    void initState() {
      super.initState();
      this.getCategs();
    }

  }
