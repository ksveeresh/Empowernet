import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soughted/Data/model/NotificationData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Data/model/TimeAgo.dart';
import 'package:soughted/Pages/Notification/RequstList.dart';
import 'package:soughted/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/EncryptModel.dart';

class GeneralNotification extends StatefulWidget {
  @override
  _GeneralNotificationState createState() => _GeneralNotificationState();
}

class _GeneralNotificationState extends State<GeneralNotification> {
  var  DataList=[];
  var  ReqDataList=[];

  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    LoadData();
    ReqData();
  }
@override
  void didUpdateWidget(covariant GeneralNotification oldWidget) {
    super.didUpdateWidget(oldWidget);

    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return DataList.length>0?Column(
      children: [

        Container(height: 50,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFf3f3f3),
              border: Border.all(color: Colors.grey)
          ),
          child: InkWell(
            onTap: () async {
              await Navigator.of(context).push(new MaterialPageRoute<String>(
                  builder: (BuildContext context) {
                    return RequstList(DataList: ReqDataList,);
                  },
                  fullscreenDialog: true
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New requests (${ReqDataList.length})"),
                  Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),
                ],
              ),
            ),
          ),
        ),
        Container(
          width:500,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
        Column(
          children:loaditem(DataList),
        )

      ],
    ):Center(child: Text("NO Mentors"));
  }

  void LoadData() {
    DataList.clear();
    ref.child('Notification').child("General").child(userdata.id).onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if(datasnapshot!=null){
        datasnapshot.keys.forEach((element) {
          print(NotificationData.fromJson(jsonDecode(datasnapshot[element])).toJson().toString());
          DataList.add(NotificationData.fromJson(jsonDecode(datasnapshot[element])));
        });
        if(mounted) {
          setState(() {

          });
        }
      }
    });
  }

  void ReqData() {
    ref.child('Friends').child("Request").onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if (datasnapshot != null) {
        if (mounted) {
          setState(() {
            datasnapshot.keys.forEach((element) {
              if(element.toString().contains(userdata.id)&& datasnapshot[element]["status"]==0) {
                var subitem = datasnapshot[element] as Map;
                FriendsRequest friendsRequest=FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
               if(friendsRequest.sender_id!=userdata.id){
                 Map<String, dynamic> map = new Map<String, dynamic>();
                 map["status"] = subitem["status"];
                 map["data"] =friendsRequest;
                 ref.child('UserType').child(friendsRequest.sender_id).onValue.listen((e) {
                   var datasnapshot = e.snapshot.value;
                   if (datasnapshot != null) {
                     var menteesItem=ProfileData.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot)));
                     map["userdata"]=menteesItem;
                     ReqDataList.add(map);
                   }
                 });
               }
              }
            });
          });
        }
      }
    });
  }

  loaditem(List<dynamic> dataList) {
    var widgets = <Widget>[];
    dataList.forEach((element) {
      widgets.add(ListItem(element));
    });
return widgets;
  }
}
class ListItem extends StatefulWidget {
  dynamic dataList;
  ListItem(this.dataList);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child:
                Row(
                  children: [
                    (widget.dataList as NotificationData).profile_path==""?Container(
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.brown.shade800,
                        child: Text((widget.dataList as NotificationData).user_name.substring(0, 1).toUpperCase()),
                      ),
                    ):Container(
                      width: 30,
                      height: 30,
                      child: CachedNetworkImage(
                        imageUrl: (widget.dataList as NotificationData).profile_path,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container( alignment: Alignment.center,child: Text(TimeAgo.timeAgoSinceDate((widget.dataList as NotificationData).date),style: TextStyle(color: Colors.grey),),),
                          Container( alignment: Alignment.centerLeft,child: Text((widget.dataList as NotificationData).msg)),

                        ],
                      ),
                    ),
                                     ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Future<Uri> DownLoadUrl(String path) async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();;
    return Uri.parse(strURL);
  }
}
