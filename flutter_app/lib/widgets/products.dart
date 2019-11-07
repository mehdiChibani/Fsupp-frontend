import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/productMagasinsList.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../routes/routes.dart';
class Products extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new _ProductsState();
}
class _ProductsState extends State<Products>{
  final String url =Routes.apiUrl+"prodstypes";
  List data;
  Future<String> getprods() async{
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
  return new
  ListView.builder(
    itemCount: data==null?0 : data.length,
    shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
            onTap: (){Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductMagasinsList(id:data[index]["IdProd"] ),
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
                elevation: 15.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      width: 255,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(child: Text(data[index]["reference"]+"  ",
                              style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
                          ),
                          Container(child: Text(data[index]["nom"],
                            style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
                        ],
                      )
                    ),
                    Column(crossAxisAlignment:CrossAxisAlignment.end,children: <Widget>[
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(left: 20),
                        height: 180,
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(24.0),
                          child: Image.network(Routes.imgs+data[index]["image"],fit: BoxFit.fill,),
                        ),
                      )
                    ],),
                  ],
                ),
              ),)
        ),

      ));
      }
  );
}
  @override
  void initState() {
    super.initState();
    this.getprods();
  }
}