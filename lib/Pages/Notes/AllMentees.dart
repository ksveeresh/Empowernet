import 'dart:convert';


import 'package:encrypt/encrypt.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Data/model/NotesRequest.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AllMentees extends StatefulWidget {
  Function onLoadProfile;
  AllMentees({this.onLoadProfile});
  @override
  _AllMenteesState createState() => _AllMenteesState();
}

class _AllMenteesState extends State<AllMentees> {
  var  DataList=[];

  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();

    LoadData();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    LoadData();
  }

  @override
  Widget build(BuildContext context) {
    return DataList.length>0?ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: DataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(dataList:DataList[index] ,onLoadProfile: (value){
            widget.onLoadProfile(value);
          },) ;
        }
    ):Center(child: Text("NO Mentees"));
  }

  void LoadData() {
    ref.child('Friends').child("Request").onValue.listen((e) {
      Map datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        datasnapshot.keys.forEach((element) {
          if(element.toString().contains(userdata.id)) {
            var subitem = datasnapshot[element] as Map;
            if (subitem["status"] == 2) {
              var subString = element.toString().split("_");
              if (subString[0] == userdata.id) {
                ref.child('UserType').child(userdata.usertype=="mentee"?"mentor":"mentee").child(subString[1]).onValue.listen((e) {
                  var datasnapshot = e.snapshot.value as Map;
                  if (datasnapshot != null) {
                    if(userdata.usertype=="mentee") {
                      Map<String, dynamic> map1 = new Map<String, dynamic>();
                      FriendsRequest request=FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                      map1["subj"]=request.mentor_subject;
                      map1["data"]=MentorProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"])));
                      DataList.add(map1);
                    }else{
                      Map<String, dynamic> map1 = new Map<String, dynamic>();
                      FriendsRequest request=FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                      map1["subj"]=request.mentor_subject;
                      map1["data"]=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"])));
                      DataList.add(map1);
                    }
                  }
                });
              } else {
                ref.child('UserType').child(userdata.usertype=="mentee"?"mentor":"mentee").child(subString[0]).onValue.listen((e) {
                  var datasnapshot = e.snapshot.value as Map;
                  if (datasnapshot != null) {
                    if(userdata.usertype=="mentee") {
                      Map<String, dynamic> map1 = new Map<String, dynamic>();
                      FriendsRequest request=FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                      map1["subj"]=request.mentor_subject;
                      map1["data"]=MentorProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"])));
                      DataList.add(map1);
                    }else{
                      Map<String, dynamic> map1 = new Map<String, dynamic>();
                      FriendsRequest request=FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                      map1["subj"]=request.mentor_subject;
                      map1["data"]=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"])));
                      DataList.add(map1);
                    }
                  }
                });
              }
            }
          }
        });
        setState(() {

        });
      }
    });
  }
}
class ListItem extends StatefulWidget {
  Function onLoadProfile;
  var dataList;
  bool itemVisble=false;
  ListItem({this.dataList, this.onLoadProfile});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  TextEditingController mNameController;
  DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
     mNameController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 30,
                    width: 30,
                    child: StreamBuilder<Uri>(
                      stream: DownLoadUrl(userdata.usertype=="mentee"?(((widget.dataList as Map)["data"]) as MentorProfileData).mMentorPersonlBean.profile_path:(((widget.dataList as Map)["data"]) as ProfileData).personl.profile_path).asStream(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CircleAvatar(radius: 10.0,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white)));
                        }
                        return Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image:new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(snapshot.data.toString())
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          onTap: (){
                            widget.onLoadProfile(userdata.usertype=="mentee"?(((widget.dataList as Map)["data"]) as MentorProfileData).userId:(((widget.dataList as Map)["data"]) as ProfileData).userId);
                          },
                          child: Text(userdata.usertype=="mentee"?(((widget.dataList as Map)["data"]) as MentorProfileData).mMentorPersonlBean.firestName:(((widget.dataList as Map)["data"]) as ProfileData).personl.firestName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,decoration: TextDecoration.underline))
                      )
                  ),

                ]

            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5),
            child:RaisedButton(onPressed: () {
              widget.itemVisble=widget.itemVisble==true?false:true;

              setState(() {

              });
            },child: Text("Provide Feedback"),color: Color(0xFF9fe0ff),textColor: Colors.black,),
          ),
          Visibility(
            visible:widget.itemVisble,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(children: [
                      Container(padding: EdgeInsets.all(5),alignment: Alignment.center,child: Text(DateFormat.yMd().format(new DateTime.now())),color:Color(0xFF9fe0ff),),
                     SizedBox(width: 10,),
                      Container( padding: EdgeInsets.all(5),alignment: Alignment.center,child: Text("Subject"),color:Color(0xFF9fe0ff),),
                    ],),
                    RaisedButton(onPressed: () {
                      widget.itemVisble=false;
                      loadData(NotesRequest(
                          msg:mNameController.text.toString(),
                          user_name: userdata.name,
                          profile_path: userdata.profile_img,
                          friends_request_id:userdata.usertype=="mentee"?(((widget.dataList as Map)["data"]) as MentorProfileData).userId:(((widget.dataList as Map)["data"]) as ProfileData).userId,
                          subject:(widget.dataList as Map)["subj"],
                          user_type:userdata.usertype,
                          Date: DateFormat.yMd().format(new DateTime.now()),
                          user_id:userdata.id
                      )
                      ).then((value){
                        mNameController.clear();
                        Fluttertoast.showToast(
                            msg: "Message sent",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        setState(() {

                        });
                      });

                    },child: Text("Send"),color: Color(0xFF9fe0ff),textColor: Colors.black,padding: EdgeInsets.all(10),)
                  ],),
              Container(
                padding: EdgeInsets.all(10),
                child:TextField(
                  controller: mNameController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10.0),
                    border: InputBorder.none,
                    hintText: "Type Message/Feedback here",
                  ),
                ),
              )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<Uri> DownLoadUrl(String path) async {
    String strURL =  await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();
    return Uri.parse(strURL);

  }

  Future<void> loadData(NotesRequest notesRequest) async {
   var key= ref.child('Notes').child(notesRequest.friends_request_id).push().key;
   await ref.child('Notes').child(notesRequest.friends_request_id).child(key).set(jsonEncode(notesRequest));
   var itemkey=ref.child('Notification').child("General").child(notesRequest.friends_request_id).push().key;
   ref.child('Notification').child("General").child(notesRequest.friends_request_id).child(itemkey).set(jsonEncode(NotificationData(date:DateTime.now().toUtc().toString(),profile_path:userdata.profile_img,msg:"${userdata.name} Message sent.",user_id:userdata.id,user_name: userdata.name)));
  }
}



