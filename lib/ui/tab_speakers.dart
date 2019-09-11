import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:droidygn_flutter/data/schedule.dart';
import 'detail_speaker.dart';


class SpeakersTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var schedules = Provider.of<List<Schedule>>(context);

    var speaker_images = schedules.map((sessions){
      return sessions.speaker_image;
    }).toList();

    var speaker_name = schedules.map((sessions){
      return sessions.speaker_name;
    }).toList();

    var speaker_info = schedules.map((sessions){
      return sessions.speaker_info;
    }).toList();

    var topic_title = schedules.map((sessions){
      return sessions.topic_title;
    }).toList();

    var topic_info = schedules.map((sessions){
      return sessions.topic_info;
    }).toList();

    var time = schedules.map((sessions){
      return sessions.time;
    }).toList();

    var room = schedules.map((sessions){
      return sessions.room;
    }).toList();

    return Scaffold(
      body: Container(
        child: CustomScrollView(

          slivers: <Widget> [
            SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Speakers',
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 23.0,
                  )),
            ),
          ),
            SliverGrid.count(
              crossAxisCount: 2,
                children: List.generate(speaker_images.length,(index){
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),

                    height: 300,
                    margin: EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SpeakerDetail(
                              sp_name: speaker_name[index],
                              sp_info: speaker_info[index],
                              sp_image: speaker_images[index],
                              topic_title: topic_title[index],
                              topic_info: topic_info[index],
                              time: time[index],
                              room: room[index],
                            );
                          }),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: FractionalOffset.topCenter,
                                image: NetworkImage(
                                  speaker_images[index],
                                ),
                              ),
                            ),
                            height: 300,
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5,
                                      offset: Offset(0.0, 1.5),
                                    ),
                                  ]
                              ),

                              width: double.infinity,

                              padding: EdgeInsets.all(5.0),
                              child: Text(speaker_name[index]),
                            ),
                          ),


                        ],
                      ),
                    ),


                  );
                }),


            ),

          ],
        ),
      ),
    );
  }




}