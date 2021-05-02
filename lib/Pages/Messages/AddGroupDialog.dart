import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/FriendsRequest.dart';
import 'package:soughted/Data/model/Group.dart';
import 'package:soughted/main.dart';

class AddGroupDialog extends StatefulWidget {
  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  PageController controller = new PageController();
  TextEditingController GroupNameController=TextEditingController();
  int slideIndex=0;
  var  DataList=[];


  DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    DataList.clear();
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
                if(subitem["status"]==2) {
                  Map<String, dynamic> map = new Map<String, dynamic>();
                  map["status"] = subitem["status"];
                  map["selected"] = false;
                  map["data"] = FriendsRequest.fromJson(jsonDecode(EncryptModel().Decryptedata(subitem["data"])));
                  DataList.add(map);
                }
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
      appBar: AppBar(
        title: Text(slideIndex==0?"Add Participants":"New Group",style: TextStyle(color: Colors.white,fontSize: 16)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading:TextButton(
          onPressed: () {
            if(slideIndex==1){
              controller.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.linear);
            }else{
              Navigator.of(context).pop();
            }
          },
          child: Text(slideIndex==0?"Cancel":"Back",style: TextStyle(color: Colors.white,fontSize: 13),),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if(slideIndex==0){
                controller.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);
              }else{
                String group_peple="";
                DataList.forEach((element) {
                  if(element["selected"]==true){
                    if(group_peple==""){
                      group_peple=element["data"].sender_id==model.userId?element["data"].receiver_id:element["data"].sender_id;
                    }else{
                      group_peple="_"+element["data"].sender_id==model.userId?element["data"].receiver_id:element["data"].sender_id;
                    }
                  }

                });
                if(group_peple==""){
                  group_peple=model.userId;
                }else{
                  group_peple+="_"+model.userId;
                }
                var key= ref.child('Friends').child("Group").push().key;
                Group mGroup =Group(Group_creater_id: model.userId,Group_img: "",Group_name: GroupNameController.text.toString(),Group_peple:group_peple,msg: "",Group_id: key);
                Map<String, dynamic> map = new Map<String, dynamic>();
                map["status"] =3;
                map["data"] = EncryptModel().Encryptedata(jsonEncode(mGroup));
                await ref.child('Friends').child("Group").child(key).set(map);
                Navigator.of(context).pop();
              }
            },
            child: Text(slideIndex==0?"Next":"Create",style: TextStyle(color: Colors.white,fontSize: 13),),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
            physics:new NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              AddParticipants(dataList:DataList),
              NewGroup(dataList:DataList,mController: GroupNameController,)
            ]
        ),
      ),
    );
  }
}

class AddParticipants extends StatefulWidget {
  List<dynamic> dataList;
  AddParticipants({this.dataList});

  @override
  _AddParticipantsState createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {
  var  selectDataList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.dataList.forEach((element) {
      if(element["selected"]==true){
        selectDataList.add(element["data"].friends_request_id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFa0c5e8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:LadView(),
      ),
    );
  }
  LadView(){
    var widgets = <Widget>[];
    widgets.add(Container(

      child: TextField(
        autocorrect: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Container(
            width: 25,
            height: 25,
            padding:EdgeInsets.all(12),
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
          .size.width,
    ));
    widgets.add(selectDataList.length >0 ?Container(
      height: 90,
      width: MediaQuery
          .of(context)
          .size.width,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:widget.dataList.length,
          itemBuilder: (BuildContext context, int index){
            return widget.dataList[index]["selected"]==true?Container(
                padding: EdgeInsets.all(10),
                child:Column(
                  children: [
                    widget.dataList[index]["data"].sender_id==model.userId?widget.dataList[index]["data"].receiver_profile==""?
                    Container(
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.brown.shade800,
                        child: Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name:widget.dataList[index]["data"].receiver_name.substring(0, 1).toUpperCase()),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: widget.dataList[index]["data"].receiver_profile,
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
                    ):
                    widget.dataList[index]["data"].sender_profile==""?
                    Container(
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.brown.shade800,
                        child: Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name:widget.dataList[index]["data"].receiver_name.substring(0, 1).toUpperCase()),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: CachedNetworkImage(
                        imageUrl: widget.dataList[index]["data"].sender_profile,
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
                    Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name:widget.dataList[index]["data"].receiver_name,style: TextStyle(color: Colors.white),),
                  ],
                )):Container();
          }
      ),
    ):Container());
    widgets.add(Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
      child: Text("Suggested",textAlign: TextAlign.start,),
    ));
    widget.dataList.forEach((element) {
      widgets.add(Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          children: [
            element["data"].sender_id==model.userId?element["data"].receiver_profile==""?
            Container(
              width: 50.0,
              height: 50.0,
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.brown.shade800,
                child: Text(element["data"].sender_name!=model.personl.firestName?element["data"].sender_name:element["data"].receiver_name.substring(0, 1).toUpperCase()),
              ),
            ):
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              child: CachedNetworkImage(
                imageUrl: element["data"].receiver_profile,
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
            ):
            element["data"].sender_profile==""?
            Container(
              width: 50.0,
              height: 50.0,
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.brown.shade800,
                child: Text(element["data"].sender_name!=model.personl.firestName?element["data"].sender_name:element["data"].receiver_name.substring(0, 1).toUpperCase()),
              ),
            ):
            Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              child: CachedNetworkImage(
                imageUrl: element["data"].sender_profile,
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
            Container(
              width: MediaQuery
                  .of(context)
                  .size.width-60,
              child: CheckboxListTile(
                title: Text(element["data"].sender_name!=model.personl.firestName?element["data"].sender_name:element["data"].receiver_name,style: TextStyle(color: Colors.white),),
                value:element["selected"],
                onChanged: (val) {
                  setState(() {
                    if(val==true){
                      selectDataList.add(element["data"].friends_request_id);
                    }else{
                      selectDataList.remove(element["data"].friends_request_id);
                    }
                    element["selected"]=val;
                  },
                  );
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            )
          ],
        ),
        width: MediaQuery
            .of(context)
            .size.width,
      ));
    });
    return widgets;
  }
}
class NewGroup extends StatefulWidget {
  TextEditingController mController;
  List<dynamic> dataList;
  NewGroup({this.dataList,this.mController});
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFa0c5e8),
        child: Column(
          children: [
            Container(
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Container(
                        width: 75.0,
                        height: 75.0,
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.brown.shade800,
                          child:Icon(Icons.camera_alt,color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              padding: EdgeInsets.only(left: 5,right: 5),
                              height: 40,
                              child:TextField(
                                cursorColor: Colors.white,
                                enabled: true,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 16,color: Colors.white),
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.only(bottom: 10.0),
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  model.personl.occupation=text;
                                },
                                keyboardType:TextInputType.text,
                                obscureText:false,
                                controller: widget.mController,
                              ),
                            ),
                            Divider(height: 3,thickness:3 ,color: Colors.white,),
                            Text("Group Name",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      )
                    ],),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color:Color(0xFF4b91e3),
                    child: Text("Participants",style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child:  GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(widget.dataList.length, (index) {
                            return Container(
                              child: Column(
                                children: [
                                  widget.dataList[index]["data"].sender_id==model.userId?widget.dataList[index]["data"].receiver_profile==""?
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    padding: EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: Colors.brown.shade800,
                                      child: Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name:widget.dataList[index]["data"].receiver_name.substring(0, 1).toUpperCase()),
                                    ),
                                  ):
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.dataList[index]["data"].receiver_profile,
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
                                  ):
                                  widget.dataList[index]["data"].sender_profile==""?
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    padding: EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: Colors.brown.shade800,
                                      child: Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name.substring(0, 1).toUpperCase():widget.dataList[index]["data"].receiver_name.substring(0, 1).toUpperCase()),
                                    ),
                                  ):
                                  Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 20,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.dataList[index]["data"].sender_profile,
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
                                  Text(widget.dataList[index]["data"].sender_name!=model.personl.firestName?widget.dataList[index]["data"].sender_name:widget.dataList[index]["data"].receiver_name,style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            );
                          }
                          )
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
