import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SessionDetail extends StatefulWidget {

  final String sp_name, sp_info, sp_image, topic_title, topic_info, time, room;

  SessionDetail(
      {
        Key key,
        @required this.sp_name,
        @required this.sp_image,
        @required this.sp_info,
        @required this.topic_info,
        @required this.topic_title,
        @required this.time,
        @required this.room,
      }
      ) : super(key: key);


  @override
  SessionDetailState createState(){
    return SessionDetailState(this.sp_name, this.sp_image, this.sp_info, this.topic_info, this.topic_title, this.time, this.room);
  }




}

class SessionDetailState extends State<SessionDetail>{
  String sp_name, sp_info, sp_image, topic_title, topic_info, time, room;

  SessionDetailState(this.sp_name, this.sp_image, this.sp_info, this.topic_info, this.topic_title, this.time, this.room);
  bool isFavorited = false;
  final FirebaseAnalytics analytics = FirebaseAnalytics();


  @override
  void initState() {
    super.initState();

    setData();
  }



  Future<bool> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sp_name) ?? false;
  }

  setData() {
    loadData().then((value) {
      setState(() {
        isFavorited = value;
      });
    });
  }


  Future<void> _sendAnalyticsEvent(String eventName, bool attending) async {
    await analytics.logEvent(
      name: eventName,
      parameters: <String, dynamic>{
        'bool': attending,
      },
    );
    // setMessage('logEvent succeeded');
  }




  Future<bool> addtoFav() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!isFavorited){
      isFavorited = true;
      _sendAnalyticsEvent(sp_name.replaceAll(RegExp(r' '), ''), true);
      return await prefs.setBool(sp_name, true);
    } else {
      isFavorited = false;
      _sendAnalyticsEvent(sp_name.replaceAll(RegExp(r' '), ''), false);
      return await prefs.setBool(sp_name, false);
    }
  }


  var top = 0.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(

        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: true,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                          top: 16.0, left: 60.0, bottom: 5.0),
                      title: Container(
                        margin: EdgeInsets.only(top: 16.0, bottom: 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Text(
                                  topic_title,
                                  style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),

                            Visibility(
                              visible: top > 95 ? true : false,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(

                                      child: Text(
                                        //this replaces the "\n" (enter) code to (space).
                                        time.replaceAll(RegExp(r'\n'), ' ') +
                                            " / " + room,
                                        style: TextStyle(fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
      );
    }
              ),
            ),
          ];
        },

        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[



                  //Topic Header
                  Container(
                    margin: EdgeInsets.only(top: 32.0, bottom: 5.0),
                    child: Text(
                      'About this Talk',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),

                  //Topic Info
                  Container(
                    child: Html(data: topic_info),
                  ),

                  //About the Speaker
                  Container(
                    margin: EdgeInsets.only(top: 32.0, bottom: 5.0),
                    child: Text(
                      'About the Speaker',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Container(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(
                            new Radius.circular(8.0))),

                    margin: EdgeInsets.only(top: 16.0, bottom: 64.0),
                    child: Column(
                      children: <Widget>[

                        //This Speaker Details
                        Container(
                          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          alignment: Alignment.center,

                          child: CircleAvatar(
                            maxRadius: 75.0,
                            backgroundImage: NetworkImage(sp_image),
                          ),

                        ),


                        //Speaker Name
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            sp_name,
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),

                        //Speaker Info
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 16.0, left: 16.0, right: 16.0),
                          child: Text(
                            sp_info,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),

                      ],
                    ),

                  )


                ],
              ),
            )),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            addtoFav();
          });
        },
        backgroundColor: Theme.of(context).accentColor,
        tooltip: 'Add to Favorite',
        child: isFavorited
            ? Icon(
          FontAwesomeIcons.solidStar,
          size: 16.0,
          color: Theme.of(context).primaryColor,
        )
            : Icon( //false
          FontAwesomeIcons.star,
          size: 16.0,
        ),
      ),
    );
  }
}
