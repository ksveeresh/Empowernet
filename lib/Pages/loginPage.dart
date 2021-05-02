import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/SharedPref.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/main.dart';
import 'my_navigator.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  String user_id, password;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FacebookLogin fblogin =FacebookLogin();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool isLoading = false;
  bool isLoggedIn = false;
  bool _obscureText = true;
  DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
  }

  Widget _title() {
    return Image(
      image: AssetImage(
        'assets/logo.png',
      ),
      width: 300,
      height: 150,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      color: Color(0xFF4b91e3),
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  _title(),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        height: 40,
                        child: TextField(
                          cursorColor: Colors.white,
                          enabled: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            widget.user_id = text;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: false,
                        ),
                      ),
                      Divider(
                        height: 3,
                        thickness: 3,
                        color: Colors.white,
                      ),
                      Text(
                        "txt_Username".tr(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        height: 40,
                        child: TextField(
                          cursorColor: Colors.white,
                          enabled: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            widget.password = text;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                      Divider(
                        height: 3,
                        thickness: 3,
                        color: Colors.white,
                      ),
                      Text(
                        "txt_Password".tr(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        MyNavigator.goToForgotPassword(context);
                      },
                      child: Text('txt_ForgotPassword'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Color(0xFFcfe2f3),
                              textColor: Color(0xFF444444),
                              onPressed: () async {
                                if (widget.user_id == null) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Email address/Phone number",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                if (widget.password == null) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                var ref1 = ref.child('Users');

                                ref.child('Usersids').child(EncryptModel().Encryptedata(widget.user_id).toString().replaceAll("/", "*")).onValue.listen((e) {
                                  var datasnapshot = e.snapshot.value;
                                  if(datasnapshot!=null){
                                    ref1.child(datasnapshot).onValue.listen((e) {
                                      var datasnapshot = e.snapshot.value;
                                      if(datasnapshot==null){
                                        Fluttertoast.showToast(
                                            msg: "User does not exist",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        var jsonData= jsonDecode(EncryptModel().Decryptedata(datasnapshot)) ;
                                        if(jsonData["password"].toString().toLowerCase()==widget.password.toString().toLowerCase()){
                                          userdata =SignupRequest.fromJson(jsonData);
                                          SharedPref().saveValue("UserData", userdata.toJson());
                                          if(userdata.status==0) {
                                            MyNavigator.goToCreateProfil(context);
                                          }else{
                                            MyNavigator.goToHome(context);
                                          }
                                        }else{
                                          Fluttertoast.showToast(
                                              msg: "Invalid password. please try again",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                      }
                                    });
                                  }
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "btn_sign_in".tr(),
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Color(0xFF444444),
                                  ),
                                ],
                              ),
                            )),
                          ])),

                  // _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }


}
