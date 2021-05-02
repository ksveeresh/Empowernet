import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soughted/Data/model/NotesRequest.dart';
import 'package:soughted/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
class MentorNotes extends StatefulWidget {
  PageController controller;
  MentorNotes(this.controller);

  @override
  _MentorNotesState createState() => _MentorNotesState();
}

class _MentorNotesState extends State<MentorNotes> {
  var DataList=[];

  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return DataList.length>0?ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: DataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(DataList[index]);
        }
    ):Center(child: Text("NO Mentees"));;
  }

  void LoadData() {
    ref.child('Notes').child(userdata.id).onValue.listen((e) {
      var datasnapshot = e.snapshot.value as Map;
      if(datasnapshot!=null){
        datasnapshot.keys.forEach((element) {
          DataList.add(NotesRequest.fromJson(jsonDecode(datasnapshot[element])));
        });
        setState(() {

        });
      }
    });
  }
}
class ListItem extends StatefulWidget {
  dynamic dataList;
  ListItem(this.dataList);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  TextEditingController mNameController;

  @override
  void initState() {
    super.initState();
    mNameController=TextEditingController(text: (widget.dataList as NotesRequest).msg);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
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
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      width: 30,
                      child: StreamBuilder<Uri>(
                        stream: DownLoadUrl((widget.dataList as NotesRequest).profile_path).asStream(),
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
                        child: Text((widget.dataList as NotesRequest).user_name)
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(padding: EdgeInsets.all(5),alignment: Alignment.center,child: Text((widget.dataList as NotesRequest).Date),color:Color(0xFF9fe0ff),),
                  SizedBox(height: 10,),
                  Container( padding: EdgeInsets.all(5),alignment: Alignment.center,child: Text((widget.dataList as NotesRequest).subject==""?"No Subjects":(widget.dataList as NotesRequest).subject),color:Color(0xFF9fe0ff),),

                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            color:Color(0xFF9fe0ff),
            padding: EdgeInsets.all(10),
            child:TextField(
              controller: mNameController,
              maxLines: 3,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.0),
                border: InputBorder.none,
                hintText: "Type Message/Feedback here",
                fillColor:Color(0xFF9fe0ff)
              ),
            ),
          ),
          Container(height: 1,color: Colors.black,padding: EdgeInsets.only(top: 10),)
        ],
      ),
    );
  }

  Future<Uri> DownLoadUrl(String path) async {
    String strURL =  await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child(path.split('/').last).getDownloadURL();
    return Uri.parse(strURL);

  }
}
