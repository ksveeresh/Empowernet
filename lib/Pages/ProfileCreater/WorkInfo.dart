import 'package:flutter/material.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'dart:async';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/widgetHelper/MyDropDownFormField.dart';
import 'package:soughted/widgetHelper/MyTextFormField.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

List<String> experience=["Yes","No"];
List<PopupMenuItem> experiencepopList = [];
List<PopupMenuItem> workpopList = [];
List<String> work=["Internship","Volunteering","Part-time Work","Full-time Work"];

GlobalKey _menuKey1=GlobalKey();
ScrollController _scrollController = new ScrollController();

class WorkInfo extends StatefulWidget {
  PageController  controller;
  int slideIndex;
  bool disableFilds=true;


  WorkInfo(this.controller,this.slideIndex);
  @override
  _WorkInfoState createState() => _WorkInfoState();
}

class _WorkInfoState extends State<WorkInfo> {
  List<WorkListBean> work_list = new List<WorkListBean>();
  List<GlobalKey> _menuKey = new List<GlobalKey>();
  TextEditingController CompanynameController = TextEditingController();
  TextEditingController PositionController = TextEditingController();
  TextEditingController StartyearController = TextEditingController();
  TextEditingController EndyearController = TextEditingController();
  String workdropdownValue;
  String textexperience = "";
  String textWork = "";


  String experiencedropdownValue;

  WorkListBean workdata = WorkListBean();

  @override
  void initState() {
    super.initState();
    if(model.work==null){
      model.work=List<WorkListBean>();
      work_list.add(new WorkListBean());
      _menuKey.add(GlobalKey());
    }else{
      model.work.forEach((element) {
        work_list.add(element);
        _menuKey.add(GlobalKey());
      });
    }

    work.asMap().forEach((i, value) {
      workpopList.add(
          PopupMenuItem(

            child: Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            value: value,
          )
      );
    });
    experience.asMap().forEach((i, value) {
      experiencepopList.add(
          PopupMenuItem(

            child: Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            value: value,
          )
      );
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4990e2),

      body: WillPopScope(
        onWillPop: (){
          widget.controller.animateToPage(2, duration: Duration(milliseconds: 1), curve: Curves.linear);
        },
        child: SafeArea(
            child:SingleChildScrollView(
              child: Column(
                children: buildCartItems(work_list),
              ),
            )
        ),
      ),
    );
  }

  buildCartItems(List<WorkListBean> work_list) {
    var widgets = <Widget>[];
    work_list.asMap().forEach((key, value) {
      widgets.add(
          mItemCard(index: key,Additem: (){
            setState(() {
              model.work.addAll(work_list);
              work_list.add(WorkListBean());
              _menuKey.add(GlobalKey());
              Timer(
                  Duration(milliseconds: 1000),
                      () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent,));


            });
          },Next: (){
            model.work.clear();
            model.work.addAll(work_list);
            print(model.toJson());
            widget.controller.animateToPage(10, duration: Duration(milliseconds: 1), curve: Curves.linear);
          },Back: (){
            model.work.clear();
            model.work.addAll(work_list);
            widget.controller.animateToPage(2, duration: Duration(milliseconds: 1), curve: Curves.linear);
          },workListBean: value,menuKey:_menuKey[key],lastINdex:work_list.length-1,DateUpdate: (val){
            setState(() {
              if(val["type"]=="startdate"){
                value.startdate=val["date"];
              }else{
                value.enddate=val["date"];
              }
            });
          },)
      );
    });
    return widgets;
  }

}

class mItemCard extends StatefulWidget {
  int index;
  Function Additem;
  Function Back;
  Function Next;
  Function DateUpdate;
  WorkListBean workListBean;
  GlobalKey menuKey;
  int lastINdex;
  mItemCard({this.index, this.Additem,this.Back,this.Next,this.workListBean,this.menuKey,this.lastINdex,this.DateUpdate});

  @override
  _mItemCardState createState() => _mItemCardState();
}

class _mItemCardState extends State<mItemCard> {
  List<Widget> yearlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yearlist =buildYeartems(DateTime.now().year);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(20, 5, 20, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.index==0?Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Image(image: AssetImage('assets/work_img.png'),
                      width: 30,
                      height: 30,),
                  ),
                  TextSpan(
                      text: "txt_WorkExperience".tr(), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color(0xFFddebf6))
                  ),
                ],
              ),
            ),
          ):Container(),
          widget.index==0?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        child: Text(model.experience==null?"":model.experience,style: TextStyle(color: Colors.white),),onTap: (){

                      },),
                    ),
                    PopupMenuButton(
                      color: Color(0xFFcfe2f3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                      onSelected: (selectedDropDownItem){
                        setState(() {
                          model.experience=selectedDropDownItem;
                        });
                      },
                      key: _menuKey1,
                      itemBuilder: (BuildContext context) =>experiencepopList,
                      tooltip: "Tap me to select a number.",
                    ),
                  ],),
              ),
              Divider(height: 3,thickness:3 ,color: Colors.white,),
              Text("txt_WorkExperiencedd".tr(),style: TextStyle(color: Colors.white),)
            ],
          ):Container(),
          SizedBox(height: widget.index==0?10:5),
          RichText(
            text: TextSpan(
              children: [

                TextSpan(
                    text: "Job #${widget.index+1}".tr(), style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xFFddebf6))
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              child: Text(widget.workListBean.type_work==null?"":widget.workListBean.type_work,style: TextStyle(color: Colors.white),),onTap: (){

                            },),
                          ),
                          PopupMenuButton(
                            enabled: model.experience!="No"?true:false,
                            color: Color(0xFFcfe2f3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            icon: Icon(Icons.arrow_drop_down,color: Colors.white,),

                            onSelected: (selectedDropDownItem){
                              setState(() {
                                widget.workListBean.type_work=selectedDropDownItem;
                              });

                            },
                            key:widget.menuKey,
                            itemBuilder: (BuildContext context) =>workpopList,
                            tooltip: "Tap me to select a number.",
                          ),
                        ],),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("txt_TypeofWork".tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      height: 40,
                      child:TextField(
                        cursorColor: Colors.white,
                        enabled: model.experience!="No"?true:false,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16,color: Colors.white),
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(bottom: 10.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          widget.workListBean.company=text;
                        },
                        keyboardType:TextInputType.text,
                        obscureText:false,
                      ),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("txt_WorkExperienc_place".tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      height: 40,
                      child:TextField(
                        cursorColor: Colors.white,
                        enabled: model.experience!="No"?true:false,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16,color: Colors.white),
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(bottom: 10.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          widget.workListBean.position=text;
                        },
                        keyboardType:TextInputType.text,
                        obscureText:false,
                      ),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("txt_Position".tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Container(
                              height: 300,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child:CupertinoDatePicker(
                                        initialDateTime:DateTime.now().subtract(Duration(days: 1)) ,
                                        maximumYear:DateTime.now().year ,
                                        maximumDate: DateTime.now(),
                                        onDateTimeChanged: (val) {
                                          var map=Map();
                                          map["date"]=DateFormat('dd-MM-yyyy').format(val);
                                          map["type"]="startdate";
                                          widget.DateUpdate(map);

                                        },
                                        mode:CupertinoDatePickerMode.date,

                                      ),
                                    ),
                                  ),

                                  // Close the modal
                                  CupertinoButton(
                                    padding: EdgeInsets.all(5),
                                    child: Text('OK'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 40,
                        child:TextField(
                          controller: TextEditingController(text: widget.workListBean.startdate),
                          cursorColor: Colors.white,
                          enabled: false,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {

                          },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                        ),
                      ),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("Start Date".tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Container(
                              height: 300,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: CupertinoDatePicker(
                                        initialDateTime:DateTime.now().subtract(Duration(days: 1)) ,
                                        maximumYear:DateTime.now().year ,
                                        maximumDate: DateTime.now(),

                                        onDateTimeChanged: (val) {
                                          var map=Map();
                                          map["date"]=DateFormat('dd-MM-yyyy').format(val);
                                          map["type"]="enddate";
                                          widget.DateUpdate(map);

                                        },
                                        mode:CupertinoDatePickerMode.date,

                                      ),
                                    ),
                                  ),

                                  // Close the modal
                                  CupertinoButton(
                                    padding: EdgeInsets.all(5),
                                    child: Text('OK'),
                                    onPressed: () => Navigator.of(context).pop(),
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 40,
                        child:TextField(
                          controller: TextEditingController(text:widget.workListBean.enddate),
                          cursorColor: Colors.white,
                          enabled: false,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            print(text);

                          },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                        ),
                      ),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("End Date".tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 20),
          widget.index==widget.lastINdex?Container(
              padding: EdgeInsets.only(left: 5,right: 5),
              alignment: Alignment.center,
              child:Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        onTap: (){
                          if(model.experience!="No") {
                            widget.Additem();
                          }
                        },
                        child:Container(child: Row(children: [
                          Icon(Icons.add,size: 14,color: Colors.white),
                          Text("txt_AddMore".tr(),style: TextStyle(fontSize: 14,color: Colors.white),),
                        ],),) ,
                      ),
                      Container(),

                    ],),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(

                          child: MyButtonFormField(onPressed: (){
                            widget.Back();
                          },

                            btn_name: "Back",color: Colors.white,fontcolor: Colors.black,),
                          padding: EdgeInsets.only(left: 20,right: 20),
                        ),

                        Container(
                          child:  MyButtonFormField(onPressed: (){
                            widget.Next();
                          },
                              btn_name: "Skip and \n Continue",color: Colors.white,fontcolor: Colors.black),
                          padding: EdgeInsets.only(left: 20,right: 20),
                        ),
                      ],) ,
                  ),
                ],
              )
          ):Container(),
        ],
      ),
    );
  }

  List<Widget> buildYeartems(int year) {
    var widgets = <Widget>[];
    for (var i = 10; i >= year-50; i--) {
      widgets.add(Text('$i'));
      print(i);
    }
    return widgets;
  }
}


class WorkType extends StatefulWidget {
  @override
  _WorkTypeState createState() => _WorkTypeState();
}

class _WorkTypeState extends State<WorkType> {
  String dropdownValue = 'Type Of Work';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 62,
          color: Colors.grey[200],
          child: DropdownButtonHideUnderline(
            child:DropdownButton<String>(
              value: dropdownValue,
              style: TextStyle(color: Colors.grey),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue=newValue;
                });
              },
              items: <String>['Type Of Work','Volunteering', 'Internship']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
      ),
    );
  }
}

