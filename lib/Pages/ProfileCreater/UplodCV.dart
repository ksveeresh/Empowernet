import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/SharedPref.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/main.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';

// import 'package:firebase/firebase.dart' as fb;
class UplodCv extends StatefulWidget {
  PageController controller;
  int slideIndex;
  UplodCv(this.controller,this.slideIndex);

  @override
  _UplodCvState createState() => _UplodCvState();
}



class _UplodCvState extends State<UplodCv> {
  DatabaseReference ref;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor:Color(0xFF4990e2),
        body:Padding(
          padding: EdgeInsets.all(10),
          child:Container(
            padding: EdgeInsets.only(top: 50,bottom: 50,left: 10,right: 10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:Center(
              child: GestureDetector(
                onTap: (){
                  uploadCv();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined,size: 50.0,),
                    Text("Upload CV",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                    Text("Accepts: .jpg .pdf .png",style: TextStyle(color: Colors.white,fontSize: 11.0),),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          height: 100,
          color:Color(0xFF4990e2),
          alignment: Alignment.bottomRight,
          child:  MyButtonFormField(onPressed: (){
            widget.controller.animateToPage(7, duration: Duration(milliseconds: 100), curve: Curves.linear);

          },
              btn_name: "Continue",color: Colors.white,fontcolor: Colors.black),
          padding: EdgeInsets.only(left: 20,right: 20),
        ),
      );
  }

  Future<void> uploadCv() async {
    final filepath = await FlutterDocumentPicker.openDocument();
    File path=await File(filepath);
    uploadToFirebase(path);
  }

  Future<void> uploadToFirebase(File file) async {
    String pathurl=file.path;
    String extension = pathurl.substring(pathurl.lastIndexOf("."));
    print(extension);
    userdata = SignupRequest.fromJson(await SharedPref().read("UserData"));
    final filePath ='${userdata.name}_${userdata.lastname}${extension}';
    userdata.Cv = "gs://squghted.appspot.com/doc/${filePath}";
    FirebaseStorage.instance
        .refFromURL('gs://squghted.appspot.com/doc/')
        .child(filePath)
        .putFile(file).then((value) async{
      userdata.Cv = await value.ref.getDownloadURL();
      ref.child('Users').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(userdata))).then((value){
        setState(() {

        });
      });

    });
  }
}
