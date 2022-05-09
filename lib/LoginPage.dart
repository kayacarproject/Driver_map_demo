
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Constant/MySharedPreferences.dart';
import 'MessagePage.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

 final dbRef = FirebaseDatabase.instance.ref("User");



  /*email = "Abc@g.com";
    password = "qwerty";*/


  @override
  void initState() {
    // TODO: implement initState
    _email.text = "abc@g.com";
    _password.text = "qwerty";
    // String? userEmail = MySharedPreferences.instance.getStringValue("email", "no email", myPrefs!);
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<User?> createEmailandPassword(
      String? email, String? password, BuildContext? context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      auth.createUserWithEmailAndPassword(email: email!, password: password!).then((value) {
        print("new user created");
        print("________"+value.user!.uid.toString());
        print("________"+value.user!.email.toString());
        print("________"+value.credential.toString());
        print("________"+value.additionalUserInfo.toString());
         User? uId = value.user;
        print("User_______"+uId.toString());
        Navigator.push(context!, MaterialPageRoute(builder: (context)=>signUpPage(email,password,uId!, context)));

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

  Future<User?> LoginUsingEmailandPassword(
      String? email, String? password, BuildContext? context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    // print("UserData_____" + "${userData?.uid.toString()}");
    try {

      List<String> providerList = await auth.fetchSignInMethodsForEmail(email.toString());
      if(providerList.isEmpty){
        String? userEmail = _email.text.toString();
        String? userPassword = _password.text.toString();
        // User? user;
        // String? userId = user?.uid;
        createEmailandPassword(_email.text.toString(), _password.text.toString(), context);

      }else{
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email.toString(), password: password.toString());
        user = userCredential.user;
        // Navigator.push(context!, MaterialPageRoute(builder: (context)=>firestoreGetData()));
        //  Navigator.push(context!, MaterialPageRoute(builder: (context)=>homePage()));

        String? name = "";
        String? city = "";
        String? gender = "";
        String? birthdate = "";
        String? mobile = "";

         dbRef.child(user!.uid).get().then((snapshot){
          name = snapshot.child("name").value.toString();
          email = snapshot.child("email").value.toString();
          city = snapshot.child("city").value.toString();
          gender = snapshot.child("gender").value.toString();
          mobile = snapshot.child("mobile").value.toString();
          birthdate = snapshot.child("birthdate").value.toString();
          password = snapshot.child("password").value.toString();

          MySharedPreferences.instance.setStringValue("name", name!);
          MySharedPreferences.instance.setStringValue("email", email!);
          MySharedPreferences.instance.setStringValue("city", city!);
          MySharedPreferences.instance.setStringValue("gender", gender!);
          MySharedPreferences.instance.setStringValue("mobile", mobile!);
          MySharedPreferences.instance.setStringValue("birthdate", birthdate!);
          MySharedPreferences.instance.setStringValue("password", password!);
           MySharedPreferences.instance.setStringValue("isLogin", "true");
           MySharedPreferences.instance.setStringValue("userId", user!.uid.toString());
           MySharedPreferences.instance.setStringValue("userEmail", user.email.toString());


          Navigator.push(context!, MaterialPageRoute(builder: (context)=>MessagePage(name!, email, password, city, gender, birthdate, mobile, user!.uid)));

         });


        print("userCradential__________"+userCredential.toString());
        // print("userCradential__________"+userCredential.additionalUserInfo.toString());
        // print("userCradential__________"+userCredential.additionalUserInfo!.providerId.toString());
        //  print("userCradential__________"+userCredential.user.toString());
        print("userCradential__________"+userCredential.user!.email.toString());
        print("userCradential__________"+user.uid.toString());
      }

    } on FirebaseAuthException catch (e) {
      // if () {
        Fluttertoast.showToast(
            msg: "User not found with this email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      // }
    }
    return user;
  }



  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: "enter email",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)),
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "enter Password",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(

                          onTap: () async {



                            User? user = await LoginUsingEmailandPassword(
                                _email.text.toString(),
                                _password.text.toString(),
                                context);
                          },

                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blue,
                            child: Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }
}
