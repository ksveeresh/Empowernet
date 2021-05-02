import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soughted/Pages/Notes/AllMentees.dart';
import 'package:soughted/Pages/Notes/MentorNotes.dart';
import 'package:soughted/Pages/Notes/RequstMentees.dart';
import 'package:soughted/main.dart';

import 'AllMentors.dart';

class Notes extends StatefulWidget {
  PageController controller;
  Function onDataCallback;
  Notes({this.controller, this.onDataCallback});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  PageController SubController;

  @override
  void initState() {
    super.initState();
    SubController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF4b91e3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Container(
              //           child: Container(
              //               height: 40,
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Colors.grey,
              //                     width: 1,
              //                   ),
              //                   borderRadius:BorderRadius.circular(0),
              //                   color: Colors.white
              //               )
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Container(
              //           height:40,child: GestureDetector(onTap:(){
              //         widget.controller.animateToPage(4, duration: Duration(milliseconds: 1), curve: Curves.linear);
              //       },child: FittedBox(fit: BoxFit.fill,child: Icon(userdata.usertype=="mentee"?FontAwesomeIcons.edit:FontAwesomeIcons.users, color: Colors.black,)))
              //       )
              //     ],
              //   ),
              // ),
              userdata.usertype!="mentee"?Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10,left: 15,bottom: 10,right: 15),
                child:RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Your Mentees",style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20 ,color:Colors.white )
                      ),
                    ],
                  ),
                ),
              ):Container(),
              Container(
                height: MediaQuery.of(context).size.height,

                color: Color(0xFFd0e2f2),
                child: Column(
                  children: [
                    userdata.usertype=="mentee"?
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              color:Color(0xFFaacfe3),
                              child: Text('Mentor Notes',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                              onPressed: () {
                                SubController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.linear);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              color:Color(0xFFaacfe3),
                              child: Text('Your Mentors',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                              onPressed: (){
                                SubController.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);
                              },
                            ),
                          ),
                        )
                      ],
                    ):
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              color:Color(0xFFc6d0dc),
                              child: Text('Requests',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                              onPressed: (){
                                SubController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.linear);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              color:Color(0xFFc6d0dc),
                              child: Text('Your Mentees',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 16 ,color:Color(0xFF515f6a), ),textAlign: TextAlign.center,),
                              onPressed: () {
                                SubController.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.linear);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    userdata.usertype=="mentee"?
                    Expanded(
                      child: PageView(
                        physics:new NeverScrollableScrollPhysics(),
                        controller: SubController,
                          children:<Widget> [
                            MentorNotes(widget.controller),
                            AllMentors(onLoadProfile: (value){
                              widget.onDataCallback(value);
                            },),
                          ]
                      ),
                    ):
                    Expanded(
                      child: PageView(
                        physics:new NeverScrollableScrollPhysics(),
                        controller: SubController,
                          children:<Widget> [
                            RequstMentees(onLoadProfile: (value){
                              widget.onDataCallback(value);
                            },),
                            AllMentees(onLoadProfile: (value){
                              widget.onDataCallback(value);
                            },)
                          ]
                      ),
                    ),
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
