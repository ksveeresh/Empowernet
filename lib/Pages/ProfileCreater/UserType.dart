import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'package:easy_localization/easy_localization.dart';
class Usertype extends StatefulWidget {
  PageController  controller;
  int slideIndex;

  Usertype(this.controller,this.slideIndex);
  @override
  _UsertypeState createState() => _UsertypeState();
}

class _UsertypeState extends State<Usertype> {
  List<Types> _type = new List<Types>();
  bool Mentor=false;
  bool Mentee=false;
  @override
  void initState() {
    super.initState();
    _type.add(new Types("txt_Mentor",Icons.person, false));
    _type.add(new Types("txt_Mentee", Icons.group_rounded, false));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4990e2) ,
      body: Container(
          height:MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/logo.png',),
              width: 300,
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child:Text("txt_SigningUp".tr(),style:TextStyle(fontSize: 16 ,color: Colors.white)),
                )

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                InkWell(
                  child:Image(
                    image: AssetImage('assets/mentee.png',),
                    width: 100,
                    height: 100,
                  ),
                  onTap: () {
                    model.userId=userdata.id;
                    model.usertype="mentee";
                    userdata.usertype="mentee";
                    widget.controller.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);

                  },
                ),
                SizedBox(
                  width: 50,
                ),
                InkWell(
                  child:Image(
                    image: AssetImage('assets/mentor.png',),
                    width: 100,
                    height: 100,

                  ),
                  onTap: () {
                    setState(() {
                      model.usertype="mentor";
                      userdata.usertype="mentor";
                      model.userId=userdata.id;
                      widget.controller.animateToPage(5, duration: Duration(milliseconds: 1), curve: Curves.linear);
                    });
                  },
                ),

              ],),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  decoration: new BoxDecoration(
                      color: Color(0xFFcfe2f3),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0),
                        bottomLeft: const Radius.circular(8.0),
                        bottomRight: const Radius.circular(8.0),
                      )
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 105.0,
                  child: Text("txt_Mentee".tr(),style:TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14 ,)),

                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: Color(0xFFcfe2f3),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0),
                        bottomLeft: const Radius.circular(8.0),
                        bottomRight: const Radius.circular(8.0),
                      )
                  ),
                  width: 105.0,
                  child: Text("txt_Mentor".tr(),style:TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14 ,)),

                ),

              ],)
          ],
        ),
      )

      )
    );

  }

}


class Types {
  String name;
  IconData icon;
  bool isSelected;

  Types(this.name, this.icon, this.isSelected);
}
