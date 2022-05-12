import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../Constant/MySharedPreferences.dart';
import 'Model/homePageModel.dart';

// String? messageId;
var ctxProgressLP;
class WallateScreen extends StatefulWidget {
  WallateScreen(var ctx,
      {Key? key})
      : super(key: key) {
    ctxProgressLP = ctx;
    // messageId = msgId;
    final bool? isFromSender;
  }

  @override
  State<WallateScreen> createState() => _WallateScreenState();
}

class _WallateScreenState extends State<WallateScreen> {
  String? uId = "J6BPy5vSvAaI6F31cSxT2qHkU2R2";
  String? uName;
  String? lUid = "7omqL3B2GVVRGQEIM7fPt0J6J3p2";
  String? lName;
  bool isExist = false;

  TextEditingController amountController = new TextEditingController();

  final dbRef1 = FirebaseDatabase.instance.ref("User");
  final dbRef = FirebaseDatabase.instance.ref("User");

  String? inputedAmount = "100";
  var loginWallateData = "";
  var userWallateData = "";

  var progress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getData();
    print("userWallate Data_____" + userWallateData.toString());
    print("userId" + uId.toString());
    print("uName" + uName.toString());
    print("lUid" + lUid.toString());
    print("lName" + lName.toString());
  }

  getData(){

    /*dbRef1.child(uId.toString()).onValue.listen((event) {
      print("=-=-=-"+event.snapshot.value.toString());
      homePageModel model = homePageModel.fromSnapshot(event.snapshot);
      print("userID Wallate____" + model.wallet.toString());
      setState(() {
        userWallateData =  model.wallet.toString(); //snapshot.child("wallet").value.toString();
      });
    });*/
    dbRef1.child(lUid.toString()).onValue.listen((event) {
      print("=-=-=-"+event.snapshot.value.toString());
      homePageModel model = homePageModel.fromSnapshot(event.snapshot);
      print("userID Wallate____" + model.wallet.toString());
      setState(() {
        loginWallateData =  model.wallet.toString(); //snapshot.child("wallet").value.toString();
      });
    });

    /*dbRef1.child(uId.toString()).get().then((snapshot) async{

      snapshot.children.forEach((element1) {
        homePageModel model = homePageModel.fromSnapshot(element1);
        print("userID Wallate____" + model.wallet.toString());
        setState(() {
          userWallateData =  model.wallet.toString(); //snapshot.child("wallet").value.toString();
        });
      });


    });*/
  }

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    home: ProgressHUD(
        backgroundColor: Colors.white,
        indicatorColor: Colors.cyan,
        textStyle: TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontFamily: 'Cambria',
    ),
    child: Builder(
    builder: (ctxPrg) {
    ctxProgressLP = ctxPrg;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Driver",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  /*Container(
                    child: Text(
                      "Pay Here",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Your Wallate amount is ",
                          style: TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          "\$" + loginWallateData.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text("To : Commuters", style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      controller: amountController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                          hintText: "Enter your amount",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(50)),
                    child: InkWell(
                      onTap: () {
                        print("Update");
                        print("loginId__" + lUid.toString());
                        print("userId__" + uId.toString());
                        // dbRef1.child(lUid.toString()).get();

payment();
                        /*dbRef1.child(lUid.toString()).once().then((value) {
                          var senderRs =
                              value.snapshot.child("wallet").value.toString();

                          if (double.parse(senderRs) >
                              double.parse(amountController.text.toString())) {
                            print("send");

                            var totAmt = double.parse(senderRs) - double.parse(amountController.text.toString());
                            print("final amt=-=-=>"+totAmt.toString());

                            dbRef1.child(lUid.toString()).update(
                                {"wallet": totAmt.toString()}).then((value) {
                              dbRef.child(uId.toString()).once().then((value) {
                                    var receiverRs = value.snapshot.child("wallet").value.toString();
                                    var totAmtRec = double.parse(receiverRs) + double.parse(amountController.text.toString());
                                    dbRef.child(uId.toString()).update({"wallet": totAmtRec.toString()}).then((val) {
                                      Fluttertoast.showToast(
                                          msg: "Transfered SuccessFully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      amountController.clear();
                                    });

                                  });

                            });

                          } else {
                            print("no money");
                          }
                        });*/

                        // =======================================
                        /*dbRef1.child(lUid.toString()).once().then((value) {
                        print("loginID Wallate____" +
                            value.snapshot.child("wallet").value.toString());
                        loginWallateData =
                            value.snapshot.child("wallet").value.toString();

                        dbRef1.child(uId.toString()).once().then((value) {
                          print("userID Wallate____" +
                              value.snapshot.child("wallet").value.toString());
                          userWallateData =
                              value.snapshot.child("wallet").value.toString();

                          if (double.parse(loginWallateData) >=
                              double.parse(*/
                        /*amountController.text.toString()*/ /*inputedAmount.toString())) {
                            double loginW = double.parse(loginWallateData) -
                                double.parse(amountController.text.toString()*/ /*inputedAmount.toString()*/ /*);
                            print("loginW_____"+loginW.toString());

                            double userW = double.parse(userWallateData) +
                                double.parse(amountController.text.toString()*/ /*inputedAmount.toString()*/ /*);
                            print("userW_______"+userW.toString());
                            dbRef1.child(lUid.toString()).update(
                                {"wallet": loginW.toString()}).then((value) {
                              dbRef1.child(uId.toString()).update(
                                  {"wallet": userW.toString()}).then((value) {
                                Fluttertoast.showToast(
                                    msg: "Transfered SuccessFully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                amountController.clear();
                                Navigator.pop(context);
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                    msg: error.toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              });
                            }).catchError((error) {
                              Fluttertoast.showToast(
                                  msg: error.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });

                          } else {
                            Fluttertoast.showToast(
                                msg: "you have insufficient balance",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }).catchError((error) {
                          Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }).catchError((error) {
                        Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                      if (amountController.text.toString().isEmpty) {
                        // webViewMethod();
                        Fluttertoast.showToast(
                            msg: "Please Enter Amount.......",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        amountController.clear();
                      }*/
                      },
                      child: Text(
                        "Pay",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),);}
    )));
  }

  payment() async {
    progress = ProgressHUD.of(ctxProgressLP);
    progress.show();
    Timer(Duration(seconds:2), () {
      try {
        progress.dismiss();
      } catch (e) {}
    });
    dbRef1.child(lUid.toString()).once().then((value) {
      var senderRs =
      value.snapshot.child("wallet").value.toString();

      if (double.parse(senderRs) >
          double.parse(amountController.text.toString())) {
        print("send");

        var totAmt = double.parse(senderRs) - double.parse(amountController.text.toString());
        print("final amt=-=-=>"+totAmt.toString());

        dbRef1.child(lUid.toString()).update(
            {"wallet": totAmt.toString()}).then((value) {
          dbRef.child(uId.toString()).once().then((value) {
            var receiverRs = value.snapshot.child("wallet").value.toString();
            var totAmtRec = double.parse(receiverRs) + double.parse(amountController.text.toString());
            dbRef.child(uId.toString()).update({"wallet": totAmtRec.toString()}).then((val) {
              Fluttertoast.showToast(
                  msg: "Transfered SuccessFully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
              amountController.clear();
            });

          });

        });

      } else {
        print("no money");
      }
    });

  }
}
