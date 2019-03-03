import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:poke/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int check = 0,done = 0;
  List _items;
  String _images = "";

  Future _saveList(List _list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', json.encode(_list));
  }
  Future<String> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _x = prefs.getString("data");
    return _x;
  }

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"),
    );

    if (response.body.toString() == "") {

    } else {
      _items = json.decode(response.body)["pokemon"];
      setState(() {
        check = 1;
      });


    }

    print("Splash screen get is :" + response.body);
    print('Response status: ${response.statusCode}');
    return "done";
  }

  int connected = 0;

  Future<int> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return 0;
    }else{
      return 1;
    }
  }

  String _type = "";

  @override
  void initState() {

    super.initState();
  }

  Home homePage;
  SplashScreen splashScreen;
  Widget _screen;

  _SplashScreenState() {
    homePage = new Home();
    splashScreen = new SplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    getData().then((value) {
          setState(() {
            check = 1;
          });
          //_onSplashEnd();
    });

    checkConnection().then((result){
      if(result == 0){ // connection
        if (check == 1){
            _saveList(_items).whenComplete((){
              _onSplashEnd();
          });
        }
      }else{    // no connection
        _getUser().then((_list){
          _items = json.decode(_list);
          _onSplashEnd();
        });
      }
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF184568),
                  Color(0xEE184568),
                ],
                end: FractionalOffset.topLeft,
                begin: FractionalOffset.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50.0,
                        child: Image.asset('assets/logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Pokَemon",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22),
                      )

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    connected == 0 ?CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ): Text("No internet connection",
                      style: TextStyle(color: Colors.red),
                    ),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _onSplashEnd() {
    /*Timer(Duration(seconds: 10), () {
      setState(() {
        connected = 1;
      });
    });*/
      //if(_items.length >10 && _images.length>10){

        if(done == 0){
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) => Home(items : _items)));

        }
        done =1 ;
      //}else{
      //  print("exeption");
      //}

  }

  void updateType(String type) {
    setState(() {
      this._type = type;
    });
  }
}
