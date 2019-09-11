import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:droidygn_flutter/data/schedule.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'detail_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SessionsTab extends StatefulWidget {

  @override
  SessionTabState createState(){
    return SessionTabState();
  }

}




class SessionTabState extends State<SessionsTab>{

  ScrollController _scrollController;
  ObjectKey SniperKey;

  bool isFavorited = false;
  SharedPreferences prefs;
  var nineAMtitle, nineAMSpeaker, nineAMImage, nineAMspeaker_info, nineAMtopic_info, nineAMroom;
  var tenAMtitle, tenAMSpeaker, tenAMImage, tenAMspeaker_info, tenAMtopic_info, tenAMroom;
  var elevenAMtitle, elevenAMSpeaker, elevenAMImage, elevenAMspeaker_info, elevenAMtopic_info, elevenAMroom;
  var onePMtitle, onePMSpeaker, onePMImage, onePMspeaker_info, onePMtopic_info, onePMroom;
  var twoPMtitle, twoPMSpeaker, twoPMImage, twoPMspeaker_info, twoPMtopic_info, twoPMroom;
  var threePMtitle, threePMSpeaker, threePMImage, threePMspeaker_info, threePMtopic_info, threePMroom;
  var fourPMtitle, fourPMSpeaker, fourPMImage, fourPMspeaker_info, fourPMtopic_info, fourPMroom;
  final FirebaseAnalytics analytics = FirebaseAnalytics();


  Future<Null> _getData() async {
    prefs = await SharedPreferences.getInstance();
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




  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  getLists(){

    var schedules = Provider.of<List<Schedule>>(context);
    if (schedules != null) {
      nineAMtitle =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      nineAMSpeaker =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      nineAMImage =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      nineAMspeaker_info =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      nineAMtopic_info =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      nineAMroom =
          schedules.where((i) => i.time.contains("9:00 AM")).map((schedule) {
            return schedule.room;
          }).toList();


      tenAMtitle =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      tenAMSpeaker =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      tenAMImage =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      tenAMspeaker_info =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      tenAMtopic_info =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      tenAMroom =
          schedules.where((i) => i.time.contains("10:00 AM")).map((schedule) {
            return schedule.room;
          }).toList();

      elevenAMtitle =
          schedules.where((i) => i.time.contains("11:00 AM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      elevenAMSpeaker =
          schedules.where((i) => i.time.contains('11:00 AM')).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      elevenAMImage =
          schedules.where((i) => i.time.contains("11:00 AM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      elevenAMspeaker_info =
          schedules.where((i) => i.time.contains("11:00 AM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      elevenAMtopic_info =
          schedules.where((i) => i.time.contains("11:00 AM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      elevenAMroom =
          schedules.where((i) => i.time.contains("11:00 AM")).map((schedule) {
            return schedule.room;
          }).toList();

      onePMtitle =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      onePMSpeaker =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      onePMImage =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      onePMspeaker_info =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      onePMtopic_info =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      onePMroom =
          schedules.where((i) => i.time.contains("1:00 PM")).map((schedule) {
            return schedule.room;
          }).toList();

      twoPMtitle =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      twoPMSpeaker =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      twoPMImage =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      twoPMspeaker_info =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      twoPMtopic_info =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      twoPMroom =
          schedules.where((i) => i.time.contains("2:00 PM")).map((schedule) {
            return schedule.room;
          }).toList();

      threePMtitle =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      threePMSpeaker =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      threePMImage =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      threePMspeaker_info =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      threePMtopic_info =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      threePMroom =
          schedules.where((i) => i.time.contains("3:30 PM")).map((schedule) {
            return schedule.room;
          }).toList();

      fourPMtitle =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.topic_title;
          }).toList();
      fourPMSpeaker =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.speaker_name;
          }).toList();
      fourPMImage =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.speaker_image;
          }).toList();
      fourPMspeaker_info =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.speaker_info;
          }).toList();
      fourPMtopic_info =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.topic_info;
          }).toList();
      fourPMroom =
          schedules.where((i) => i.time.contains("4:30 PM")).map((schedule) {
            return schedule.room;
          }).toList();
    }
  }


  @override
  Widget build(BuildContext context) {

   getLists();

    addSpecificSession(String time, var speaker, titles, topic_info, speaker_info, image, room){


      var listLength = 0;
      if (titles != null){
        listLength = titles.length;
      }


      //ListItems
      ListItems() {
        return SliverChildBuilderDelegate(
              (context, i ) {
            // DocumentSnapshot document = snapshot[i];
            _getData();
            if (prefs.getBool(speaker[i]) == null) {
              prefs.setBool(speaker[i], false);
            }

            return new ListTile(
              title: new Text(
                titles[i],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: new Text(speaker[i]+ ' / '+ room[i]),
              trailing: InkWell(
                onTap: () async {
                  if (prefs.getBool(speaker[i]) ?? true){
                    print(prefs.getBool(speaker[i]));
                    setState(() {
                      prefs.setBool(speaker[i], false);
                      _sendAnalyticsEvent(speaker[i].replaceAll(RegExp(r' '), ''), false);
                    });
                  } else {
                    print(prefs.getBool(speaker[i]));
                    setState(() {
                      prefs.setBool(speaker[i], true);
                      _sendAnalyticsEvent(speaker[i].replaceAll(RegExp(r' '), ''), true);
                    });
                  }
                  // _scrollController.jumpTo(i);
                },

                child: Container(
                  width: 42,
                  height: 42,
                  child: prefs.getBool(speaker[i]) ?? false ? Icon(
                    FontAwesomeIcons.solidStar,
                    size: 16.0,
                    color: Theme.of(context).accentColor,
                  )
                      : Icon( //false
                    FontAwesomeIcons.star,
                    size: 16.0,
                  ),
                ),
              ),

              //OnTap Behavior of Tiles
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SessionDetail(
                      sp_name: speaker[i],
                      sp_info: speaker_info[i],
                      sp_image: image[i],
                      topic_title: titles[i],
                      topic_info: topic_info[i],
                      time: time,
                      room: room[i],
                    );
                  }),
                );
              },

            );
          },
          childCount: listLength,
        );
      }


      return SliverStickyHeader(
        overlapsContent: true,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 50.0,
            width: 60.0,
            //color: Colors.lightBlue,
            padding: EdgeInsets.only(left: 16.0, top: 16.5),
            alignment: Alignment.center,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,

              ),
            ),

          ),
        ),
        sliver: SliverPadding(
          padding: EdgeInsets.only(left: 60.0),
          sliver: SliverList(
            delegate: ListItems(),

          ),
        ),
      );
    }

    _buildList(BuildContext context){
      return CustomScrollView(
        key: SniperKey,
        controller: _scrollController,
          slivers: [

            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Sessions',
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      fontSize: 23.0,
                    )),
              ),
            ),

            addSpecificSession('9:00\nAM', nineAMSpeaker, nineAMtitle, nineAMtopic_info, nineAMspeaker_info, nineAMImage, nineAMroom),
            addSpecificSession('10:00\nAM', tenAMSpeaker, tenAMtitle, tenAMtopic_info, tenAMspeaker_info, tenAMImage, tenAMroom),
            addSpecificSession('11:00\nAM', elevenAMSpeaker, elevenAMtitle, elevenAMtopic_info, elevenAMspeaker_info, elevenAMImage, elevenAMroom),
            addSpecificSession('1:00\nPM', onePMSpeaker, onePMtitle, onePMtopic_info, onePMspeaker_info, onePMImage, onePMroom),
            addSpecificSession('2:00\nPM', twoPMSpeaker, twoPMtitle, twoPMtopic_info, twoPMspeaker_info, twoPMImage, twoPMroom),
            addSpecificSession('3:30\nPM', threePMSpeaker, threePMtitle, threePMtopic_info, threePMspeaker_info, threePMImage, threePMroom),
            addSpecificSession('4:30\nPM', fourPMSpeaker, fourPMtitle, fourPMtopic_info, fourPMspeaker_info, fourPMImage, fourPMroom),
            /*setTenAMSessions(),*/

          ]
      );
    }


    return Scaffold(
      key: _scaffoldKey,
      body: Container(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<Null>(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
             // print('Boolean Value in FutureBuilder: ${snapshot.data}');
              return _buildList(context);
            } else
              return LinearProgressIndicator();
          },
        ),

      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(keepScrollOffset: true);
    // schedules = Provider.of<List<Schedule>>(context);
    _getData();
  }


}