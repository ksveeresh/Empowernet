import 'dart:convert';
import 'package:flag/flag.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soughted/Pages/HomePage.dart' as hp;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileView extends StatefulWidget {
  PageController controller;
  var item;

  ProfileView(this.controller,this.item);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  ProfileData menteesItem;

  DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    LoadUserData();


  }
  @override
  void didUpdateWidget(covariant ProfileView oldWidget) {
    super.didUpdateWidget(oldWidget);
    userdata.id;
    LoadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(child:menteesItem!=null?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 50,top: 50,left: 0,right: 0),

                child:Container(
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
                                  child: Text(menteesItem.personl.firestName,style: TextStyle(color: Colors.white),),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(menteesItem.personl.lastName,style: TextStyle(color: Colors.white),),
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
                                  child: Text(menteesItem.personl.occupation,style: TextStyle(color: Colors.white),),
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
                                  child: Text(menteesItem.personl.gander,style: TextStyle(color: Colors.white),),
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
                                Flag(menteesItem.personl.country_loc_code,
                                    height: 30, width: 30, fit: BoxFit.fill),
                                SizedBox(width: 10),
                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Text(menteesItem.personl.city==null?"-":menteesItem.personl.city,style: TextStyle(color: Colors.white),  maxLines: 3,
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Text(LoadLang(menteesItem.personl.Lang),style: TextStyle(color: Colors.white),)
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
                            child: Column(children:buildEducationalItems(menteesItem.educational)),
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

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(children:buildWorkItems(menteesItem.work)),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(

                                  child: MyButtonFormField(onPressed: (){
                                    if(hp.status=="1"){
                                      CancelRequest();
                                    }
                                  },

                                    btn_name:hp.status=="1"?"Decline":"Message",color: Colors.white,fontcolor: Colors.black,),
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                ),

                                Container(
                                  child:  MyButtonFormField(onPressed: (){
                                    if(hp.status==""){
                                      sendRequest();
                                    }else if(hp.status=="0"){
                                      CancelRequest();
                                    }else if(hp.status=="1"){
                                      AcceptRequest();
                                    }else if(hp.status=="2"){
                                      CancelRequest();
                                    }
                                  },
                                      btn_name: hp.status==""?"Connect ++":hp.status=="0"?"Cancel Request":hp.status=="1"?"Accept":"Connected",color: Colors.white,fontcolor: Colors.black),
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                ),
                              ],) ,
                          ),
                        ],
                      ),
                    ),
                    FractionalTranslation(
                        translation: Offset(0.0, -0.4),
                        child:GestureDetector(
                          onTap: (){
                          },
                          child:menteesItem.personl.profile_path==null?Align(
                            alignment: FractionalOffset(0.5, 0.0),
                            child:CircleAvatar(radius: 35 ,

                              backgroundColor: Colors.brown.shade800,
                              child:Text(menteesItem.personl.firestName.substring(0, 1).toUpperCase()),
                            ),
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 75,
                                width: 75,
                                child: CachedNetworkImage(
                                  imageUrl: menteesItem.personl.profile_path,
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill,),
                                    ),
                                  ),
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],),
                ),
              ),

            ],
          ):Container()),
        ),
      ),
    );
  }
  String LoadLang(List<dynamic> lang) {
    print(lang);
    String s="";
    lang.forEach((element) {
      s+="${(element as Map)["Lang"]}(${(element as Map)["type"]==0?"bng":(element as Map)["type"]==1?"int":"adv"}),";
    });
    if(s==""){
      s="-";
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
                Flexible(child: Text("${element.position},${element.type_work}",style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.company,style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${element.startdate} - ${element.enddate}",style: TextStyle(color: Colors.white),)
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
                Flexible(child: Text(element.educationlavel,style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.university,style: TextStyle(color: Colors.white),)
              ],
            ),
          )

        ],),
      ));
    });
    return widgets;
  }
  Future<Uri> DownLoadUrl() async {
    String strURL =  await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child('${menteesItem.personl.firestName}_${menteesItem.personl.lastName}.png').getDownloadURL();
   return Uri.parse(strURL);
  //  return fb.storage()
  }

  Future<void> sendRequest() async {
    bool bol=false;
    await ref.child('Friends').child("Request").onValue.listen((e) async {
      var datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        bol = datasnapshot.keys.any((element) => element == "${userdata.id}_${menteesItem.userId}" && element == "${menteesItem.userId}_${userdata.id}");
      } else {
        bol = false;
      }
    });
    if (!bol) {
      print(bol);
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["status"] = 0;
      map["data"] = EncryptModel().Encryptedata(jsonEncode(FriendsRequest(sender_id: userdata.id,mentor_subject: "",msg: "would like to connect with you",sender_profile: userdata.profile_img,sender_name: userdata.name,user_type:userdata.usertype,friends_request_id: "${userdata.id}_${menteesItem.userId}",receiver_id:menteesItem.userId,receiver_name: menteesItem.personl.firestName,receiver_profile: menteesItem.personl.profile_path)));
      await ref.child('Friends').child("Request").child("${userdata.id}_${menteesItem.userId}").set(map);

      Fluttertoast.showToast(
          msg: "Requst Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {

      });
    }
  }
  Future<void> CancelRequest() async {
    await  ref.child('Friends').child("Request").child("${userdata.id}_${menteesItem.userId}").remove();
    var itemkey=ref.child('Notification').child("General").child(widget.item).push().key;
    ref.child('Notification').child("General").child(widget.item).child(itemkey).set(jsonEncode(NotificationData(date:DateTime.now().toUtc().toString(),profile_path:userdata.profile_img,msg:"${userdata.name} rejected your request.",user_id:userdata.id,user_name: userdata.name)));
    Fluttertoast.showToast(
        msg: "Request canceled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    hp.status="";
    setState(() {

    });
  }

  void LoadUserData() {
    print(widget.item);
    ref.child('UserType').child(widget.item).onValue.listen((e) {
      var datasnapshot = e.snapshot.value;
      if (datasnapshot != null) {
        setState(() {
          menteesItem=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot)));
        print(menteesItem.toJson().toString());
        });
       CheckRequest();
      }
    });
  }

  void CheckRequest() {
    ref.child('Friends').child("Request").onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        datasnapshot.keys.forEach((element) {
          if(element.toString().contains(userdata.id)){
            if(element.toString().contains(userdata.id)&&element.toString().contains("${menteesItem.userId}")){
              var item=datasnapshot[element] as Map;
              var subitem=element.toString().split("_");
              if(subitem[1]==userdata.id){
                if(item["status"]==0){
                  hp.status = "1";
                }else{
                  hp.status = item["status"].toString();
                }
              }else{
                hp.status = item["status"].toString();

              }
            }else{
              hp.status="";
            }
          }
        });
        setState(() {

        });
      }else{
        hp.status="";;
        setState(() {

        });
      }
    });
  }
  //
  void AcceptRequest() {
    ref.child('Friends').child("Request").child("${menteesItem.userId}_${userdata.id}").onValue.listen((e) {
        var datasnapshot = e.snapshot.value;
        if(datasnapshot!=null){
          var data=datasnapshot as Map;
          data["status"]=2;
          ref.child('Friends').child("Request").child("${menteesItem.userId}_${userdata.id}").set(data).whenComplete((){
            var itemkey=ref.child('Notification').child("General").child(widget.item).push().key;
            ref.child('Notification').child("General").child(widget.item).child(itemkey).set(jsonEncode(NotificationData(date:DateTime.now().toUtc().toString(),profile_path:userdata.profile_img,msg:"${userdata.name} accepted your request. Start connecting",user_id:userdata.id,user_name: userdata.name)));
            hp.status="2";
            setState(() {

            });
          });
        }
      });
  }
}
