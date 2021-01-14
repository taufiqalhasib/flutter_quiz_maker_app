import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/helper/functions.dart';
import 'package:flutter_quiz_maker_app/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_quiz_maker_app/views/signin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    // TODO: implement initState
    super.initState();
  }

  checkUserLoggedInStatus() async{
    await HelperFunctions.getUserLoggedInDetails().then((value) => {
      setState((){
        _isLoggedIn = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}