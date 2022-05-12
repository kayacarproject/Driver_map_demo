import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'MessagePage.dart';
import '../Constant/MySharedPreferences.dart';
import '../main.dart';
import 'SimpleMarkerAnimation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? myPrefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inItPref(context);
  }

  inItPref(BuildContext context) async {
    myPrefs = await SharedPreferences.getInstance();


     String? getLogin = MySharedPreferences.instance.getStringValue("isLogin", "", myPrefs!);
    String? getEmail = MySharedPreferences.instance.getStringValue("email", "", myPrefs!);
    String? getName = MySharedPreferences.instance.getStringValue("name", "", myPrefs!);
    String? getGender = MySharedPreferences.instance.getStringValue("gender", "", myPrefs!);
    String? getCity = MySharedPreferences.instance.getStringValue("city", "", myPrefs!);
    String? getBirthdate = MySharedPreferences.instance.getStringValue("birthdate", "", myPrefs!);
    String? getMobile = MySharedPreferences.instance.getStringValue("mobile", "", myPrefs!);
    String? getPassword = MySharedPreferences.instance.getStringValue("password", "", myPrefs!);
    String? uId = MySharedPreferences.instance.getStringValue("userId", "", myPrefs!);


     print("email______________"+getLogin.toString());
     print("userId______________"+uId.toString());
     print("userId______________"+getName.toString());

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SimpleMarkerAnimationExample(),
      ),
          (route) => false,
    );

  /*  if(getLogin == "true"){

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SimpleMarkerAnimationExample(getName.toString(), getEmail.toString(), getPassword, getGender, getCity, getBirthdate, getMobile, uId.toString()),
        ),
            (route) => false,
      );
      // Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleMarkerAnimationExample(getName.toString(), getEmail.toString(), getPassword, getGender, getCity, getBirthdate, getMobile, uId.toString())),);
    }else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
            (route) => false,
      );
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () => inItPref(context));


    /*var assetsImage = new AssetImage(
        'images/new_logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height:300); *///<- Creates a widget that displays an image.

    var text = new Text("Welcome Driver", style: TextStyle(fontSize: 20, color: Colors.purple),);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(

          body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: new Center(
              child: text,
            ),
          ), //<- place where the image appears
        ),

    );

  }
}
