import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginPage.dart';
import 'MessagePage.dart';


String? usersEmail;
String? usersPassword;
BuildContext? ctx;
String? userId;
class signUpPage extends StatefulWidget {
  signUpPage(String userEmail, String userPassword,User id,BuildContext bContext ){
    usersEmail = userEmail;
    ctx = bContext;
    usersPassword = userPassword;
    userId = id.uid;
  }

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  List? dataList;
  DateTime? firstPicked;
  String? _choosenCity;
  String? _choosenGender;

  DateTime todayDate = new DateTime.now();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _mobile = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  User? users;



  var databaseRef = FirebaseDatabase.instance.ref("User");


  Future<void> _selectStartDate(BuildContext context) async {
    firstPicked = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (firstPicked != null && firstPicked != todayDate)
      setState(() {
        todayDate = firstPicked!;
      });
  }
  printData(){
    print("name______"+_name.text.toString());
    print("email_____"+usersEmail.toString());
    print("password__"+usersPassword.toString());
    print("mobile____"+_mobile.text.toString());
    print("birthDate" + firstPicked.toString());
    print("city______"+ _choosenCity.toString());
    print("gender______"+ _choosenGender.toString());
  }

  insertData(String name, email, password, gender, city, mobile, birthdate) {

    // final auth = FirebaseAuth.instance;
    //  String? key = databaseRef.child(userId.toString()).push().key;
    // user = auth.currentUser;
    databaseRef.child(userId.toString()).set({
      // 'id' : key,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'city': city,
      'mobile': mobile,
      'birthdate': birthdate,
      'type': "driver",
      'wallet':"500"
    }).then((value) {
      Fluttertoast.showToast(
          msg: "User Added SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    print("userData******8"+"${userId}");
    /*print("tenantId______"+"${userData?.tenantId}");
    print("uid_____"+"${userData?.uid}");
    print("refreshToken_____"+"${userData?.refreshToken}");
    print("isAnonymous_____"+"${userData?.isAnonymous}");
    print("email_____"+"${userData?.email}");
    print("displayName_____"+"${userData?.displayName}");
    print("phoneNumber_____"+"${userData?.phoneNumber}");*/


  }
  clearData(){
    _name.clear();
    _email.clear();
    _mobile.clear();
    _password.clear();
    // firstPicked = todayDate;
    /*_choosenGender = null;
    _choosenCity = null;*/
  }


  addData() {
    _firestore.collection("User").doc(userId.toString()).set({
      'key':userId.toString(),
      'name': _name.text.toString(),
      'email': usersEmail.toString(),
      'mobileNumber': _mobile.text.toString(),
      'password': usersPassword.toString(),
      'birth-date': firstPicked.toString().split(" ")[0].toString(),
      'gender' : _choosenGender.toString(),
      'city':_choosenCity.toString()
    });
  }
  Future<User?> LoginUsingEmailandPassword(String? email, String? password, BuildContext? context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      auth.createUserWithEmailAndPassword(email: email!, password: password!).then((value) {
        print("new user created");
      });
      //user = userCredential.user;
      /*await user!.updateProfile(displayName: _name.text.toString());
      await user.reload();*/

      user = auth.currentUser;

    }on FirebaseAuthException catch(e){
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "Email already Exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else if(e.code == "password not match"){
        Fluttertoast.showToast(
            msg: "Wrong password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }catch(e){
      print(e);
    }
    return user;
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    print("UserId______________"+userId.toString());
    print("UserEmail______"+usersEmail.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Flutter Firebase Demo",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _name,
                        decoration: InputDecoration(
                            hintText: "enter Name", border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5),
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: Text(usersEmail.toString())/* TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _email,
                        decoration: InputDecoration(
                            hintText: "enter email", border: InputBorder.none),
                      ),*/
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: Text(usersPassword.toString())/*TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "enter Password", border: InputBorder.none),
                      ),*/
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        controller: _mobile,
                        decoration: InputDecoration(
                            hintText: "enter Mobile", border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        print("click on check in date");
                        _selectStartDate(context);
                      },
                      child: Container(
                        height: 45,
                        // width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),

                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            /*mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,*/
                            children: [
                              Text(
                                'CHECK-IN-DATE',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                // "${MySharedPreferences.instance.getStringValue(Util.TODAY_DATE, currentDate.toString(), myPrefs!)}",
                                "${todayDate.toLocal()}".split(' ')[0],
                                // _value.split('')[0],
                                // textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _choosenCity,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          'Ahmedabad',
                          'GandhiNagar',
                          'Vadodara',
                          'Nadiyad',
                          'Kutch',
                          'Junagadh',
                          'surat',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Please choose a city",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _choosenCity = value;
                            print(
                                "Selected value________" + _choosenCity.toString());
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _choosenGender,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Please choose Gender",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _choosenGender = value;
                              print("Selected value________" +
                                  _choosenGender.toString());
                            });
                          },
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        insertData(
                            _name.text.toString(),
                            // _email.text.toString(),
                            usersEmail.toString(),
                            // _password.text.toString(),
                            usersPassword.toString(),
                            _choosenGender.toString(),
                            _choosenCity.toString(),
                            _mobile.text.toString(),
                            firstPicked.toString());
                        addData();
                        bool? isFromMessage = true;
                        LoginUsingEmailandPassword(_email.text.toString(), _password.text.toString(), context);
                        printData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          // MaterialPageRoute(builder: (context) => homePage(isFromMessage, context,userId.toString(), uEmail.toString())),
                        );


                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: Text("Submit"),
                      ),
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child:  Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: Text("already Registered? CLICK HERE"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}