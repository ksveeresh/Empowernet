import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';

class RequstList extends StatefulWidget {
  var  DataList=[];

  RequstList({this.DataList});
  @override
  _RequstListState createState() => _RequstListState();
}

class _RequstListState extends State<RequstList> {
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
      appBar: AppBar(
        title: Text("New requests (${widget.DataList.length})",style: TextStyle(color: Colors.white,fontSize: 16)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading:TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
        ),
      ),
      backgroundColor: Color(0xFFa0c5e8),
      body: Column(
        children:ReqListItem(),
      ),
    );
  }

  ReqListItem() {
    var widgets = <Widget>[];
    widget.DataList.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 85,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              element["data"].sender_id == model.userId ?
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
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(element["userdata"].personl.firestName),
                    Text(element["userdata"].personl.occupation),
                    Text(element["userdata"].personl.city),
                  ]),
              Container(
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
                        btn_name: "Confirm",
                        color: Color(0xFF4b91e3),
                        fontcolor: Colors.white,),
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
                        color: Colors.grey[300],
                        fontcolor: Colors.black,),
                      padding: EdgeInsets.only(left: 0, right: 0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    });
    return widgets;
  }

}
