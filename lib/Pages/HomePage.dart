import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Pages/Messages/Messages.dart';
import 'package:soughted/Pages/Notes/Notes.dart';
import 'package:soughted/Pages/Notification/Notification.dart';
import 'package:soughted/Pages/Profile/Profile.dart';
import 'package:soughted/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'Dashbord/DashBoardPage.dart';
import 'Dashbord/ProfileView.dart';
import 'dart:convert';

var status="";
var item;

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController controller;


  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    var ref = database.reference();
    ref.child('UserType').child(userdata.id).onValue.listen((e) {
      var datasnapshot = e.snapshot.value;
      if (datasnapshot != null) {
        setState(() {
          model=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot)));
        });
        //  CheckRequest();
      }
    });
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        controller.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.linear);
      },
      child: Scaffold(
        body: PageView(
          physics:new NeverScrollableScrollPhysics(),
          controller: controller,
          children:<Widget> [
            DashBoardPage(controller:controller ,onDataCallback: (Data){
              print(Data.userId);
              setState(()=>item=Data.userId);
              controller.animateToPage(5, duration: Duration(milliseconds: 1), curve: Curves.linear);

            },),
            Messages(controller),
            Notifications(controller),
            Profile(controller),
            Notes(controller:controller,onDataCallback: (Data){
              setState(()=>item=Data);
              controller.animateToPage(5, duration: Duration(milliseconds: 1), curve: Curves.linear);
            },),
            ProfileView(controller,item),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor:Color(0xFFf3f3f3),
            onTap: (int item){
              controller.animateToPage(item, duration: Duration(milliseconds: 1), curve: Curves.linear);
            },
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                label:'Messages',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.notifications),
                label:'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label:'Profile',
              )
            ]
        ),
      ),
    );
  }
}
