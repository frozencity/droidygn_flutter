import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'schedule.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;


  /// Query a subcollection
  Stream<List<Schedule>> streamSchedules() {
    var ref = _db.collection('droidygn').snapshots();

    return ref.map((list) =>
        list.documents.map((doc) => Schedule.fromFirestore(doc)).toList());

  }

  Stream<List<Agenda>> streamAgenda() {
    var ref = _db.collection('agenda').snapshots();

    return ref.map((list) =>
        list.documents.map((doc) => Agenda.fromFirestore(doc)).toList());

  }



}