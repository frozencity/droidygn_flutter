import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:droidygn_flutter/data/schedule.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'detail_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTab extends StatefulWidget {


  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeTab> {
  SharedPreferences prefs;
  var speakers;
  var schedules;
  var agenda;
  bool b1;
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

  @override
  Widget build(BuildContext context) {
    schedules = Provider.of<List<Schedule>>(context);
    agenda = Provider.of<List<Agenda>>(context);

    if (schedules != null) {
      speakers = schedules.map((schedule) {
        return schedule.speaker_name;
      }).toList();
    }
    //var top = 0.0;

    getWidgets() {
      return Container(
        child: NestedScrollView(

          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 150.0,
                floating: true,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      //top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        title: Text(
                            'My Schedule',
                            style: TextStyle(
                              fontSize: 23.0,
                            )
                        ),
                      );
                    }
                ),
              ),
            ];
          },

          body: ListView(
              children: schedules.map<Widget>((schedule) {
                    if (prefs.getBool(schedule.speaker_name) ?? false) {
                      return ListTile(
                        title: new Text(
                          schedule.topic_title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: Text(
                          schedule.time.replaceAll(RegExp(r' '), '\n'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,

                          ),
                        ),

                        subtitle: new Text(schedule.speaker_name + ' / ' +schedule.room),
                        trailing: InkWell(
                          onTap: () async {
                            if (prefs.getBool(schedule.speaker_name) ?? true) {
                              setState(() {
                                prefs.setBool(schedule.speaker_name, false);
                                _sendAnalyticsEvent(schedule.speaker_name.replaceAll(RegExp(r' '), ''), false);
                              });
                            } else {
                              print(prefs.getBool(schedule.speaker_name));
                              setState(() {
                                prefs.setBool(schedule.speaker_name, true);
                                _sendAnalyticsEvent(schedule.speaker_name.replaceAll(RegExp(r' '), ''), true);
                              });
                            }
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            child: prefs.getBool(schedule.speaker_name) ?? false
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
                        ),

                        //OnTap Behavior of Tiles
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SessionDetail(
                                sp_name: schedule.speaker_name,
                                sp_info: schedule.speaker_info,
                                sp_image: schedule.speaker_image,
                                topic_title: schedule.topic_title,
                                topic_info: schedule.topic_info,
                                time: schedule.time,
                                room: schedule.room,
                              );
                            }),
                          );
                        },
                      );
                    } else {
                      return Visibility(
                        visible: false,
                        child: Text('Fuck This Shit'),
                      );
                    }
                  }).toList(),
            ),
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder<bool>(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print('itemNo in FutureBuilder: ${snapshot.data}');
            return getWidgets();
          } else
            return LinearProgressIndicator();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();

    //prefs.getBool('Hoi Lam')?? false;
    //_setData();
    // schedules = Provider.of<List<Schedule>>(context);
    // speakers = schedules.map((schedule){return schedule.speaker_name;}).toList();
  }
}
