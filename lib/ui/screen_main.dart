import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'tab_myschedule.dart';
import 'tab_sessions.dart';
import 'tab_speakers.dart';
import 'package:droidygn_flutter/data/schedule.dart';
import 'package:droidygn_flutter/data/db.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Colors.black : Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

  }


  callMainApp(BuildContext context){


    return MultiProvider(
        providers: [
        StreamProvider<FirebaseUser>.value(
        value: FirebaseAuth.instance.onAuthStateChanged)
    ],
    child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,

            fontFamily: 'Cabin',
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            bottomAppBarColor: Colors.black,

          ),

          home: MyHomePage(title: 'DroidYangon 2019'),
        ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return callMainApp(context);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final db = DatabaseService();

  bool loggedIn;


  final List<Widget> _children = [
    HomeTab(),
    SessionsTab(),
    SpeakersTab(),
  //  UserProfile(),
  ];

  _provider() {
      return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>.value(
              value: FirebaseAuth.instance.onAuthStateChanged),

          StreamProvider<List<Schedule>>.value(value: db.streamSchedules(),),
          StreamProvider<List<Agenda>>.value(value: db.streamAgenda(),),

        ],
        child: _children[_currentIndex],

      );
  }


  //Google SignIn
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }



  //Build Method.
  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);
    loggedIn = user != null;


    print('Logged In $loggedIn');

    if (!loggedIn){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                height: 100,
                width: 100,
                child: Image.network('https://droidyangon.org/static/img/droidygn.png'),
              ),

              Text(
                'July 9th, 2019\n@ Taw Win Garden Hotel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                margin: EdgeInsets.all(16),
                child: RaisedButton(
                  child: Text('Login'),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColor,

                  onPressed: (){
                    _handleSignIn()
                        .then((FirebaseUser user) => print(user))
                        .catchError((e) => print(e));
                  },
                ),
              ),
            ],
          )
        ),
      );
    }
    else {
      return Scaffold(


        body: _provider(),

        //FAB
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: _currentIndex == 0 ? Colors.grey : Theme
              .of(context)
              .accentColor,
          tooltip: 'My Schedule',
          icon: Icon(FontAwesomeIcons.solidStar, size: 14.0,),
          label: Text('My Schedule'),
          onPressed: () {
            if (_currentIndex != 0) {
              setState(() {
                _currentIndex = 0;
              });
            }

          },
        ),
        // This trailing comma// makes auto-formatting nicer for build methods.

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: new BottomAppBar(

          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.thList),
                    iconSize: 16.0,
                    color: _currentIndex == 1 ? Theme
                        .of(context)
                        .accentColor : Colors.black45,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },)
              ),

              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.addressCard),
                  iconSize: 16.0,
                  color: _currentIndex == 2 ? Theme
                      .of(context)
                      .accentColor : Colors.black45,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },),
              ),

            ],
          ),
        ),

      );
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
