import 'package:flutter/material.dart';
import 'package:soughted/Data/model/SignupRequest.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");

  }

  static void goToCreateProfil(BuildContext context) {
    Navigator.popAndPushNamed(context, "/CreateProfil");
  }

  static void goToSignUpPage(BuildContext context) {
    Navigator.pushNamed(context, "/SignUpPage");
  }
  static void goToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, "/forgotpassword");

  }
  static void goToverifiecation(BuildContext context,SignupRequest userid) {
    Navigator.pushNamed(context, "/verifiecation",arguments:userid.toJson());
  }
  static void goOtpPage(BuildContext context,SignupRequest userid) {
    Navigator.pushNamed(context, "/otp",arguments:userid.toJson());
  }
}