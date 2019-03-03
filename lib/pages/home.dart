import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke/pages/details.dart';


class Home extends StatefulWidget {
  final List items;

  Home({Key key, this.items}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _pokemons;
  @override
  void initState() {
    _pokemons = widget.items;
    super.initState();
  }


  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text;

  static const List<String> menu = <String>[
    "Contact us",
    "About app",
    "Visit website"
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Color(0xFF184568),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Pokَemon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      )),
                  background: Image.asset(
                    "assets/banner.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body:
          TabBarView(
            children: [
              Column(
                children: <Widget>[
                  Expanded (

                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount:_pokemons.length,
                        // itemExtent: 10.0,
                        //reverse: true, //makes the list appear in descending order
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                            onTap: () {
                              List _flitered = _pokemons.where((i) =>  i["name"] == _pokemons[index]["name"]).toList();
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (BuildContext context) => DetailsSCreen(poke: _flitered)));
                              //
                            },
                            child: Container(
                              //height: 140.0,
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0),
                              child: Material(
                                color: Color(0xFFEEEEEE),
                                animationDuration: Duration(milliseconds: 500),
                                elevation: 5.0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                child: Container(

                                   child: Row(
                                     mainAxisSize: MainAxisSize.max,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: <Widget>[

                                       Container(
                                         width: 100,
                                         height: 100,
                                         child: CachedNetworkImage(
                                           fit: BoxFit.cover,
                                           placeholder: Padding(padding: EdgeInsets.all(30),
                                           child: CircularProgressIndicator(
                                             valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                           ),),
                                           imageUrl: _pokemons[index]["img"],
                                         ),
                                       ),

                                       new Row(
                                         children: <Widget>[

                                           Padding(
                                             padding: EdgeInsets.only(left: 0.0),
                                           ),
                                           Column(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Container(
                                                 padding: EdgeInsets.only(top : 10.0,left: 20),
                                                 child:Row(
                                                   children: <Widget>[
                                                     Text(
                                                       _pokemons[index]["name"],
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 20.0,
                                                           fontWeight:
                                                           FontWeight.bold),
                                                       textAlign: TextAlign.center,
                                                     ),
                                                   ],
                                                 ),
                                               ),

                                               Container(
                                                 padding: EdgeInsets.only(top : 20.0,left: 20),
                                                 child: Row(
                                                   children: <Widget>[
                                                     Text(
                                                       "Candy :  ",
                                                       style: TextStyle(
                                                           color: Colors.black87,
                                                           fontSize: 16.0,
                                                           fontWeight:
                                                           FontWeight.normal),
                                                     ),
                                                     Text(
                                                       _pokemons[index]["candy"],
                                                       style: TextStyle(
                                                           color: Colors.black54,
                                                           fontSize: 14.0,
                                                           fontWeight:
                                                           FontWeight.normal),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                               Container(
                                                 padding: EdgeInsets.only(top : 10.0,left: 20,bottom: 20),
                                                 child: Row(
                                                   children: <Widget>[
                                                     Text(
                                                       "Candy count :  ",
                                                       style: TextStyle(
                                                           color: Colors.black87,
                                                           fontSize: 14.0,
                                                           fontWeight:
                                                           FontWeight.normal),
                                                     ),
                                                     Text(
                                                       _pokemons[index]["candy_count"].toString() == "null" ? "-No Candy-":_pokemons[index]["candy_count"].toString(),
                                                       style: TextStyle(
                                                           color: Colors.black54,
                                                           fontSize: 16.0,
                                                           fontWeight:
                                                           FontWeight.normal),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           )
                                         ],
                                       )
                                     ],
                                   ),
                                )
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('-Not Specified-'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('this oil station location is not specified yet.'),
                Text('we will try to update it as soon as possible.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

typedef void MyFormCallback(String name,String result,bool benzin,bool desiel);

class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;

  MyForm({this.onSubmit});

  @override
  _MyFormState createState() => new _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String cValue = "all";
  bool isBezin = false;
  bool isDesiel = false;

  static final TextEditingController _name = new TextEditingController();
  static final TextEditingController _major = new TextEditingController();
  static final TextEditingController _region = new TextEditingController();

  String get name => _name.text;

  String get major => _major.text;

  String get region => _region.text;


  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          cValue = "all";
          break;
        case 1:
          cValue = "Khartoum";
          break;
        case 2:
          cValue = "Khartoum North";
          break;
        case 3:
          cValue = "Omdurman";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text("My form"),
      children: <Widget>[


        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Radio<int>(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("All"),
              ],
            ),
            Row(
              children: <Widget>[
                new Radio<int>(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("Khartoum"),
              ],
            ),
            Row(
              children: <Widget>[
                new Radio<int>(
                  value: 2,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("Khartoum North"),
              ],
            ),
            Row(
              children: <Widget>[
                new Radio<int>(
                  value: 3,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("Omdurman"),
              ],
            ),
            //Text("بحث حسب المنطقة"),

            new Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
              child: TextFormField(
                controller: _name,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Name filter',
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (value) {
                  final RegExp regex = new RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),

            /*new Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
              child: TextFormField(
                controller: _region,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Address filter',
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (value) {
                  final RegExp regex = new RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ),
            ),*/

            Container(
              height: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 20.0),
            ),
            Row(
              children: <Widget>[

                new Checkbox(
                  value: isBezin,
                  onChanged: (value) {
                    setState(() {
                      isBezin = value;
                    });
                  },
                ),
                Text("Available Benzin"),

              ],
            ),


            Row(

              children: <Widget>[
                new Checkbox(
                  value: isDesiel,
                  onChanged: (value) {
                    setState(() {
                      isDesiel = value;
                    });
                  },
                ),
                Text("Available Desiel"),

              ],
            ),
          ],
        ),


        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(right: 10.0, top: 20.0),
              child: new FlatButton(
                  child: Text("CANCEL",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context, Answer.CANCEL);
                  }),
            ),
            new Padding(
              padding: EdgeInsets.only(right: 20.0, top: 20.0),
              child: new MaterialButton(
                elevation: 5.0,
                height: 50.0,
                child: Text("SUBMIT",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0)),
                color: Color(0xFF04476E),

                onPressed: () {
                  Navigator.pop(context);
                  widget.onSubmit(_name.text,cValue.toString(),isBezin,isDesiel);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum Answer { OK, CANCEL }
