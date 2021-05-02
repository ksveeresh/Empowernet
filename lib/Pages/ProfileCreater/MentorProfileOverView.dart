import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Pages/my_navigator.dart';
import 'package:soughted/main.dart';
// import 'package:firebase/firebase.dart' as fb;

import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
class MentorProfileOverView extends StatefulWidget {
  PageController controller;
  int slideIndex;
  MentorProfileOverView(this.controller,this.slideIndex);

  @override
  _MentorProfileOverViewState createState() => _MentorProfileOverViewState();
}

class _MentorProfileOverViewState extends State<MentorProfileOverView> {
  DatabaseReference ref;


  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFddebf6),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50,top: 50,left: 0,right: 0),

              child:   Container(
                child:
                Stack(children: [
                  Container(
                    width:  MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_FirstName"),
                                        Text(mMentorModel.mMentorPersonlBean.firestName)
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_LastName"),
                                        Text(mMentorModel.mMentorPersonlBean.lastName)
                                      ],
                                    ),
                                  )
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_Headline"),
                                        Text(mMentorModel.mMentorPersonlBean.occupation==""?"-":mMentorModel.mMentorPersonlBean.occupation)
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_gander"),
                                        Text(mMentorModel.mMentorPersonlBean.gander)
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_Location"),
                                        Text(mMentorModel.mMentorPersonlBean.city==""?"-":mMentorModel.mMentorPersonlBean.city),
                                      ],
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_Country"),
                                        Text(mMentorModel.mMentorPersonlBean.country==""?"-":mMentorModel.mMentorPersonlBean.country),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_AreasofInterest"),
                                        Text(mMentorModel.mMentorPersonlBean.AreasInterest.isEmpty?"-":mMentorModel.mMentorPersonlBean.AreasInterest.toString().replaceAll("[", "").replaceAll("]", ""))
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_educationlavel"),
                                        Text(mMentorModel.mMentorPersonlBean.educationlavel==""?"-":mMentorModel.mMentorPersonlBean.educationlavel)
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("txt_Languages"),
                                        Text(mMentorModel.mMentorPersonlBean.Lang.isEmpty?"-":mMentorModel.mMentorPersonlBean.Lang.toString().replaceAll("[", "").replaceAll("]", ""))
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(height: 10,thickness:10 ,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child:RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Image(image:AssetImage('assets/graduation.png'),width: 16,height: 16,),
                                ),
                                TextSpan(
                                    text: "txt_EducationProfile",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a) )
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        ListView.builder(
                            itemCount: mMentorModel.mQuestionData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index){
                              var item=mMentorModel.mQuestionData[index] as QuestionData;
                              return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10,top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.qust),
                                                    Text(item.ans==""?"-":item.ans)
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),

                                  ]
                              );
                            }
                        ),

                      ],
                    ),
                  ),
                  FractionalTranslation(
                      translation: Offset(0.0, -0.4),
                      child:GestureDetector(
                        onTap: (){
                        },
                        child:userdata.profile_img==""?Align(
                          alignment: FractionalOffset(0.5, 0.0),
                          child:CircleAvatar(
                            radius: 40.0,
                            child: Icon(Icons.camera_alt),
                          ),
                        ):StreamBuilder<Uri>(
                          stream: DownLoadUrl().asStream(),
                          builder: (context,snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Align(
                                alignment: FractionalOffset(0.5, 0.0),
                                child:CircleAvatar(radius: 40.0,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))),
                              );
                            }
                            return Align(
                                alignment: FractionalOffset(0.5, 0.0),
                                child:     Container(
                                  width: 75.0,
                                  height: 75.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image:new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(snapshot.data.toString())
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
        ),),
      ),
      bottomSheet:  Container(
        height: 40,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  child:MyButtonFormField(onPressed: (){
                    ref.child('UserType').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(mMentorModel)));
                    userdata.status=1;
                    ref.child('Users').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(userdata)));
                    MyNavigator.goToHome(context);
                  }, width: ( MediaQuery.of(context).size.width/1.2), btn_name: "txt_conform",color: Color(0xFF40aef9),fontcolor:Color(0xFF9fe0ff)),

                ),)]),
      ),
    );;
  }
  Future<Uri> DownLoadUrl() async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child('${userdata.name}_${userdata.lastname}.png').getDownloadURL();;
    return Uri.parse(strURL);

  }
}
