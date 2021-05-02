import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Pages/my_navigator.dart';
import 'package:soughted/main.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
class MenteeProfileOverView extends StatefulWidget {
  PageController controller; int slideIndex;
  MenteeProfileOverView(this.controller,this.slideIndex);

  @override
  _MenteeProfileOverViewState createState() => _MenteeProfileOverViewState();
}

class _MenteeProfileOverViewState extends State<MenteeProfileOverView> {
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
      backgroundColor:Color(0xFF4990e2),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(model.personl.firestName,style: TextStyle(color: Colors.white),),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(model.personl.lastName,style: TextStyle(color: Colors.white),),
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
                              Container(
                                alignment: Alignment.center,
                                child: Text(model.personl.occupation,style: TextStyle(color: Colors.white),),
                              ),
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
                                child: Text(model.personl.gander,style: TextStyle(color: Colors.white),),
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
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(model.personl.city==null?"-":model.personl.city,style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5),
                                    Text(model.personl.country==""?"-":model.personl.country,style: TextStyle(color: Colors.white),),
                                  ],
                                ),
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

                                        Text(LoadLang(model.personl.Lang))
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
                          padding: EdgeInsets.all(5),
                          child:Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Image(image:AssetImage('assets/graduation.png'),width: 25,height: 25,),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(width: 10,),
                                    ),
                                    TextSpan(
                                        text: "Education",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ,color:Colors.white, decoration: TextDecoration.underline, )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(children:buildEducationalItems(model.educational)),
                        ),
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(5),
                          child:Row(

                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Image(image:AssetImage('assets/work_img.png'),width: 25,height: 25,),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(width: 5,),
                                    ),
                                    TextSpan(
                                        text: "Work Experience",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ,color:Colors.white, decoration: TextDecoration.underline, )
                                    ),
                                  ],
                                ),
                              ),
                              Image(image:AssetImage('assets/edit.png'),width: 25,height: 25,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(children:buildWorkItems(model.work)),
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
                    ref.child('UserType').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(model)));
                    userdata.status=1;
                    ref.child('Users').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(userdata)));
                    MyNavigator.goToHome(context);
                  }, width: ( MediaQuery.of(context).size.width/1.2), btn_name: "txt_conform",color: Color(0xFF40aef9),fontcolor:Color(0xFF9fe0ff)),

                ),)]),
      ),
    );
  }
  Future<Uri> DownLoadUrl() async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child('${userdata.name}_${userdata.lastname}.png').getDownloadURL();;
    return Uri.parse(strURL);

  }

  String LoadLang(List<dynamic> lang) {
    print(lang);
    String s="";
    lang.forEach((element) {
      s+="${(element as Map)["Lang"]}(${(element as Map)["type"]}),";
    });
    if(s==""){
      s="-";
    }
    return s;
  }

  List<Widget> buildEducationalItems(List<EducationalListBean> educational) {
    var widgets = <Widget>[];
    educational.forEach((element) {
      widgets.add(Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Education Lavel"),
                  Flexible(child: Text(element.educationlavel))
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.university)
              ],
            ),
          )

        ],),
      ));
    });
    return widgets;
  }

  buildWorkItems(List<WorkListBean> work) {
    var widgets = <Widget>[];
    work.forEach((element) {
      widgets.add(Container(
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text("${element.position},${element.type_work}"))
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.company)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${element.startdate} - ${element.enddate}")
              ],
            ),
          )

        ],),
      ));
    });
    return widgets;
  }
}
