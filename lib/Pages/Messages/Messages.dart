import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/Group.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Pages/Messages/AddGroupDialog.dart';
import 'package:soughted/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/Pages/Messages/ChatBot.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Messages extends StatefulWidget {
  PageController controller;
  Messages(this.controller);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  DatabaseReference ref;
  var  DataList=[];

  @override
  void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    ref.child('Friends').onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        DataList.clear();
        if (mounted) {
          setState(() {
            datasnapshot.keys.forEach((element) {
              if(element=="Group"){
                datasnapshot[element].keys.forEach((element1) {
                  Group mGroup=  Group.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot[element][element1]["data"])));
                  if(mGroup.Group_peple.contains(model.userId)){
                    Map<String, dynamic> map = new Map<String, dynamic>();
                    map["status"] = datasnapshot[element][element1]["status"];
                    map["data"] = mGroup;
                    DataList.add(map);
                  }
                });
              }
              if(element=="Request"){
                datasnapshot[element].keys.forEach((element2) {
                  if (element2.toString().contains(userdata.id)) {
                    var subitem = datasnapshot[element][element2] as Map;
                    Map<String, dynamic> map = new Map<String, dynamic>();
                    map["status"] = subitem["status"];
                    map["data"] = FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                    DataList.add(map);
                  }
                });
              }

            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child:RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Messages",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20 ,color:Colors.white )
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children:LadUsers(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LadUsers() {
    var widgets = <Widget>[];
    widgets.add(Serchtoolbar());
    print(DataList.length);
    if(DataList!=null) {
      DataList.forEach((element) {
        widgets.add(InkWell(
          onTap: () async {
            await Navigator.of(context).push(new MaterialPageRoute<String>(
                builder: (BuildContext context) {
                  return ChatBot(element);
                },
                fullscreenDialog: true
            ));
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                element["status"]!=3?element["data"].sender_id == model.userId ?
                element["data"].receiver_profile == "" ?
                Container(
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child: Text(element["data"].sender_name != model.personl
                        .firestName
                        ? element["data"].sender_name.substring(0, 1).toUpperCase()
                        : element["data"].receiver_name.substring(0, 1)
                        .toUpperCase()),
                  ),
                ) :
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: element["data"].receiver_profile,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill,),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ) :
                element["data"].sender_profile == "" ?
                Container(
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child: Text(element["data"].sender_name != model.personl
                        .firestName
                        ? element["data"].sender_name.substring(0, 1).toUpperCase()
                        : element["data"].receiver_name.substring(0, 1)
                        .toUpperCase()),
                  ),
                ) :
                Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  child: CachedNetworkImage(
                    imageUrl: element["data"].sender_profile,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill,),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ):element["data"].Group_img==""?Container(
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.brown.shade800,
                      child:Icon(Icons.group,
                          color: Colors.white)
                    )
                ):Container(),
                SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element["status"]!=3?element["data"].sender_name !=
                              model.personl.firestName ? element["data"]
                              .sender_name : element["data"].receiver_name:element["data"].Group_name,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          element["data"].msg,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                getStat(element) == true ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: MyButtonFormField(onPressed: () {
                          Map<String, dynamic> map = new Map<String, dynamic>();
                          map["status"] = 2;
                          ref.child('Friends').child("Request").child(
                              element["data"].friends_request_id)
                              .update(map)
                              .whenComplete(() => setState(() {}));
                          var itemkey = ref
                              .child('Notification')
                              .child("General")
                              .child(element["data"].sender_id)
                              .push()
                              .key;
                          ref.child('Notification').child("General").child(
                              element["data"].sender_id).child(itemkey).set(
                              jsonEncode(NotificationData(
                                  date: DateTime.now().toUtc().toString(),
                                  profile_path: userdata.profile_img,
                                  msg: "${userdata
                                      .name} accepted your request. Start connecting",
                                  user_id: userdata.id,
                                  user_name: userdata.name)));
                          setState(() {

                          });
                        },
                          btn_name: "Add",
                          color: Colors.white,
                          fontcolor: Colors.black,),
                        padding: EdgeInsets.only(left: 0, right: 0),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 30,
                        child: MyButtonFormField(onPressed: () async {
                          await ref.child('Friends').child("Request").child(
                              element["data"].friends_request_id).remove();
                          var itemkey = ref
                              .child('Notification')
                              .child("General")
                              .child(element["data"].sender_id)
                              .push()
                              .key;
                          ref.child('Notification').child("General").child(
                              element["data"].sender_id).child(itemkey).set(
                              jsonEncode(NotificationData(
                                  date: DateTime.now().toUtc().toString(),
                                  profile_path: userdata.profile_img,
                                  msg: "${userdata
                                      .name} rejected your request.",
                                  user_id: userdata.id,
                                  user_name: userdata.name)));
                          Fluttertoast.showToast(
                              msg: "Request canceled",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          setState(() {

                          });
                        },

                          btn_name: "Delete",
                          color: Colors.white,
                          fontcolor: Colors.black,),
                        padding: EdgeInsets.only(left: 0, right: 0),
                      )
                    ],
                  ),
                ) : Container()
              ],
            ),
          ),
        ));
      });
    }
    return widgets;
  }
  Serchtoolbar(){
    return  Container(
      color:Color(0xFFd0e2f2),
      child: Padding(
        padding: const EdgeInsets.only(left: 4,right: 4,top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size.width-75,
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
                  Container(

                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        prefixIcon: Container(
                          width: 25,
                          height: 25,
                          padding:EdgeInsets.all(10),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage('assets/search.png',),
                              fit: BoxFit.fill,
                            ),
                          ),

                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,

                      ),),
                    width: MediaQuery
                        .of(context)
                        .size.width-125,
                  ),
                  GestureDetector(
                    onTap: () async {

                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      padding:EdgeInsets.all(5),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image(
                          image: AssetImage('assets/filter.png',),
                          fit: BoxFit.fill,
                        ),
                      ),

                    ),
                  )
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
            ),
            SizedBox(width: 5),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return  AddGroupDialog();
                    },
                    fullscreenDialog: true
                ));
              },
              child: Container(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                    image: AssetImage('assets/addgroup.png',),
                    fit: BoxFit.fill,
                  ),
                ),
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void LoadFrinds() {

  }

  getStat(element) {
    if(element["status"]>0){
      return false;
    }else{
      var item=element["data"].friends_request_id.toString().split("_");
      if(item[0]==userdata.id){
        return false;
      }else{
        return true;
      }

    }

  }
}
