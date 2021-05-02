import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'dart:async';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/widgetHelper/MyTextTagFormFiels.dart';
import 'package:easy_localization/easy_localization.dart';
ScrollController _scrollController = new ScrollController();
List<String> educationlavel = ["High School (PUC)","Bachelor’s","Masters","PhD"];
List<String> lavel = ["I do not attend School","1st Grade","2nd Grade","3rd Grade","4th Grade","5th Grade","6th Grade","7th Grade","8th Grade","9th Grade","10th Grade","1st PUC","2nd PUC","University-Freshman","University-Sophomore","University-Senior","University-Junior","Recent Graduate","Masters, PHD"];
List<PopupMenuItem> educationlavelpopList = [];
List<PopupMenuItem> lavelpopList = [];
class MentorEducationInfo extends StatefulWidget {
  PageController controller;
  int slideIndex;

  MentorEducationInfo(this.controller, this.slideIndex);

  @override
  _MentorEducationInfoState createState() =>
      _MentorEducationInfoState(this.controller, this.slideIndex);
}

class _MentorEducationInfoState extends State<MentorEducationInfo> {

  List<String> career=[];
  String texteducationlavel="";
  String textlavel="";

  List<EducationalListBean> educational_list = new List<EducationalListBean>();
  List<GlobalKey> _menuKey = new List<GlobalKey>();
  List<GlobalKey> _menuKey1 = new List<GlobalKey>();

  PageController controller;
  int slideIndex;
  _MentorEducationInfoState(this.controller, this.slideIndex);

  @override
  void initState() {
    super.initState();

    educationlavel.asMap().forEach((i, value) {
      educationlavelpopList.add(
          PopupMenuItem(
            child: Container(
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
    lavel.asMap().forEach((i, value) {
      lavelpopList.add(
          PopupMenuItem(
            child: Container(
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
    if(model.educational==null) {
      model.educational=List<EducationalListBean>();
      educational_list.add(new EducationalListBean());
      _menuKey.add(GlobalKey());
      _menuKey1.add(GlobalKey());
    }else{
      educational_list.clear();
      _menuKey.clear();
      _menuKey1.clear();
      model.educational.forEach((element) {
        educational_list.add(element);
        _menuKey.add(GlobalKey());
        _menuKey1.add(GlobalKey());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final halfMediaWidth = MediaQuery.of(context).size.width-20;
    return WillPopScope(
      onWillPop: (){
        widget.controller.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);
      },
      child: Scaffold(
        backgroundColor:Color(0xFF4990e2),
        body: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              children: buildCartItems(educational_list),
            ),
          ),
        ),
      ),
    );
  }
  List<Widget> buildCartItems(List<EducationalListBean> educationalList) {
    var widgets = <Widget>[];
    educationalList.asMap().forEach((key, value) {
      widgets.add(mItemCard(index: key,Additem: (){
        setState(() {
          model.educational.clear();
          model.educational.addAll(educational_list);
          educational_list.add(EducationalListBean());
          _menuKey.add(GlobalKey());
          _menuKey1.add(GlobalKey());
          Timer(
              Duration(milliseconds: 1000),
                  () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent,));
        });
      },Back: (){
        model.educational.clear();
        model.educational.addAll(educationalList);
        widget.controller.animateToPage(6, duration: Duration(milliseconds: 1), curve: Curves.linear);
      },Next: (){
        model.educational.clear();
        model.educational.addAll(educational_list);
        widget.controller.animateToPage(8, duration: Duration(milliseconds: 1), curve: Curves.linear);
      },educationalListBean: value,menuKey: _menuKey[key],menuKey1: _menuKey1[key],lastINdex: educationalList.length-1,DateUpdate: (val){
        setState(() {
          if(val["type"]=="startdate"){
            value.startdate=val["date"];
          }else{
            value.enddate=val["date"];
          }
        });
      },));
    });
    return widgets;
  }
}






class mItemCard extends StatefulWidget {
  int index;
  Function Additem;
  Function Back;
  Function Next;
  List<String> career=[];
  EducationalListBean educationalListBean;
  GlobalKey menuKey;
  GlobalKey menuKey1;
  int lastINdex;
  Function DateUpdate;
  mItemCard({this.index, this.Additem,this.Back,this.Next,this.educationalListBean,this.menuKey,this.menuKey1,this.lastINdex,this.DateUpdate});
  @override
  _mItemCardState createState() => _mItemCardState();
}

class _mItemCardState extends State<mItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.fromLTRB(20, 5, 20, 20),
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
                    child: Image(image: AssetImage('assets/graduation.png'),
                      width: 30,
                      height: 30,),
                  ),
                  TextSpan(
                      text: "txt_EducationProfile".tr(), style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color(0xFFddebf6))
                  ),
                ],
              ),
            ),
          ):Container(),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [

                TextSpan(
                    text: "Education #${widget.index+1}".tr(), style: TextStyle(
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
                        widget.educationalListBean.university=text;
                      },
                      keyboardType:TextInputType.text,
                      obscureText:false,
                    ),
                  ),
                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                  RichText(
                    text: TextSpan(
                      children: [

                        TextSpan(
                          text: "Name of Institution",style:TextStyle(color:Color(0xFFddebf6),),
                        ),
                        // TextSpan(
                        //   text: " ",
                        // ),
                        // TextSpan(
                        //   text: "txt_photo2".tr(),style:TextStyle(color:Colors.grey[600],),
                        // ),
                      ],
                    ),
                  )

                ],
              )
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Text(widget.educationalListBean.educationlavel!=null?widget.educationalListBean.educationlavel:"",style: TextStyle(color: Colors.white),),onTap: (){
                              dynamic state =widget.menuKey1.currentState;
                              state.showButtonMenu();
                            },),
                          ),
                          PopupMenuButton(
                            color: Color(0xFFcfe2f3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                            key:widget.menuKey1,
                            onSelected: (selectedDropDownItem){
                              widget.educationalListBean.educationlavel=selectedDropDownItem;

                              setState(() {

                              });
                            },
                            itemBuilder: (BuildContext context) =>educationlavelpopList,
                            tooltip: "Tap me to select a number.",
                          ),
                        ],),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("Degree Type",style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
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
                          widget.educationalListBean.grade=text;
                        },
                        keyboardType:TextInputType.text,
                        obscureText:false,
                      ),
                    ),
                    Divider(height: 3,thickness:3 ,color: Colors.white,),
                    Text("What are you studying?",style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5,right: 5),
            child:Row(children: [
              Expanded(
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
                                  Expanded(
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
                          controller: TextEditingController(text: widget.educationalListBean.startdate),
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
              Expanded(
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
                                  Expanded(
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
                          controller: TextEditingController(text:widget.educationalListBean.enddate),
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
          SizedBox(height: 10),
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
                          widget.Additem();
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
}




