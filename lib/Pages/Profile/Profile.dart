import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:soughted/Data/model/Languages.dart';
import 'package:soughted/main.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/widgetHelper/ProfileWidget.dart';

import 'dart:convert';
import 'package:flag/flag.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:soughted/widgetHelper/WorkWidget.dart';
import 'package:soughted/widgetHelper/EducationWidget.dart';

List<dynamic> _selectedtwitterResult = [];
class Profile extends StatefulWidget {
  PageController controller;
  Profile(this.controller);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseReference ref;


  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    ref
        .child('UserType')
        .child(userdata.id)
        .onValue
        .listen((e) {
      var datasnapshot = e.snapshot.value;
      if (datasnapshot != null) {
        setState(() {
          model = ProfileData.fromJson(
              jsonDecode(EncryptModel().Decryptedata(datasnapshot)));
        });
        //  CheckRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b91e3),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(child: model != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: 50, top: 50, left: 0, right: 0),

                child: Container(
                  child:
                  Stack(children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(model.personl.firestName,
                                        style: TextStyle(color: Colors.white),),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(model.personl.lastName,
                                        style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(

                                        child: Container(
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image(
                                              image: AssetImage(
                                                'assets/edit.png',),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () async {
                                          await Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) {
                                                    return ProfileDialog();
                                                  },
                                                  fullscreenDialog: true
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),

                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(model.personl.occupation,
                                    style: TextStyle(color: Colors.white),),
                                ),
                                Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(model.personl.gander,
                                    style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flag(model.personl.country_loc_code,
                                    height: 30, width: 30, fit: BoxFit.fill),
                                SizedBox(width: 10),
                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.personl.city == null ? "-" : model
                                        .personl.city,
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [

                                          Text(LoadLang(model.personl.Lang),
                                            style: TextStyle(
                                                color: Colors.white),)
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return EducationDialog();
                                      },
                                      fullscreenDialog: true
                                  ));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Image(image: AssetImage(
                                              'assets/graduation.png'),
                                            width: 25,
                                            height: 25,),
                                        ),
                                        WidgetSpan(
                                          child: SizedBox(width: 10,),
                                        ),
                                        TextSpan(
                                            text: "Education",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white,
                                              decoration: TextDecoration
                                                  .underline,)
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return EducationDialog();
                                              },
                                              fullscreenDialog: true
                                          ));
                                    },
                                    child: Container(
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image(
                                          image: AssetImage('assets/edit.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      width: 25,
                                      height: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(children: buildEducationalItems(
                                model.educational)),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Image(image: AssetImage(
                                            'assets/work_img.png'),
                                          width: 25,
                                          height: 25,),
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(width: 5,),
                                      ),
                                      TextSpan(
                                          text: "Work Experience",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                            decoration: TextDecoration
                                                .underline,)
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return WorkDialog();
                                            },
                                            fullscreenDialog: true
                                        ));
                                  },
                                  child: Container(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image(
                                        image: AssetImage('assets/edit.png',),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    width: 25,
                                    height: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(children: buildWorkItems(model.work)),
                          ),

                        ],
                      ),
                    ),
                    FractionalTranslation(
                        translation: Offset(0.0, -0.4),
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: userdata.profile_img == "" ? Align(
                            alignment: FractionalOffset(0.5, 0.0),
                            child: CircleAvatar(
                              radius: 40.0,
                              child: Icon(Icons.camera_alt),
                            ),
                          ) : StreamBuilder<Uri>(
                            stream: DownLoadUrl().asStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Align(
                                  alignment: FractionalOffset(0.5, 0.0),
                                  child: CircleAvatar(radius: 40.0,
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                              Color>(Colors.white))),
                                );
                              }
                              return Align(
                                  alignment: FractionalOffset(0.5, 0.0),
                                  child: Container(
                                    width: 75.0,
                                    height: 75.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              snapshot.data.toString())
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )
                    ),
                  ],),
                ),
              ),

            ],
          ) : Container()),
        ),
      ),
    );
  }

  String LoadLang(List<dynamic> lang) {
    print(lang);
    String s = "";
    lang.forEach((element) {
      s += "${(element as Map)["Lang"]}(${(element as Map)["type"] == 0
          ? "bng"
          : (element as Map)["type"] == 1 ? "int" : "adv"}),";
    });
    if (s == "") {
      s = "-";
    }
    return s;
  }

  buildWorkItems(List<WorkListBean> work) {
    var widgets = <Widget>[];
    work.forEach((element) {
      widgets.add(Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Text("${element.position},${element.type_work}",
                  style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.company, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${element.startdate} - ${element.enddate}",
                  style: TextStyle(color: Colors.white),)
              ],
            ),
          )

        ],),
      ));
    });
    return widgets;
  }

  List<Widget> buildEducationalItems(List<EducationalListBean> educational) {
    var widgets = <Widget>[];
    educational.forEach((element) {
      widgets.add(Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Text(element.educationlavel,
                  style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.university, style: TextStyle(color: Colors.white),)
              ],
            ),
          )

        ],),
      ));
    });
    return widgets;
  }

  Future<Uri> DownLoadUrl() async {
    String strURL = await FirebaseStorage.instance.refFromURL(
        'gs://squghted.appspot.com/images/')
        .child('${model.personl.firestName}_${model.personl.lastName}.png')
        .getDownloadURL();
    return Uri.parse(strURL);
    //  return fb.storage()
  }


}
class EducationDialog extends StatefulWidget {
  @override
  _EducationDialogState createState() => _EducationDialogState();
}

class _EducationDialogState extends State<EducationDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body: EducationWidget(),
    );;
  }
}
class WorkDialog extends StatefulWidget {
  @override
  _WorkDialogState createState() => _WorkDialogState();
}

class _WorkDialogState extends State<WorkDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body: WorkWidget(),
    );
  }
}

class ProfileDialog extends StatefulWidget {
  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor:Color(0xFF4b91e3),
          body:
          SafeArea(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child:ProfileWidget(),
                )
            ),
          )
    );
  }
}


