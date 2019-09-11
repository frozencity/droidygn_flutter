import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SpeakerDetail extends StatefulWidget {

  final String sp_name, sp_info, sp_image, topic_title, topic_info, time, room;

  SpeakerDetail(
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
  SpeakerDetailState createState(){
    return SpeakerDetailState(this.sp_name, this.sp_image, this.sp_info, this.topic_info, this.topic_title, this.time, this.room);
  }




}

class SpeakerDetailState extends State<SpeakerDetail>{
  String sp_name, sp_info, sp_image, topic_title, topic_info, time, room;

  SpeakerDetailState(this.sp_name, this.sp_image, this.sp_info, this.topic_info, this.topic_title, this.time, this.room);
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
      _sendAnalyticsEvent(sp_name.replaceAll(RegExp(r' '), ''), true); // replaces spaces with underscore.
      return await prefs.setBool(sp_name, true);
    } else {
      isFavorited = false;
      _sendAnalyticsEvent(sp_name.replaceAll(RegExp(r' '), ''), false);
      return await prefs.setBool(sp_name, false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,elevation: 0.0,),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //This Speaker Details
              Container(
                margin: EdgeInsets.only(top:16.0, bottom: 16.0),
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
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  sp_info,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),


              //Topic
              Container(
                margin: EdgeInsets.only(top: 32.0, bottom: 5.0),
                child: Text(
                  'The Talk',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              ListTile(
                title: Text(topic_title),
                subtitle: Text('$time / $room' ),
                trailing: InkWell(
                  onTap: (){
                    setState(() {
                      addtoFav();
                    });
                  },

                  child: Container(
                    width: 42,
                    height: 42,
                    child: isFavorited
                        ? Icon(
                      FontAwesomeIcons.solidStar,
                      size: 16.0,
                      color: Theme.of(context).accentColor,
                    )
                        : Icon( //false
                      FontAwesomeIcons.star,
                      size: 16.0,
                    ),
                  ),
                ), //InkWell
              ),


            ],
          ),
        ),
      ),
    );
  }
}
