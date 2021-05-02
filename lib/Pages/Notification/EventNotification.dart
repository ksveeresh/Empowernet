import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/EventNotificationReq.dart';
import 'package:soughted/Data/model/TimeAgo.dart';
import 'package:soughted/Pages/Notification/Notification.dart';
import 'package:soughted/main.dart';

class EventNotification extends StatefulWidget {
  @override
  _EventNotificationState createState() => _EventNotificationState();
}

class _EventNotificationState extends State<EventNotification> {
  var  DataList=[];

  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    initializeDateFormatting();
    LoadData();
  }

  @override
  void didUpdateWidget(covariant EventNotification oldWidget) {
    super.didUpdateWidget(oldWidget);
    LoadData();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
          children:loadWidget()
      ),
    );
  }

  void LoadData() {
    ref.child('Notification').child("Events").onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if(datasnapshot!=null){
        datasnapshot.keys.forEach((element) {
          EventNotificationReq data =EventNotificationReq.fromJson(jsonDecode(EncryptModel().Decryptedata(datasnapshot[element])));
          DataList.add(data);
        });
        setState(() {});
      }
    });
  }

  loadWidget() {
    var widgets = <Widget>[];
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width-65,
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
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
                )),
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
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(new MaterialPageRoute<String>(
                  builder: (BuildContext context) {
                    return  EventDialog();
                  },
                  fullscreenDialog: true
              ));
            },
            child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(left: 5),
              child:  AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                  image: AssetImage('assets/addEvent.png',),
                  fit: BoxFit.fill,
                ),
              ),

            ),
          )
        ],
      ),
    ));
    DataList.length>0?DataList.forEach((element) {
      widgets.add(ListItem(dataList: element,onUpdate: (){
        DataList.clear();
        setState(() {

        });
      },));

    }):widgets.add(Center(child: Text("NO Events")));
    return widgets;
  }
}
class ListItem extends StatefulWidget {
  Function onUpdate;
  EventNotificationReq dataList;
  ListItem({this.dataList, this.onUpdate});
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text("${widget.dataList.event_date.replaceAll("-", "/")} at ${widget.dataList.event_time}",style: TextStyle(color: Color(0xFF4b91e3)),)
          ),
          Container( alignment: Alignment.centerLeft,child: Text("${widget.dataList.event_title}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
          Container(
              child: Text("From ${widget.dataList.user_name}")
          ),
          Container(alignment: Alignment.centerLeft,child: Text(widget.dataList.event_summary)),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Future<Uri> DownLoadUrl(String path) async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();
    return Uri.parse(strURL);
  }
}
