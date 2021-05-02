import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
class RequstMentees extends StatefulWidget {
  Function onLoadProfile;
  RequstMentees({this.onLoadProfile});

  @override
  _RequstMenteesState createState() => _RequstMenteesState();
}

class _RequstMenteesState extends State<RequstMentees> {
  var RequstList=[];

  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    LoadData();
  }
  @override

  void didUpdateWidget(covariant RequstMentees oldWidget) {
    super.didUpdateWidget(oldWidget);
    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return RequstList.length>0?ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: RequstList.length,
        itemBuilder: (BuildContext context, int index) {
          var item =RequstList[index] as FriendsRequest;
          return ListItem(item:item,onLoadProfile:(value){
            widget.onLoadProfile(value);
          } ,onAccept: (item){
            AcceptRequest(item);
          },onDecline: (item){
            CancelRequest(item);
          },);
        }
    ):Center(child: Text("NO REQUESTS"));
  }

  void LoadData() {
    ref.child('Friends').child("Request").onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        RequstList.clear();
        datasnapshot.keys.forEach((element) {
          if(element.toString().contains(userdata.id)){
            var subString=element.toString().split("_");
            if(subString[1].toString()==userdata.id){
              var subitem = datasnapshot[element] as Map;
              if(subitem["status"]==0){
                var jsonData= jsonDecode(EncryptModel().Decryptedata(subitem["data"])) ;
                var FrindRequst =FriendsRequest.fromJson(jsonData);
                RequstList.add(FrindRequst);
              }
            }else{
              RequstList.clear();
            }
          }
        });
        setState(() {

        });
      }else{
        RequstList.clear();
        setState(() {

        });
      }
    });
  }

  void AcceptRequest(id) {
    var item=id as FriendsRequest;
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["status"]=2;
    ref.child('Friends').child("Request").child(item.friends_request_id).update(map).whenComplete(() => setState(() {}));
    var itemkey=ref.child('Notification').child("General").child(item.sender_id).push().key;
    ref.child('Notification').child("General").child(item.sender_id).child(itemkey).set(jsonEncode(NotificationData(date:DateTime.now().toUtc().toString(),profile_path:userdata.profile_img,msg:"${userdata.name} accepted your request. Start connecting",user_id:userdata.id,user_name: userdata.name)));
  }
  void CancelRequest(id) async {
    var item=id as FriendsRequest;
    await  ref.child('Friends').child("Request").child(id).remove();
    var itemkey=ref.child('Notification').child("General").child(item.sender_id).push().key;
    ref.child('Notification').child("General").child(item.sender_id).child(itemkey).set(jsonEncode(NotificationData(date:DateTime.now().toUtc().toString(),profile_path:userdata.profile_img,msg:"${userdata.name} rejected your request.",user_id:userdata.id,user_name: userdata.name)));
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
  }
}
class ListItem extends StatefulWidget {
  FriendsRequest item;
  Function onLoadProfile;
  Function onAccept;
  Function onDecline;
  ListItem({this.item, this.onLoadProfile,this.onDecline,this.onAccept});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black12,
      child:Column(
        children: [

          // Row(
          //   children: [
          //     Container(
          //       alignment: Alignment.centerLeft,
          //       height: 30,
          //       width: 30,
          //       child: StreamBuilder<Uri>(
          //         stream: DownLoadUrl(widget.item.profile_path).asStream(),
          //         builder: (context,snapshot){
          //           if(snapshot.connectionState==ConnectionState.waiting){
          //             return CircleAvatar(radius: 10.0,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white)));
          //           }
          //           return Container(
          //             width: 30.0,
          //             height: 30.0,
          //             decoration: new BoxDecoration(
          //               shape: BoxShape.circle,
          //               image:new DecorationImage(
          //                   fit: BoxFit.fill,
          //                   image: NetworkImage(snapshot.data.toString())
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 10),
          //       child: Column(
          //         crossAxisAlignment:CrossAxisAlignment.start,
          //         children: [
          //           GestureDetector(
          //               onTap: (){
          //                 widget.onLoadProfile(widget.item.sender_id);
          //               },
          //               child: Text(widget.item.sender_name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,decoration: TextDecoration.underline),)),
          //           Text(widget.item.msg),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(onPressed: () {
                widget.onDecline(widget.item);
              },child: Text("Decline"),color: Color(0xFF9fe0ff),textColor: Colors.black,),
              RaisedButton(onPressed: () {
                widget.onAccept(widget.item);
              },child: Text("Accept"),color: Color(0xFF9fe0ff),textColor: Colors.black,),

            ],)
        ],
      ),
    );
  }
  Future<Uri> DownLoadUrl(String path) async {
    String strURL =  await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();
    return Uri.parse(strURL);
  }
}
