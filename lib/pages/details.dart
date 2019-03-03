import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DetailsSCreen extends StatefulWidget {
  final List poke;
  DetailsSCreen({Key key, this.poke}) : super(key: key);
  @override
  _DetailsSCreenState createState() => _DetailsSCreenState();
}

class _DetailsSCreenState extends State<DetailsSCreen> {
  List _poke;
  String _type= "",_week = "",_mult = "",_next= "",_prev= "";
  double _width,_height;
  int _toggle=0;
  @override
  void initState() {
    _poke = widget.poke;
    if(_poke[0]["type"] != null){
      List lType = _poke[0]["type"];
      for(int i=0;i <lType.length; i++ ){
        if(i ==0 ){
          _type = lType[0];
        }else{
          _type = _type + " - " +lType[i];
        }
      }
    }else{ _type = "-No Type-";}

    if(_poke[0]["multipliers"] != null){
      List lMult = _poke[0]["multipliers"];
      for(int i=0;i <lMult.length; i++ ){
        if(i ==0 ){
          _mult = lMult[0].toString();
        }else{
          _mult = _mult + " - " +lMult[i].toString();
        }
      }
    }else{ _mult = "-No Multipliers-";}

    if(_poke[0]["weaknesses"] != null){
      List lWeek = _poke[0]["weaknesses"];
      for(int i=0;i <lWeek.length; i++ ){
        if(i ==0 ){
          _week = lWeek[0];
        }else{
          _week = _week + " - " +lWeek[i];
        }
      }
    }else{ _week = "-No Weeknesses-";}

    if(_poke[0]["next_evolution"] != null){
      List lNext = _poke[0]["next_evolution"];
      for(int i=0;i <lNext.length; i++ ){
        if(i ==0 ){
          _next = lNext[0]["name"];
        }else{
          _next = _next + " - " +lNext[i]["name"];
        }
      }
    }else{ _next = "-No Next Evolutions-";}

    if(_poke[0]["prev_evolution"] != null){
      List lPrev = _poke[0]["prev_evolution"];
      for(int i=0;i <lPrev.length; i++ ){
        if(i ==0 ){
          _prev = lPrev[0]["name"];
        }else{
          _prev = _prev + " - " +lPrev[i]["name"];
        }
      }
    }else{ _prev = "-No Previus Evolutions-";}

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[

            Container(
                height: 50,
                margin: EdgeInsets.only(top: 30,left: 20),
                alignment: Alignment.centerLeft,
                child: IconButton(icon: Icon(Icons.clear), onPressed: (){Navigator.pop(context);})
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: Padding(padding: EdgeInsets.all(30),
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                        ),),
                      imageUrl: _poke[0]["img"],
                    ),

                    SizedBox(height: 10,),
                    Text(
                      _poke[0]["name"],
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ],
            ),

            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child:Row(
                  children: <Widget>[
                    Text(
                      "Candy :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _poke[0]["candy"] + "   -   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    ),

                    Text(
                      _poke[0]["candy_count"].toString() == "null"? "0":_poke[0]["candy_count"].toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.bold),
                    )
                  ],
                ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child:Row(
                  children: <Widget>[
                    Text(
                      "Type :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _type,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    )
                  ],
                ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Weight :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _poke[0]["weight"].toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    )
                  ],
                ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child:Row(
                  children: <Widget>[
                    Text(
                      "Height :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _poke[0]["height"].toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    )
                  ],
                ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Egg :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _poke[0]["egg"].toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    )
                  ],
                ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Spawn Chance :   ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    Text(
                      _poke[0]["spawn_chance"].toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight:
                          FontWeight.normal),
                    )
                  ],
                ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    "Average Spawns :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  Text(
                    _poke[0]["avg_spawns"].toString(),
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.0,
                        fontWeight:
                        FontWeight.normal),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    "Spawn Time :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  Text(
                    _poke[0]["spawn_time"].toString(),
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.0,
                        fontWeight:
                        FontWeight.normal),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    "Multipliers :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  Text(
                    _mult,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.0,
                        fontWeight:
                        FontWeight.normal),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child:  Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  Text(
                    "Weaknesses :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        _week,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight:
                            FontWeight.normal),
                      )
                    ],
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child:  Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  Text(
                    "Previus Evolution :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),

                        Text(
                          _prev,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.0,
                              fontWeight:
                              FontWeight.normal),
                        )


                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 50,right: 50,top: 20),
              child:  Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  Text(
                    "Next Evolution :   ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight:
                        FontWeight.bold),
                  ),

                      Text(
                        _next,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight:
                            FontWeight.normal),
                      )


                ],
              ),
            ),


          ],
        ),
      ),


    );
  }
}
