import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_demo/SimpleMarkerAnimation.dart';



String? uName, uEmail, uPassword, uGender, uCity, uBirthDate, uMobile, lUid;
class MessagePage extends StatefulWidget {
  MessagePage(String name,email, password, gender, city, birthdate, mobile, String uid, {Key? key}) : super(key: key){
    uName = name;
    uEmail = email;
    uPassword = password;
    uGender = gender;
    uCity = city;
    uBirthDate = birthdate;
    uMobile = mobile;
    lUid = uid;
    print("uMobile_________"+uMobile.toString());
    print("LoginUserId_______"+lUid.toString());
    print("LoginUserEmail_______"+uEmail.toString());

  }

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  bool isFromMessage = false;
  final dbRef = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Message Page'),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){

             Navigator.push(context, MaterialPageRoute(builder: (context)=> SimpleMarkerAnimationExample()));
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAppGrp()));
          }, child: Text("Start Chatting"),
        ),
      )
      /*FirebaseAnimatedList(
        physics: NeverScrollableScrollPhysics(),
      query: dbRef,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 100,
            child: FirebaseAnimatedList(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation animation, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // String? Id= uId.toString();
                        // print("Record Id____"+Id.toString());

                        String? name =
                        snapshot.child(uName!).value.toString();
                        print("++++++++++"+name);
                        String? email =
                        snapshot.child(uEmail!).value.toString();
                        String? password =
                        snapshot.child(uPassword!).value.toString();
                        String? mobile =
                        snapshot.child(uGender!).value.toString();
                        String? city =
                        snapshot.child(uCity!).value.toString();
                        String? gender =
                        snapshot.child(uMobile!).value.toString();
                        String? birthdate =
                        snapshot.child(uBirthDate!).value.toString();

                        print("name+++" + snapshot.key.toString());
                        String? userId = snapshot.key.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateData(
                                name,
                                email,
                                password,
                                mobile,
                                city,
                                gender,
                                birthdate,
                                userId),
                          ),
                        );

                        // print("name+++"+name);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].name.toString(),
                                  *//*snapshot.child(uName!).value.toString()*/
      /*
                                uName.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_iphone,
                                  color: Theme.of(context).accentColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].email.toString(),
                                  *//*snapshot.child("email").value.toString()*/
      /*
                uEmail.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].name.toString(),
                                  uMobile.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].city.toString(),
                                  snapshot.child("city").value.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].gender.toString(),
                                  snapshot.child("gender").value.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  // homePageData![index].birthdate.toString(),
                                  snapshot
                                      .child("birthdate")
                                      .value
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    */
      /*Container(
                      color: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Widget cancelButton = TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continueButton = TextButton(
                            child: Text("Continue"),
                            onPressed: () async {
                              FirebaseDatabase.instance
                                  .reference()
                                  .child('User')
                                  .child(snapshot.key.toString())
                                  .remove();
                              Navigator.pop(context);

                              User user = await FirebaseAuth.instance.currentUser!;
                              user.delete();

                            },
                          );

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("AlertDialog"),
                            content: Text("Are you sure you want to delete this data?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    )*/
      /*
                  ],
                );
              },
            )
          */
      /* ListView.builder(
            itemCount: homePageData?.length,
            itemBuilder: (BuildContext context,  int index) {

              return homePageData?.length == 0? Text("No Data found"): BuildList();
            },
          ),*//*
        );
      },
    )*/,
    ));
  }
}
