import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  static _gotoPage(String route, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(route);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              "Tom Ellis",
              style: TextStyle(fontFamily: "Oswald", fontSize: 20),
            ),
            accountEmail: new Text(
              "Tom_Ellis@Netflix.com",
              style: TextStyle(fontFamily: "Oswald", fontSize: 20),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/luci.jpg"),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/fsuppmenu.jpg"),
              ),
            ),
          ),
          Container(
              child: Column(children: <Widget>[
            new Hero(
              tag: 'home',
              child: ListTile(
                leading: new Icon(Icons.home),
                title: new Text('Home'),
                onTap: () {
// change app state...
                  MyDrawer._gotoPage("/home", context);
                },
              ),
            ),
            new Hero(
              tag: 'mags',
              child: ListTile(
                title: Text("Magasins"),
                leading: Icon(Icons.store_mall_directory),
              ),
            ),
            new Hero(
              tag: 'prods',
              child: ListTile(
                title: Text("Produits"),
                leading: Icon(Icons.apps),
              ),
            ),
            new Hero(
              tag: 'profil',
              child: ListTile(
                title: Text("Mon Profile"),
                leading: Icon(Icons.face),
              ),
            ),
            new Hero(
              tag: 'cmds',
              child: ListTile(
                title: Text("Mes Commandes"),
                leading: Icon(Icons.shop),
              ),
            ),
            new Hero(
              tag: 'livs',
              child: ListTile(
                title: Text("Livreures"),
                leading: Icon(Icons.people),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            new Hero(
              tag: 'params',
              child: ListTile(
                title: Text("Paramétres"),
                leading: Icon(Icons.settings),
              ),
            ),
            new Hero(
              tag: 'info',
              child: ListTile(
                title: Text("A propos"),
                leading: Icon(Icons.info),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            new Hero(
                tag: 'contact',
                child: ListTile(
                  title: Text("Contacter Nous"),
                  leading: Icon(Icons.speaker_phone),
                )),
          ]))
        ],
      ),
    );
  }
}
