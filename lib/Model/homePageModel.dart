import 'package:firebase_database/firebase_database.dart';

class homePageModel{
  String? birthdate, city, email, gender, mobile, name, password, key, wallet;

  homePageModel(
      {this.birthdate,
      this.city,
      this.email,
      this.gender,
      this.mobile,
      this.name,
      this.password, this.key, this.wallet});

  homePageModel.fromSnapshot(DataSnapshot snapshot){
    birthdate = snapshot.child("birthdate").value.toString();
    city = snapshot.child("city").value.toString();
    email = snapshot.child("email").value.toString();
    gender = snapshot.child("gender").value.toString();
    mobile = snapshot.child("mobile").value.toString();
    name = snapshot.child("name").value.toString();
    password = snapshot.child("password").value.toString();
    wallet = snapshot.child("wallet").value.toString();
    key = snapshot.key.toString();
  }

  toJson(){
    return{
    "birthdate": birthdate,
    "city": city,
    "email": email,
    "gender": gender,
    "mobile": mobile,
    "name": name,
    "password": password,
      "wallet" : wallet,
      "key": key
    };

  }
}