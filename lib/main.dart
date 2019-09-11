import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/screen_main.dart';


// This is a main method. It is called at the start of the app.
void main() {

  //This changes System's Colors (Status Bar, Navigation bar, and their icons.
  /*SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      //systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );*/

  runApp(MyApp());

}
