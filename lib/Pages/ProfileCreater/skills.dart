

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soughted/widgetHelper/MyTextTagFormFiels.dart';

import '../../main.dart';
import '../../widgetHelper/MyButtonFormField.dart';
import '../my_navigator.dart';


class Skills extends StatefulWidget {

  PageController  controller;
  int slideIndex;


  Skills(this.controller,this.slideIndex);

  @override
  _SkillsInfoState createState() => _SkillsInfoState(this.controller,this.slideIndex);

}

class _SkillsInfoState extends State<Skills> {
  PageController  controller;
  int slideIndex;
  var PersonalIntersts=[];
  var PersonalSkills=[];
  var mResult;
  _SkillsInfoState(this.controller,this.slideIndex);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Color(0xFFddebf6),
        body:Padding(
          padding: EdgeInsets.all(10),
          child:SingleChildScrollView(child:    Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: (){
                      widget.controller.animateToPage(3, duration: Duration(milliseconds: 100), curve: Curves.linear);

                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child:RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Image(image:AssetImage('assets/graduation.png'),width: 30,height: 30,),
                        ),
                        TextSpan(
                            text: "txt_PersonalSkills",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20 ,color:Color(0xFF515f6a) )
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20,bottom: 100,left: 10,right: 10),
                  color: Colors.white,
                  child:Column(
                    children: [
                      SizedBox(height: 5),
                      Container(
                        height: 40,
                        child:MyTextTagFormFiels(hintText:"txt_PersonalIntersts" ,onSaved: (val){
                          PersonalIntersts.add(val);
                        },OnRemove:(val){
                          PersonalIntersts.remove(val);
                        },initialTags: PersonalIntersts.toList(),),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        child:MyTextTagFormFiels(hintText:"txt_PersonalSkillsmulti" ,onSaved: (val){
                          PersonalSkills.add(val);
                        },OnRemove:(val){
                          PersonalSkills.remove(val);
                        },initialTags: PersonalSkills.toList(),),
                      ),
                    ],
                  ),),
                Container(
                  padding: EdgeInsets.only(bottom: 50,top: 10,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          widget.controller.animateToPage(8, duration: Duration(milliseconds: 100), curve: Curves.linear);
                        },
                        child:Text("txt_Editlater",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,)),
                      )
                    ],
                  ),
                ),
              ]
          ),),
        ),

bottomSheet:Container(
  height: 40,
  child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            child:MyButtonFormField(onPressed: (){
              model.PersonalSkills=PersonalSkills;
              model.PersonalIntersts=PersonalIntersts;
              widget.controller.animateToPage(5, duration: Duration(milliseconds: 100), curve: Curves.linear);
            }, width: ( MediaQuery.of(context).size.width/1.2), btn_name: "txt_Continue",color: Color(0xFF40aef9),fontcolor:Color(0xFF9fe0ff)),

          ),)]),
) ,


    );
  }
}

Widget _buildAddButton() {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: Color(0xFF4990e2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.add,
          color: Colors.white,
          size: 15.0,
        ),
        Text(
          "Add New Tag",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
    ),
  );
}


class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    // await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> filteredTagList = <dynamic>[];
    filteredTagList.add({'name': "Select item", 'value': 0});
    // tagList.add({'name': "HummingBird", 'value': 2});
    // tagList.add({'name': "Dart", 'value': 3});
    if (query.isNotEmpty) {
      filteredTagList.clear();
      filteredTagList.add({'name': query, 'value': 0});
    }

    return filteredTagList;
  }
}