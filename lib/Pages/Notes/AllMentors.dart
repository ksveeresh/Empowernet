
import 'package:encrypt/encrypt.dart';
import 'dart:convert';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'package:firebase_database/firebase_database.dart';

class AllMentors extends StatefulWidget {
  Function onLoadProfile;
  AllMentors({this.onLoadProfile});
  @override
  _AllMentors_State createState() => _AllMentors_State();
}

class _AllMentors_State extends State<AllMentors > {
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
  void didUpdateWidget(covariant AllMentors oldWidget) {
    super.didUpdateWidget(oldWidget);

    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return DataList.length>0?ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: DataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(dataList: DataList[index],onLoadProfile:(item){
            widget.onLoadProfile(item);
          },);
        }
    ):Center(child: Text("NO Mentors"));
  }

  void LoadData() {
    DataList.clear();
    ref.child('Friends').child("Request").onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
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
                      DataList.add(MentorProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"]))));
                    }else{
                      DataList.add(ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"]))));
                    }
                  }
                });
              } else {
                ref.child('UserType').child(userdata.usertype=="mentee"?"mentor":"mentee").child(subString[0]).onValue.listen((e) {
                  var datasnapshot = e.snapshot.value as Map;
                  if (datasnapshot != null) {
                    if(userdata.usertype=="mentee") {
                      DataList.add(MentorProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"]))));
                    }else{
                      DataList.add(ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot["user_data"]))));
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
  ListItem({this.dataList, this.onLoadProfile});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: EdgeInsets.all(10),
      color: Colors.black12,
      child: Row(
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
                    stream: DownLoadUrl(userdata.usertype=="mentee"?(widget.dataList as MentorProfileData).mMentorPersonlBean.profile_path:(widget.dataList as ProfileData).personl.profile_path).asStream(),
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
                    child: Text(userdata.usertype=="mentee"?(widget.dataList as MentorProfileData).mMentorPersonlBean.firestName:(widget.dataList as ProfileData).personl.firestName)
                )              ],
            ),
          ),
          RaisedButton(onPressed: () {
            widget.onLoadProfile(userdata.usertype=="mentee"?(widget.dataList as MentorProfileData).userId:(widget.dataList as ProfileData).userId);
          },child: Text("View Profile"),color: Color(0xFF9fe0ff),textColor: Colors.black,),

        ],
      ),
    );
  }
  Future<Uri> DownLoadUrl(String path) async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();
    return Uri.parse(strURL);
  }
}