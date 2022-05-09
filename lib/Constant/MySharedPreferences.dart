import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  String? getStringValue(
      String key, String defaultVal, SharedPreferences myPrefs) {
    // SharedPreferences myPrefs = await SharedPreferences.getInstance();
    // print(key);
    // myPrefs.getKeys().forEach((element) {
    //   print("ele==>"+element);
    // });
    if(myPrefs!=null && myPrefs.containsKey(key)) {
      return myPrefs.get(key) == null || myPrefs.get(key) == ""
          ? defaultVal
          : myPrefs.getString(key);
    }else{
      return defaultVal;
    }
  }

  setIntegerValue(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  Future<int> getIntegerValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? 0;
  }

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

  saveUser(String jsonString) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //  Map decode_options = jsonDecode(jsonString);
    //  String user = jsonEncode(User.fromJson(decode_options));
    shared_User.setString('user', jsonString);
    shared_User.commit();
  }

/*User getUser(SharedPreferences shared_User)  {

   // SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(shared_User.getString('user'));
    var user = User.fromJson(userMap);

    return user;
  }*/

/*Future<User> getUserPref()  async {

     SharedPreferences shared_User = await SharedPreferences.getInstance();

     print("uservalue       "+shared_User.getString('user'));
    Map userMap = jsonDecode(shared_User.getString('user'));
    var user = User.fromJson(userMap);

    return user;
  }*/

}
