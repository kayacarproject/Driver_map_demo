import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant/MySharedPreferences.dart';
import 'LoginPage.dart';
import 'MessagePage.dart';
import '../main.dart';

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



    if(getLogin == "true"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage(getName.toString(), getEmail, getPassword, getGender, getCity, getBirthdate, getMobile,uId.toString()),));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(
        child: Text("WelCome", style: TextStyle(fontSize: 50, color: Colors.blue),),
      ),
    ));
  }
}
