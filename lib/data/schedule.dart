import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String speaker_name;
  final String speaker_image;
  final String speaker_info;
  final String topic_title;
  final String topic_info;
  final String time;
  final String room;
  final String speaker_two_name;
  final String speaker_two_image;
  final String speaker_two_info;
  final String speaker_three_name;
  final String speaker_three_image;
  final String speaker_three_info;

  Schedule(
      { this.speaker_name,
        this.speaker_image,
        this.speaker_info,
        this.topic_title,
        this.topic_info,
        this.time,
        this.room,
        this.speaker_two_name,
        this.speaker_two_image,
        this.speaker_two_info,
        this.speaker_three_name,
        this.speaker_three_image,
        this.speaker_three_info,
      }
  );


  factory Schedule.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Schedule(
        speaker_name: data['speaker_name'] ?? '',
        speaker_image: data['speaker_image'] ?? '',
        speaker_info: data['speaker_info'] ?? '',
        topic_title: data['topic_title'] ?? '',
        topic_info: data['topic_info'] ?? '',
        time: data['time'] ?? '',
        room: data['room'] ?? '',
        speaker_two_name: data['speaker_two_name'] ?? '',
        speaker_two_info: data['speaker_two_info'] ?? '',
        speaker_two_image: data['speaker_two_image'] ?? '',
        speaker_three_name: data['speaker_three_name'] ?? '',
        speaker_three_image: data['speaker_three_image'] ?? '',
        speaker_three_info: data['speaker_three_info'] ?? '',
    );
  }



}

class Agenda {
  final String room;
  final String title;
  final String time;

  Agenda({this.room,this.title,this.time,});


  factory Agenda.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Agenda(
      room: data['room'] ?? '',
      title: data['title'] ?? '',
      time: data['time'] ?? '',
    );
  }

}