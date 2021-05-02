import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/SubjectRequst.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Pages/Dashbord/itemCard.dart';
import 'package:soughted/main.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:soughted/widgetHelper/MyTextFormField.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';



class DashBoardPage extends StatefulWidget {
  PageController controller;
  Function onDataCallback;
  DashBoardPage({this.controller, this.onDataCallback});

  @override
  _DashBoardPageState createState() => _DashBoardPageState();

}
class _DashBoardPageState extends State<DashBoardPage> {
  TextEditingController controller = new TextEditingController();
  TextEditingController SubjectNamecontroller = new TextEditingController();
  TextEditingController SubjectDescontroller = new TextEditingController();
  List<SubjectRequest> players=[];
  List<SubjectRequest> players1=[];

  bool filter=false;
  bool Sendingreqst =false;
  bool MentorshipType=false;
  bool GenderFlag=false;
  bool SizeFlag=false;
  bool LangFlag=false;
  bool Langtype=false;
  int Mentorshiptype=0;
  List GroupSize=[
    {'value':false,'name':'Individual'},
    {'value':false,'name':'Group <3'},
    {'value':false,'name':'Group <6'},
    {'value':false,'name':'Group <15'}
  ];
  List Academiclist=[
    {'value':false,'name':'Math – Algebra'},
    {'value':false,'name':'English Literature'},
    {'value':false,'name':'English Grammar'},
    {'value':false,'name':'Math – Geometry'},
  ];
  List Careerlist=[
    {'value':false,'name':'Consultant'},
    {'value':false,'name':'Arts Painting'},
    {'value':false,'name':'Computer Engineer'},
    {'value':false,'name':'Business Development'},
  ];
  List Gender=[
    {'value':false,'name':'Male'},
    {'value':false,'name':'Female'},
    {'value':false,'name':'Others'}
  ];
  List Support=[
    {'value':false,'name':'Type of Support'},
    {'value':false,'name':'General'},
    {'value':false,'name':'Skill Development'},
    {'value':false,'name':'Resume Support'},
    {'value':false,'name':'Other'},

  ];
  PersistentBottomSheetController _controller; // <------ Instance variable
  String textGroupSizepopList="Size";
  String textGenderpopList="Gender";
  String textSupportpopList="Type of Support";
  List<PopupMenuItem> SupportpopList = [];
  DatabaseReference ref;

  var SelectReqitem;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    if(userdata.status==1) {
      userdata.mentorship_type = 0;
    }
    ref.child("SubjectRequest").onValue.listen((e) {
      if(e!=null){
        players.clear();
        ((e as Event).snapshot.value as Map).forEach((key, value) {
          if(key=="Academic"){
            (value as Map).forEach((key, value) {
              var item=SubjectRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(value)));
              players1.add(item);
            });
          }else{
            (value as Map).forEach((key, value) {
              var item=SubjectRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(value)));
              players.add(item);

            });
          }

        });
        setState(() {

        });
      }

    });
    LoadData();
  }

  @override
  void didUpdateWidget(covariant DashBoardPage oldWidget) {
    super.didUpdateWidget(oldWidget);


  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          model.usertype=="mentee"?GestureDetector(
                            onTap: (){
                              setState(() {
                                Sendingreqst=Sendingreqst==true?false:true;
                              });

                            },
                            child:Container(
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image(
                                  image: AssetImage('assets/sendReq.png',),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ):Container(),
                          SizedBox(width: 5),
                          Flexible(
                            child: Container(
                              height: 40,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(6.0),
                                    topRight: const Radius.circular(6.0),
                                    bottomLeft: const Radius.circular(6.0),
                                    bottomRight: const Radius.circular(6.0),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(
                                    child: TextField(
                                      enabled: true,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        hintText: "Select a Career Area",
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (text) {

                                      },
                                      keyboardType:TextInputType.text,
                                      obscureText:false,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      padding:EdgeInsets.all(5),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image(
                                          image: AssetImage('assets/search.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                    ),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.only(left: 10,right: 10),
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                filter=filter==true?false:true;
                              });
                              // LoadBootmSheet();
                            },
                            child: Container(
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image(
                                  image: AssetImage('assets/filter.png',),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: (){
                              widget.controller.animateToPage(4, duration: Duration(milliseconds: 1), curve: Curves.linear);
                            },
                            child: Container(
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image(
                                  image: AssetImage('assets/notes.png',),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width:MediaQuery
                          .of(context)
                          .size.width ,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:loadDasbord(),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: Sendingreqst,
                  child: Positioned(
                      top: 52,
                      left: 10,
                      child:  Container(
                        padding: EdgeInsets.all(10),
                        width:MediaQuery.of(context).size.width-40,
                        decoration: new BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(20.0),
                              topRight: const Radius.circular(20.0),
                              bottomLeft: const Radius.circular(20.0),
                              bottomRight: const Radius.circular(20.0),
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Send Subject or Career Area Request ",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Type of Mentorship",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                  setState(() {
                                    MentorshipType=MentorshipType==true?false:true;
                                  });
                                },
                                )
                              ],
                            ),
                            Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                            Visibility(
                              visible: true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width:MediaQuery.of(context).size.width/1.5,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFFd0e2f2),
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(0.0),
                                          topRight: const Radius.circular(0.0),
                                          bottomLeft: const Radius.circular(10.0),
                                          bottomRight: const Radius.circular(10.0),
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              Mentorshiptype=0;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Academic Tutoring',style: TextStyle(color: Colors.black),),
                                                SizedBox(height:20,width:20,child: Checkbox(value: Mentorshiptype==0,onChanged: (s){
                                                  setState(() {
                                                    Mentorshiptype=0;
                                                  });
                                                },))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              Mentorshiptype=1;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Career Mentorship',style: TextStyle(color: Colors.black),),
                                                SizedBox(height:20,width:20,child: Checkbox(value: Mentorshiptype==1,onChanged: (s){
                                                  setState(() {
                                                    Mentorshiptype=1;
                                                  });
                                                },))
                                              ],
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ],
                              ),),
                            Container(
                              child:Row(children: [
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TypeAheadField(
                                        textFieldConfiguration: TextFieldConfiguration(
                                            controller: SubjectNamecontroller,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                                border: InputBorder.none
                                            )
                                        ),
                                        hideOnEmpty: true,
                                        hideOnLoading: true,
                                        suggestionsCallback: (pattern) async {
                                          print(pattern);
                                          return await LoadList(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion.subject_name),
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          SelectReqitem=suggestion;
                                          SubjectNamecontroller.text=suggestion.toString();
                                        },
                                      ),
                                      Divider(height: 3,thickness:3 ,color: Color(0xFF4b91e3),),
                                      Text("Specify Subject or Career Area",style: TextStyle(color: Colors.black),)
                                    ],
                                  ),
                                )
                              ],),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(6.0),
                                    topRight: const Radius.circular(6.0),
                                    bottomLeft: const Radius.circular(6.0),
                                    bottomRight: const Radius.circular(6.0),
                                  ),
                                  border: Border.all(
                                    color: Color(0xFF4b91e3),
                                    width: 3,
                                  )
                              ),
                              child: TextField(
                                enabled: true,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  hintText: "Additional Detail",
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {

                                },
                                keyboardType:TextInputType.text,
                                obscureText:false,
                                maxLines: 3,
                                controller: SubjectDescontroller,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                MyButtonFormField(onPressed: (){
                                  print(SelectReqitem.toString().trim()!=SubjectNamecontroller.text.toString().trim());
                                  if(SubjectNamecontroller.text.toString().trim()==""){
                                    return;
                                  }
                                  if(SelectReqitem.toString().trim()!=SubjectNamecontroller.text.toString().trim()){
                                    var id= ref.child('SubjectRequest').child(Mentorshiptype==0?"Academic":"Career").push().key;
                                    var mSenders = new List<Senders>.empty(growable: true);
                                    mSenders.add(Senders(senderId: model.userId,senderName: model.personl.firestName,senderPeofile: model.personl.profile_path,senderOcupation: model.personl.occupation,senderDes: SubjectDescontroller.text.toString().trim()));
                                    SubjectRequest data= SubjectRequest(subject_mentorship:Mentorshiptype==0?"Academic":"Career",subject_name:SubjectNamecontroller.text.toString().trim(),subject_id:id,req_count: 1,sender_ids: model.userId,senders: mSenders);
                                    ref.child('SubjectRequest').child(Mentorshiptype==0?"Academic":"Career").child(id).set(EncryptModel().Encryptedata(jsonEncode(data)));
                                    SubjectNamecontroller.clear();
                                    SubjectDescontroller.clear();
                                    Fluttertoast.showToast(
                                        msg:"Request message sent",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    setState(() {
                                      Sendingreqst=Sendingreqst==true?false:true;
                                    });
                                  }else{
                                    var item;
                                    if(Mentorshiptype==0){
                                      item = players1.firstWhere((element) => element.subject_name.toString().trim()==SelectReqitem.toString().trim());
                                    }else{
                                      item = players.firstWhere((element) => element.subject_name.toString().trim()==SelectReqitem.toString().trim());
                                    }
                                    if(item!=null) {
                                      if (!item.sender_ids.toString().contains(model.userId)) {
                                        item.senders.add(Senders(senderId: model.userId,senderName: model.personl.firestName,senderPeofile: model.personl.profile_path,senderOcupation: model.personl.occupation,senderDes: SubjectDescontroller.text.toString().trim()));
                                        SubjectRequest data = SubjectRequest(
                                            subject_mentorship: item
                                                .subject_mentorship,
                                            subject_name: item.subject_name
                                                .toString().trim(),
                                            subject_id: item.subject_id,
                                            req_count: item.req_count + 1,
                                            sender_ids: item.sender_ids +=
                                            "_${model.userId}");
                                        ref.child('SubjectRequest').child(item.subject_mentorship).child(item.subject_id).set(EncryptModel().Encryptedata(jsonEncode(data)));
                                        SubjectNamecontroller.clear();
                                        SubjectDescontroller.clear();
                                        Fluttertoast.showToast(
                                            msg:"Request message sent",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                        setState(() {
                                          Sendingreqst=Sendingreqst==true?false:true;
                                        });
                                      }else{
                                        SubjectNamecontroller.clear();
                                        SubjectDescontroller.clear();
                                        Fluttertoast.showToast(
                                            msg:"Request message was already sent",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                        setState(() {
                                          Sendingreqst=Sendingreqst==true?false:true;
                                        });
                                      }
                                    }
                                  }


                                },
                                  color: Color(0xFF4b91e3),
                                  btn_name: "Send Request",
                                  fontcolor: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                Visibility(
                  visible: filter,
                  child:  Positioned(
                    top: 52,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width:MediaQuery.of(context).size.width-75,
                      decoration: new BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(0.0),
                            topRight: const Radius.circular(0.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,

                                        children: [
                                          MyButtonFormField(onPressed: (){
                                            GroupSize.forEach((element) {
                                              element["value"]=false;
                                            });
                                            Academiclist.forEach((element) {
                                              element["value"]=false;
                                            });
                                            Careerlist.forEach((element) {
                                              element["value"]=false;
                                            });
                                            Gender.forEach((element) {
                                              element["value"]=false;
                                            });
                                            Support.forEach((element) {
                                              element["value"]=false;
                                            });
                                            setState(() {

                                            });
                                          },
                                            color: Color(0xFF4b91e3),
                                            btn_name: "Clear Filters",
                                            fontcolor: Colors.white,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Type of Mentorship",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                          GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                            setState(() {
                                              MentorshipType=MentorshipType==true?false:true;
                                              Langtype=false;
                                              GenderFlag=false;
                                              SizeFlag=false;
                                              LangFlag=false;
                                            });
                                          },
                                          )
                                        ],
                                      ),
                                      Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                      Visibility(
                                        visible: MentorshipType,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width:MediaQuery.of(context).size.width/1.5,
                                              decoration: new BoxDecoration(
                                                  color: Color(0xFFd0e2f2),
                                                  borderRadius: new BorderRadius.only(
                                                    topLeft: const Radius.circular(0.0),
                                                    topRight: const Radius.circular(0.0),
                                                    bottomLeft: const Radius.circular(10.0),
                                                    bottomRight: const Radius.circular(10.0),
                                                  )
                                              ),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        Mentorshiptype=0;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Academic Tutoring',style: TextStyle(color: Colors.black),),
                                                          SizedBox(height:20,width:20,child: Checkbox(value: Mentorshiptype==0,onChanged: (s){
                                                            setState(() {
                                                              Mentorshiptype=0;
                                                            });
                                                          },))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        Mentorshiptype=1;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Career Mentorship',style: TextStyle(color: Colors.black),),
                                                          SizedBox(height:20,width:20,child: Checkbox(value: Mentorshiptype==1,onChanged: (s){
                                                            setState(() {
                                                              Mentorshiptype=1;
                                                            });
                                                          },))
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(Mentorshiptype==0?"Academic Tutoring":"Career Area",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                          GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                            setState(() {
                                              Langtype=Langtype==true?false:true;
                                              MentorshipType=false;
                                              GenderFlag=false;
                                              SizeFlag=false;
                                              LangFlag=false;
                                            });

                                          },
                                          )
                                        ],
                                      ),
                                      Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                      Visibility(
                                        visible: Langtype,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width:MediaQuery.of(context).size.width/2,
                                              padding: EdgeInsets.all(10),
                                              decoration: new BoxDecoration(
                                                  color: Color(0xFFd0e2f2),
                                                  borderRadius: new BorderRadius.only(
                                                    topLeft: const Radius.circular(0.0),
                                                    topRight: const Radius.circular(0.0),
                                                    bottomLeft: const Radius.circular(10.0),
                                                    bottomRight: const Radius.circular(10.0),
                                                  )
                                              ),
                                              child: Column(
                                                children: typeLoad(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Language",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                          GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                            setState(() {
                                              LangFlag=LangFlag==true?false:true;
                                              Langtype=false;
                                              MentorshipType=false;
                                              GenderFlag=false;
                                              SizeFlag=false;
                                            });
                                          },
                                          )
                                        ],
                                      ),
                                      Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                      Visibility(
                                        visible: LangFlag,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width:MediaQuery.of(context).size.width/2,
                                              decoration: new BoxDecoration(
                                                  color: Color(0xFFd0e2f2),
                                                  borderRadius: new BorderRadius.only(
                                                    topLeft: const Radius.circular(0.0),
                                                    topRight: const Radius.circular(0.0),
                                                    bottomLeft: const Radius.circular(10.0),
                                                    bottomRight: const Radius.circular(10.0),
                                                  )
                                              ),
                                              child: Column(
                                                children: LagLoad(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Gender",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                          GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                            setState(() {
                                              GenderFlag=GenderFlag==true?false:true;
                                              Langtype=false;
                                              MentorshipType=false;
                                              SizeFlag=false;
                                              LangFlag=false;
                                            });
                                          },
                                          )
                                        ],
                                      ),
                                      Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                      Visibility(
                                        visible: GenderFlag,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width:MediaQuery.of(context).size.width/1.5,
                                              decoration: new BoxDecoration(
                                                  color: Color(0xFFd0e2f2),
                                                  borderRadius: new BorderRadius.only(
                                                    topLeft: const Radius.circular(0.0),
                                                    topRight: const Radius.circular(0.0),
                                                    bottomLeft: const Radius.circular(10.0),
                                                    bottomRight: const Radius.circular(10.0),
                                                  )
                                              ),
                                              child: Column(
                                                children: GenderLoad(),
                                              ),
                                            ),
                                          ],
                                        ),),

                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Size",style:TextStyle(fontWeight: FontWeight.w500,color:Colors.black)),
                                          GestureDetector(child: Icon(Icons.arrow_drop_down,color:Color(0xFF4b91e3),size: 30,),onTap: () async {
                                            setState(() {
                                              SizeFlag=SizeFlag==true?false:true;
                                              Langtype=false;
                                              MentorshipType=false;
                                              GenderFlag=false;
                                              LangFlag=false;
                                            });
                                          },
                                          )
                                        ],
                                      ),
                                      Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),
                                      Visibility(
                                        visible: SizeFlag,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width:MediaQuery.of(context).size.width/1.5,
                                              decoration: new BoxDecoration(
                                                  color: Color(0xFFd0e2f2),
                                                  borderRadius: new BorderRadius.only(
                                                    topLeft: const Radius.circular(0.0),
                                                    topRight: const Radius.circular(0.0),
                                                    bottomLeft: const Radius.circular(10.0),
                                                    bottomRight: const Radius.circular(10.0),
                                                  )
                                              ),
                                              child: Column(
                                                children: SizeLoad(),
                                              ),
                                            ),
                                          ],
                                        ),),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          MyButtonFormField(onPressed: (){

                          },
                            color: Color(0xFF4b91e3),
                            btn_name: "SHOW RESULTS ",
                            fontcolor: Colors.white,
                            width: MediaQuery.of(context).size.width-100,
                          )
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),),
      ),

    );

  }


  LoadData() {
    newDataList.clear();
    var ref1 = ref.child('UserType');
    ref1.onValue.listen((e) {
      e.snapshot.key.isNotEmpty;
      ((e as Event).snapshot.value as Map).forEach((key, value) {
        if(key!=userdata.id){
          var item=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(value)));
          if(userdata.usertype!=item.usertype){
            newDataList.add(item);
          }
        }
      });


      setState(() {

      });
    });
  }


  GenderLoad() {
    List<Widget> gender= [];
    Gender.forEach((element) {
      gender.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element["name"],style: TextStyle(color: Colors.black),),
            SizedBox(height:20,width:20,child: Checkbox(value:element["value"],onChanged: (s){
              setState(() {
                element["value"]=s;
              });
            },))
          ],
        ),
      ));
      gender.add(Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),);
    });
    return gender;
    //
    // CheckboxListTile(
    // contentPadding: EdgeInsets.all(0),
    // title: Text('Career Mentorship',style: TextStyle(color: Colors.black),),value: false,),

  }

  SizeLoad() {
    List<Widget> mSize= [];
    GroupSize.forEach((element) {
      mSize.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element["name"],style: TextStyle(color: Colors.black),),
            SizedBox(height:20,width:20,child: Checkbox(value: element["value"],onChanged: (s){
              setState(() {
                element["value"]=s;
              });
            },))
          ],
        ),
      ));
      mSize.add(Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),);
    });
    return mSize;
  }

  LagLoad() {
    List<Widget> mLang= [];
    if(model.personl==null){
      return mLang;
    }
    if(model.personl.Lang!=null){
      model.personl.Lang.forEach((element) {
        mLang.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((element as Map)["Lang"],style: TextStyle(color: Colors.black),),
              SizedBox(height:20,width:20,child: Checkbox(value: Mentorshiptype==1,onChanged: (s){
                setState(() {
                  Mentorshiptype=1;
                });
              },))
            ],
          ),
        ));
        mLang.add(Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),);
      });
    }
    return mLang;
  }

  typeLoad() {
    List<Widget> mLang= [];
    if(Mentorshiptype==0){
      Academiclist.forEach((element) {
        mLang.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element["name"],style: TextStyle(color: Colors.black),),
              SizedBox(height:20,width:20,
                  child: Checkbox(value: element["value"],onChanged: (s){
                    setState(() {
                      element["value"]=s;
                    });
                  },))
            ],
          ),
        ));
        mLang.add(Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),);
      });
    }else if(Mentorshiptype==1){
      Careerlist.forEach((element) {
        mLang.add( Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element["name"],style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
              SizedBox(height:20,width:20,child: Checkbox(value:element["value"],onChanged: (s){
                setState(() {
                  element["value"]=s;
                  Mentorshiptype=1;
                });
              },))
            ],
          ),
        ));
        mLang.add(Divider(height: 3,thickness:3 ,color:Color(0xFF4b91e3),),);
      });
    }


    return mLang;
  }

  LoadList(String pattern) {
    var list = new List<SubjectRequest>.empty(growable: true);
    if(Mentorshiptype==0){
      players1.forEach((element){
        if(element.subject_name.contains(pattern)){
          list.add(element);
        }
      });
    }else{
      players.forEach((element){
        if(element.subject_name.contains(pattern)){
          list.add(element);
        }
      });
    }
    return list;
  }

  loadDasbord() {
    List<Widget> mSize= [];
    if(model.usertype!="mentee") {
      mSize.add(Text("Career Mentorship Requests", style: TextStyle(color: Colors.white)));
      mSize.add(SizedBox(height: 5,));
      mSize.add(SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: players.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child: Text("${players[position].req_count}",style: TextStyle(fontSize: 28)),
                  ),
                  SizedBox(height: 5,),
                  Text(players[position].subject_name,
                      style: TextStyle(color: Colors.white))
                ],
              ),
            );
          },
        ),
      ));
      mSize.add(Text("Academic Tutoring Requests:", style: TextStyle(color: Colors.white)));
      mSize.add(SizedBox(height: 5,));
      mSize.add(SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: players1.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child: Text("${players1[position].req_count}",style: TextStyle(fontSize: 28)),
                  ),
                  SizedBox(height: 5,),
                  Text(players1[position].subject_name,
                      style: TextStyle(color: Colors.white))
                ],
              ),
            );
          },
        ),
      ));
    }
    mSize.add(Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        children: List.generate(newDataList.length, (index) {
          return GestureDetector(
            onTap: (){
              widget.onDataCallback(newDataList[index]);
            },
            child:itemCard(newDataList[index]),
          );
        }
        )  ,
      ),
    ));
    return mSize;
  }
}








