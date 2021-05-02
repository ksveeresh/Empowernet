import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/SharedPref.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/main.dart';
import 'my_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<PopupMenuItem> popList = [];

  List<String> menus = ['English', 'kannada'];
  final GlobalKey _menuKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    userCheck();
    for (int index = 0; index < menus.length; index++) {
      popList.add(new PopupMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${menus[index]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        value: menus[index],
      ));
    }

    // UsersViewModel.loadPlayers(context);
  }

  @override
  Widget build(BuildContext context) {
    context.findAncestorStateOfType<_SplashScreenState>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF4990e2)),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Image(image:AssetImage('assets/logo.png'),width: 300,height: 200,),
            Container(
              padding: EdgeInsets.only(left: 5,right: 5,bottom: 10),
              child:Column(
                children: [
                Container(
                height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(

                        child: MyButtonFormField(onPressed: (){
                          MyNavigator.goToSignUpPage(context);
                        },

                          btn_name: "btn_join".tr(),color: Colors.white,fontcolor: Colors.black,),
                        padding: EdgeInsets.only(left: 20,right: 20),
                      ),

                      Container(
                        child:  MyButtonFormField(onPressed: (){
                          MyNavigator.goToLogin(context);
                        },
                            btn_name: "btn_sign_in".tr(),color: Colors.white,fontcolor: Colors.black),
                        padding: EdgeInsets.only(left: 20,right: 20),
                      ),
                    ],) ,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: (){
                          dynamic state = _menuKey.currentState;
                          state.showButtonMenu();
                        },
                        child: Text(
                          "txt_ChooseLanguage".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                        key: _menuKey,
                        onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem),
                        itemBuilder: (BuildContext context) => popList,
                        tooltip: "Tap me to select a number.",
                      ),

                    ],
                  )
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
  Widget Button(String s) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width-20,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[

        ],
        color:Colors.white ,
      ),
      child: Text(s, style: TextStyle(fontSize: 20, color: Color(0xFF4990e2)),),
    );
  }

  handlePopUpChanged(selectedDropDownItem) {
    setState(() {
      selectedDropDownItem=="kannada"?EasyLocalization.of(context).locale= Locale('kn',"IN"):EasyLocalization.of(context).locale= Locale('en',"US");
    });
  }

  Future<void> userCheck() async {
    var data = await SharedPref().read("UserData");
    print(data);
    if(data!=""){
      userdata =SignupRequest.fromJson(data);
      if(userdata.status==0) {
        MyNavigator.goToCreateProfil(context);
      }else{
        MyNavigator.goToHome(context);
      }
    }

  }

}

