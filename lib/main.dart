import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/ForgotPassword.dart';
import 'package:soughted/Pages/Otp.dart';
import 'package:soughted/Pages/verifiecation.dart';
import 'Data/model/ProfileData.dart';
import 'Data/model/User.dart';
import 'Pages/HomePage.dart';
import 'Pages/SignUpPage.dart';
import 'Pages/SplashScreen.dart';
import 'Pages/ProfileCreater/createProfile.dart';
import 'Pages/loginPage.dart';

// List<User> Users;
// List<User> userDetails = [];
ProfileData model;
MentorProfileData mMentorModel;
int logintype=0;
// Database db;
var emailfild =true;
var contryCode ="+91";
SignupRequest userdata;
var  newDataList=[];
FirebaseApp app;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: "1:829678846443:web:0c53366757c9c77a9759ae",
      apiKey: "AIzaSyCZDTUXXrFEYcL2-haVEq3EsrxFxSR6nzE",
      projectId: 'squghted',
      messagingSenderId: '829678846443',
      databaseURL: "https://squghted-default-rtdb.firebaseio.com",
      storageBucket: "squghted.appspot.com",
    ): FirebaseOptions(
      appId: "1:829678846443:web:0c53366757c9c77a9759ae",
      apiKey: "AIzaSyCZDTUXXrFEYcL2-haVEq3EsrxFxSR6nzE",
      messagingSenderId: '829678846443',
      projectId: 'squghted',
      databaseURL: "https://squghted-default-rtdb.firebaseio.com",
      storageBucket: "squghted.appspot.com",
    ),
  );
  model = ProfileData();
  mMentorModel=MentorProfileData();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en',"US"), Locale('kn',"IN")],
          path: 'assets/translations', // <-- change patch to your
          fallbackLocale: Locale('en', 'US'),
          child: MyApp()
      )
  );
}
var routes = <String, WidgetBuilder>{
  "/intro": (BuildContext context) => LoginPage(),
  "/login": (BuildContext context) => LoginPage(),
  "/CreateProfil": (BuildContext context) => CreateProfile(),
  "/home": (BuildContext context) =>  HomePage(),
  "/SignUpPage": (BuildContext context) => SignUpPage(),
  "/forgotpassword": (BuildContext context) => ForgotPassword(),
  "/verifiecation": (BuildContext context) => verifiecation(ModalRoute.of(context).settings.arguments),
  "/otp": (BuildContext context) => Otp(ModalRoute.of(context).settings.arguments),
};
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: routes

    );
  }

}


