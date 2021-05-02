import 'package:flutter/material.dart';
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/main.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/widgetHelper/MyTextFormField.dart';

class QuickApplication extends StatefulWidget {
  PageController controller;
  int slideIndex;
  QuickApplication(this.controller, this.slideIndex);

  @override
  _QuickApplicationState createState() => _QuickApplicationState();
}

class _QuickApplicationState extends State<QuickApplication> {
  TextEditingController Q1Controller=TextEditingController();
  TextEditingController Q2Controller=TextEditingController();
  TextEditingController Q3Controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFddebf6),
      body:Padding(
        padding: EdgeInsets.all(10),
        child:SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("txt_QuickApplication",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20 ,color:Color(0xFF515f6a))),
            ),
            Text("txt_Q1",textAlign: TextAlign.left,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius:BorderRadius.circular(0),
                  color: Colors.white
              ),
              padding: EdgeInsets.only(left: 5,right: 5),
              height: 50,
              child: MyTextFormField(inputType: TextInputType.multiline,isPassword: false,hintText: "",onSaved: (data){

              },mTextAlign: TextAlign.start,enabled: true,controller: Q1Controller,),
            ),
            Text("txt_Q2",textAlign: TextAlign.left,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius:BorderRadius.circular(0),
                  color: Colors.white
              ),
              padding: EdgeInsets.only(left: 5,right: 5),
              height: 50,
              child: MyTextFormField(inputType: TextInputType.multiline,isPassword: false,hintText: "",onSaved: (data){

              },mTextAlign: TextAlign.start,enabled: true,controller: Q2Controller,),
            ),
            Text("txt_Q3",textAlign: TextAlign.left,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius:BorderRadius.circular(0),
                  color: Colors.white
              ),
              padding: EdgeInsets.only(left: 5,right: 5),
              height: 50,
              child: MyTextFormField(inputType: TextInputType.multiline,isPassword: false,hintText: "",onSaved: (data){

              },mTextAlign: TextAlign.start,enabled: true,controller: Q3Controller,),
            ),
            Text("txt_Q4",textAlign: TextAlign.left,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius:BorderRadius.circular(0),
                  color: Colors.white
              ),
              padding: EdgeInsets.only(left: 5,right: 5),
              height: 50,
              child: MyTextFormField(inputType: TextInputType.multiline,isPassword: false,hintText: "",onSaved: (data){

              },mTextAlign: TextAlign.start,enabled: true,),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 50,left: 10,right: 10),
            )
          ],
        ),) ,
      ),
      bottomSheet: Container(
        height: 40,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child:Container(
                  child:MyButtonFormField(onPressed: (){
                    var mQuestionData =[];
                    mQuestionData.add(QuestionData(qust:"txt_Q1" ,ans: Q1Controller.text.toString()));
                    mQuestionData.add(QuestionData(qust: "txt_Q2" ,ans: Q2Controller.text.toString()));
                    mQuestionData.add(QuestionData(qust: "txt_Q3" ,ans: Q3Controller.text.toString()));
                    mMentorModel.mQuestionData=mQuestionData;
                    widget.controller.animateToPage(8, duration: Duration(milliseconds: 100), curve: Curves.linear);
                    }, width: ( MediaQuery.of(context).size.width/1.2), btn_name: "txt_Continue",color: Color(0xFF40aef9),fontcolor:Color(0xFF9fe0ff)),

                ),)]),
      ),
    );
  }
}
