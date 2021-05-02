import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:soughted/Data/model/EventNotificationReq.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:soughted/Pages/Notification/EventNotification.dart';
import 'package:soughted/Pages/Notification/GeneralNotification.dart';
import 'package:soughted/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
class Notifications extends StatefulWidget {
  PageController controller;
  Notifications(this.controller);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  PageController SubNotficationController;
  TextEditingController dateTimeController=TextEditingController();
  TextEditingController eventTitleController=TextEditingController();
  TextEditingController eventSummeryController=TextEditingController();
  int currentIndex = 0;
  String dateTime="Date and Time";
  String btnclick="General";
  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    SubNotficationController = new PageController();
    SubNotficationController.addListener(() {
      if (SubNotficationController.page.round() != currentIndex) {
        setState(() {
          currentIndex = SubNotficationController.page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30,top: 10),
                child:RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(
                          text: "Notifications",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20 ,color:Colors.white)
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,

                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Color(0xFFd0e2f2),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: btnclick=="General"?EdgeInsets.only(left: 5,right: 10,bottom: 5):EdgeInsets.all(0.0),                                  color: Color(0xFF4b91e3),
                                  child: SizedBox(
                                    height: 41.0,
                                    child: RaisedButton(
                                      color:Color(0xFFf3f3f3),
                                      child: Text('General',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                                      onPressed: () {
                                        setState(() {
                                          btnclick="General";
                                          SubNotficationController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.linear);

                                        });

                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Color(0xFF4b91e3),
                                  padding: btnclick=="Event Calendar"?EdgeInsets.only(left: 10,right: 5,bottom: 5):EdgeInsets.all(0.0),
                                  child: SizedBox(
                                    height: 41.0,
                                    child: RaisedButton(
                                      color:Color(0xFFf3f3f3),
                                      child: Text('Event Calendar',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                                      onPressed: () {
                                        setState(() {
                                          btnclick="Event Calendar";
                                          SubNotficationController.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);
                                        });

                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            child: PageView(
                                physics:new NeverScrollableScrollPhysics(),
                                controller: SubNotficationController,
                                children:<Widget> [
                                  GeneralNotification(),
                                  EventNotification(),
                                ]
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
class PopupItem extends PopupMenuItem {
  const PopupItem({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  _PopupItemState createState() => _PopupItemState();
}

class _PopupItemState extends PopupMenuItemState {
  @override
  void handleTap() {}
}

class EventDialog extends StatefulWidget {

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  bool dateShow=false;
  String date=DateFormat("dd-MM-yyyy").format(DateTime.now());
  String time=DateFormat("hh:mm a").format(DateTime.now());
  bool timeShow=false;
  List item=[];
  TextEditingController EventNamecontroller = new TextEditingController();
  TextEditingController EventDescontroller = new TextEditingController();
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
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFd0e2f2),
            child:ListView(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.of(context).pop();
                    },
                        child: Text("Cancel",style: TextStyle(fontSize: 16),)),
                    Text("New Event",style: TextStyle(fontSize: 18),),
                    GestureDetector(onTap: (){
                      List mList=[];
                      item.forEach((element) {
                        if(element["select"]==true){
                          mList.add((element["data"] as FriendsRequest).toJson());
                        }
                      });
                      var key=ref.child('Events').push().key;
                      var items= EventNotificationReq(user_name: model.personl.firestName,event_date: date,event_time: time,user_id: model.userId,event_title: EventNamecontroller.text.toString(),event_summary:EventDescontroller.text.toString(),event_co_host: mList,key: key);
                      ref.child("Notification").child('Events').child(key).set(EncryptModel().Encryptedata(jsonEncode(items)));
                      Navigator.of(context).pop();
                    },
                        child: Text("Publish",style: TextStyle(fontSize: 16),)),
                  ],
                ),
                SizedBox(height: 50,),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(6.0),
                        topRight: const Radius.circular(6.0),
                        bottomLeft: const Radius.circular(6.0),
                        bottomRight: const Radius.circular(6.0),
                      )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Expanded(
                        child: TextField(
                          enabled: true,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            hintText: "Event Name",
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {

                          },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                          controller:EventNamecontroller,
                        ),
                      ),
                      Divider(height: 1,thickness:1 ,color: Colors.grey,),
                      SizedBox(height: 10,),
                      Row(children: [
                        Text("With"),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 40.0,
                                height: 40.0,
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.brown.shade800,
                                  child: Text(model.personl.firestName.substring(0, 1).toUpperCase()),
                                ),
                              ),
                              Text(
                                model.personl.firestName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],)
                      ,
                      Divider(height: 1,thickness:1 ,color: Colors.grey,),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap:() async {

                          item =  await Navigator.of(context).push(new MaterialPageRoute<List>(
                              builder: (BuildContext context) {
                                return  UsersDialog(DataList:item);
                              },
                              fullscreenDialog: true
                          ));
                        } ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              "Add a Co-host or Guest",
                              style: TextStyle(fontSize: 16,),
                              textAlign: TextAlign.start,
                            ),
                            Icon(Icons.arrow_forward_ios_sharp)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(6.0),
                        topRight: const Radius.circular(6.0),
                        bottomLeft: const Radius.circular(6.0),
                        bottomRight: const Radius.circular(6.0),
                      )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            dateShow=dateShow==true?false:true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date"),
                            Text(date)

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Visibility(
                        visible: dateShow,
                        child:SfDateRangePicker(
                          onSelectionChanged: ( s){
                            setState(() {
                              date=DateFormat("dd-MM-yyyy").format(DateTime.parse(s.value.toString()));
                            });

                          },
                        ),
                      ),
                      Divider(height: 1,thickness:1 ,color: Colors.grey,),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            timeShow=timeShow==true?false:true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time"),
                            Text(time)

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Visibility(
                        visible: timeShow,
                        child:Container(
                          height: 100,
                          width: double.infinity,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(1969, 1, 1, DateTime.now().hour, DateTime.now().minute),
                            onDateTimeChanged: (DateTime newDateTime) {
                              setState(() {
                                time=DateFormat("hh:mm a").format(DateTime.parse(newDateTime.toString()));
                              });
                              },
                            use24hFormat: false,
                            minuteInterval: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(6.0),
                        topRight: const Radius.circular(6.0),
                        bottomLeft: const Radius.circular(6.0),
                        bottomRight: const Radius.circular(6.0),
                      )
                  ),
                  child: TextField(
                    enabled: true,
                    controller: EventDescontroller,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Description (150 words max)",
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {

                    },
                    keyboardType:TextInputType.text,
                    obscureText:false,
                    maxLines: 10,
                    maxLength: 150,
                  ),
                ),
              ],
            )

        ),
      ),
    );
  }
}
class UsersDialog extends StatefulWidget {
  List DataList;
  UsersDialog({this.DataList});

  @override
  _UsersDialogState createState() => _UsersDialogState();
}

class _UsersDialogState extends State<UsersDialog> {
  DatabaseReference ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.DataList.length==0){
      widget.DataList.clear();
      final FirebaseDatabase database = FirebaseDatabase(app: app);
      ref = database.reference();
      ref.child('Friends').child("Request").onValue.listen((e) {
        var datasnapshot = e.snapshot.value as Map;
        if (datasnapshot != null) {
          if (mounted) {
            setState(() {
              datasnapshot.keys.forEach((element) {
                if (element.toString().contains(userdata.id)) {
                  var subitem = datasnapshot[element] as Map;
                  Map<String, dynamic> map = new Map<String, dynamic>();
                  map["status"] = subitem["status"];
                  map["select"] = false;
                  map["data"] = FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                  widget.DataList.add(map);
                }
              });
            });
          }
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0e2f2),
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator
                .of(context)
                .pop(widget.DataList);
          },
            color: Colors.black
        ),
        backgroundColor: Color(0xFFd0e2f2),
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Column(
              children:Loadusers(widget.DataList),
            ),
          ),
        ),
      )
    );
  }

  Loadusers(List<dynamic> dataList) {
    List<Widget> mUsers= [];
    mUsers.add(Container(
      height: 40,
      width:MediaQuery
          .of(context)
          .size.width-20,
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
    ));
    dataList.forEach((element) {
      mUsers.add(Container(
        child:CheckboxListTile(
          title: Container(
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child: Text(element["data"].sender_name!=model.personl.firestName?element["data"].sender_name:element["data"].receiver_name.substring(0, 1).toUpperCase()),
                  ),
                ),
                Expanded(
                  child:Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element["data"].sender_name!=model.personl.firestName?element["data"].sender_name:element["data"].receiver_name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ) ,
                ),
              ],
            ),
          ),
          value: element["select"],
          onChanged: (val) {
            setState(() {
              element["select"]=val;
            });
          },
          controlAffinity: ListTileControlAffinity.trailing,
        ),
      ));
    });
    return mUsers;
  }
}

