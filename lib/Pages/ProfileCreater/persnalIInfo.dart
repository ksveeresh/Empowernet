import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/Languages.dart';
import 'package:soughted/Data/model/Languages.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'dart:convert';

import 'package:soughted/widgetHelper/MyCountryFormField.dart';

import 'package:easy_localization/easy_localization.dart';
List<dynamic> _selectedtwitterResult = [];
class PersnalIInfo extends StatefulWidget {
  PageController  controller;
  int slideIndex;
  PersnalIInfo(this.controller,this.slideIndex);


  @override
  _PersnalIInfoState createState() => _PersnalIInfoState(this.controller,this.slideIndex);
}

class _PersnalIInfoState extends State<PersnalIInfo> {
  PageController  controller;
  TextEditingController firstnameController=TextEditingController(text: userdata.name);
  TextEditingController lastnameController=TextEditingController(text: userdata.lastname);
  TextEditingController occupationController=TextEditingController(text: model.personl!=null?model.personl.occupation:"");
  TextEditingController placeController=TextEditingController();
  int slideIndex;
  String img_path="";
  final GlobalKey _menuKey = new GlobalKey();
  var lang=[];
  List<String> gander = ["Male","Female","Others"];
  List<PopupMenuItem> GenderpopList = [];
  String textGenderpopList="";
  String textLang="";

  DatabaseReference ref;
  _PersnalIInfoState(this.controller,this.slideIndex);
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    if(model.personl==null){
      model.personl=PersonlBean();
    }
    gander.asMap().forEach((i, value) {
      GenderpopList.add(
          PopupMenuItem(
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
            value: value,
          )
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){

      },
      child: Scaffold(
          backgroundColor:Color(0xFF4b91e3),
          body:
          SafeArea(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(child:
                Container(
                  height:  MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/logo.png',),
                              width: 300,
                              height: 150,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            _showPicker(context);
                          },
                          child:userdata.profile_img==""?Align(
                            alignment: FractionalOffset(0.5, 0.0),
                            child:Container(

                              decoration: BoxDecoration(
                                  color: Color(0xFFcfe2f3),
                                  shape: BoxShape.circle
                              ),
                              height: 100,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image(
                                        image: AssetImage('assets/profile_img.png',),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("txt_photo1".tr(),style: TextStyle(fontSize: 12),),
                                        Text("txt_photo2".tr(),style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ):StreamBuilder<Uri>(
                            stream: DownLoadUrl().asStream(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return Align(
                                  alignment: FractionalOffset(0.5, 0.0),
                                  child:CircleAvatar(radius: 40.0,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))),
                                );
                              }
                              return Align(
                                  alignment: FractionalOffset(0.5, 0.0),
                                  child:     Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image:new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot.data.toString())
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),

                        SizedBox(height: 20),
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
                                        model.personl.firestName=text;
                                      },
                                      keyboardType:TextInputType.text,
                                      obscureText:false,
                                      controller:firstnameController,
                                    ),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_FirstName".tr(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
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
                                        model.personl.lastName=text;
                                      },
                                      keyboardType:TextInputType.text,
                                      obscureText:false,
                                      controller: lastnameController,
                                    ),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_LastName".tr(),style: TextStyle(color: Colors.white),)
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
                                        model.personl.occupation=text;
                                      },
                                      keyboardType:TextInputType.text,
                                      obscureText:false,
                                      controller: occupationController,
                                    ),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_Headline".tr(),style: TextStyle(color: Colors.white),)
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
                                    height: 40,
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    child: MyCountryFormField(onSaved: (Country country){
                                      setState(() {
                                        model.personl.country=country.name;
                                        model.personl.country_code=country.phoneCode;
                                        model.personl.country_loc_code=country.countryCode;
                                      });
                                    },enabled: true,titleText: model.personl.country!=null?model.personl.country:"",),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_Country".tr(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            Expanded(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 5,right: 5),
                                      child:TextField(
                                        cursorColor: Colors.white,
                                        enabled: false,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 16,color: Colors.white),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (text) {
                                          model.personl.occupation=text;
                                        },
                                        keyboardType:TextInputType.text,
                                        obscureText:false,
                                        controller: placeController,
                                      ),
                                    ),
                                    onTap: () async {
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: "AIzaSyBA-NOiGetd2zwmqsEBJ2krxrKWuwHsB1M",
                                          mode: Mode.fullscreen, // Mode.fullscreen
                                          language: model.personl.country_loc_code,
                                          components: [ Component(Component.country, model.personl.country_loc_code)]
                                      ).then((value){
                                        setState(() {
                                          model.personl.city=value.description;
                                          placeController.text=value.description;
                                        });

                                      });

                                    },
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_Location".tr(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),

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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            child: Text(model.personl.gander!=null?model.personl.gander:textGenderpopList,style: TextStyle(color: Colors.white),),onTap: (){
                                            dynamic state = _menuKey.currentState;
                                            state.showButtonMenu();
                                          },),
                                        ),
                                        PopupMenuButton(
                                          color: Color(0xFFcfe2f3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                          icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                          key: _menuKey,
                                          onSelected: (selectedDropDownItem){
                                            setState(() {
                                              textGenderpopList=selectedDropDownItem;
                                              model.personl.gander=selectedDropDownItem;
                                            });
                                          },
                                          itemBuilder: (BuildContext context) =>GenderpopList,
                                          tooltip: "Tap me to select a number.",
                                        ),
                                      ],),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_gander".tr(),style: TextStyle(color: Colors.white),)
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
                                    child:   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 40.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _selectedtwitterResult.length,
                                              itemBuilder: (context, index) {
                                                return(_selectedtwitterResult[index] as Map)["isChecked"]==true?Container(
                                                    padding: EdgeInsets.only(left: 2,right: 2),
                                                    alignment: Alignment.centerLeft,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        List item = await Navigator.of(context).push(new MaterialPageRoute<List>(
                                                            builder: (BuildContext context) {
                                                              return  LangDialog();
                                                            },
                                                            fullscreenDialog: true
                                                        ));
                                                        List itemSelect=[];
                                                        item.forEach((element) {
                                                          if((element as Map)["isChecked"]==true){
                                                            Map item=Map();
                                                            item["Lang"]=(element as Map)["name"];
                                                            item["type"]=(element as Map)["langtype"];
                                                            itemSelect.add(item);
                                                          }
                                                        });
                                                        model.personl.Lang=itemSelect;
                                                        _selectedtwitterResult.addAll(item);
                                                        textLang="";
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Text("${(_selectedtwitterResult[index] as Map)["name"]}(${GetLangLevel((_selectedtwitterResult[index] as Map)["langtype"])}),",
                                                        style: TextStyle(color: Colors.white),

                                                      ),
                                                    )
                                                ):Container();
                                              },
                                            ),
                                          ),
                                        ),
                                        GestureDetector(child: Icon(Icons.add,color: Colors.white,),onTap: () async {
                                          List item = await Navigator.of(context).push(new MaterialPageRoute<List>(
                                              builder: (BuildContext context) {
                                                return  LangDialog();
                                              },
                                              fullscreenDialog: true
                                          ));
                                          List itemSelect=[];
                                          item.forEach((element) {
                                            if((element as Map)["isChecked"]==true){
                                              Map item=Map();
                                              item["Lang"]=(element as Map)["name"];
                                              item["type"]=(element as Map)["langtype"];
                                              itemSelect.add(item);
                                            }
                                          });
                                          model.personl.Lang=itemSelect;
                                          _selectedtwitterResult.addAll(item);
                                          setState(() {

                                          });
                                        },)
                                      ],),
                                  ),
                                  Divider(height: 3,thickness:3 ,color: Colors.white,),
                                  Text("txt_Languages".tr(),style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ],),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 5),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child:RaisedButton(
                                  padding: EdgeInsets.all(10),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: Color(0xFFcfe2f3),
                                  textColor: Color(0xFF444444),
                                  onPressed:(){
                                    if(model.personl.firestName==null){
                                      model.personl.firestName=userdata.name;
                                    }
                                    if(model.personl.lastName==null){
                                      model.personl.lastName=userdata.lastname;
                                    }
                                    if(model.personl.profile_path==null){
                                      model.personl.profile_path=userdata.profile_img;
                                    }
                                    // if(model.personl.occupation==null){
                                    //   Fluttertoast.showToast(
                                    //       msg: "Occupation headline required .",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.TOP,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.black,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    //   return;
                                    // }
                                    // if(model.personl.city==null){
                                    //   Fluttertoast.showToast(
                                    //       msg: "City required .",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.TOP,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.black,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    //   return;
                                    // }
                                    // if(model.personl.gander==null){
                                    //   Fluttertoast.showToast(
                                    //       msg: "Gander required .",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.TOP,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.black,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    //   return;
                                    // }
                                    // if(model.personl.country==null){
                                    //   Fluttertoast.showToast(
                                    //       msg: "Country required .",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.TOP,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.black,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    //   return;
                                    // }
                                    // if(model.personl.Lang==null){
                                    //   Fluttertoast.showToast(
                                    //       msg: "Language required .",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.TOP,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.black,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0
                                    //   );
                                    //   return;
                                    // }
                                    // if(model.personl.country_code==null){
                                    //   model.personl.country_code="";
                                    // }
                                    //
                                    // if(model.personl.mentorship==null){
                                    //   model.personl.mentorship="";
                                    // }
                                    // model.personl.profile_path=userdata.profile_img;
                                    // print(model.personl.toJson());
                                    widget.controller.animateToPage(2, duration: Duration(milliseconds: 100), curve: Curves.linear);
                                  },
                                  child: Row(
                                      children: [
                                        Text("${"txt_Continue".tr()}!"),
                                      ]),
                                ),
                              )

                            ],
                          ),
                        )

                      ]
                  ),
                ),

                )
            ),
          )
      ),
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  uploadImage() async {
    final picker = ImagePicker();
    File _image;
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadToFirebase(_image);
    } else {
      print('No image selected.');
    }
  }

  Future<void> uploadToFirebase(File file) async {
    final filePath = '${userdata.name}_${userdata.lastname}.png';
    await FirebaseStorage.instance
        .refFromURL('gs://squghted.appspot.com/images/')
        .child(filePath)
        .putFile(file)
        .then((value) async{
      userdata.profile_img = await value.ref.getDownloadURL();
      print(userdata.profile_img);
      ref.child('Users').child(userdata.id).set(EncryptModel().Encryptedata(jsonEncode(userdata)));
      setState(() {});
    }).catchError((onError){
      print(onError.toString());
    });
  }
  Future<Uri> DownLoadUrl() async {
    String strURL = await FirebaseStorage.instance.refFromURL('gs://squghted.appspot.com/images/').child('${userdata.name}_${userdata.lastname}.png').getDownloadURL();;
    return Uri.parse(strURL);
  }

  GetLangLevel(element) {
    if(element==0) {
      return "Beginner";
    }else if(element==1) {
      return "Intermediate";
    }else if(element==2) {
      return "Fluent";
    }
  }

  _imgFromCamera() async {
    PickedFile file=await ImagePicker.platform.pickImage(
        source: ImageSource.camera, maxHeight: 500,maxWidth: 500,imageQuality: 50,preferredCameraDevice: CameraDevice.front
    );
    File path=await File(file.path);
    uploadToFirebase(path);
  }

  _imgFromGallery() async {
    PickedFile file=await ImagePicker.platform.pickImage(
        source: ImageSource.gallery, maxHeight: 500,maxWidth: 500,imageQuality: 50,preferredCameraDevice: CameraDevice.front
    );
    File path=await File(file.path);
    uploadToFirebase(path);

    // setState(() {
    //   _image = image;
    // });
  }
}
class LangDialog extends StatefulWidget {


  @override
  _LangDialogState createState() => _LangDialogState();
}

class _LangDialogState extends State<LangDialog> {

  TextEditingController controller = new TextEditingController();
  List<dynamic> _searchResult = [];
  List selectedLang=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchResult.addAll(defaultLanguagesList);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color(0xFFcfe2f3),
        title: Center(child: Text("Language",style: TextStyle(
            color: Colors.black
        ),textAlign: TextAlign.center,),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.black,
            ),
            onPressed: () async {
              selectedLang.clear();
              selectedLang.addAll(_searchResult);
              Navigator
                  .of(context)
                  .pop(selectedLang);
            },
          )
        ],

      ),

      backgroundColor: Color(0xFF4b91e3),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius:BorderRadius.circular(0),
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              child:TextField(
                controller: controller,
                cursorColor: Colors.white,
                enabled: true,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16,color: Colors.white),
                decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                onChanged: onSearchTextChanged,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height-50,
              child: ListView.builder(
                itemCount:_searchResult.length,
                itemBuilder: (context, index) {
                  return Column(

                    children: [
                      CheckboxListTile(
                        title: Text((_searchResult[index] as Map)["name"],style: TextStyle(color: Colors.white),),
                        value: (_searchResult[index] as Map)["isChecked"],
                        onChanged: (val) {
                          setState(() {
                            (_searchResult[index] as Map)["isChecked"] = val;
                          },
                          );
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      (_searchResult[index] as Map)["isChecked"]==true?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Expanded(
                            child:  RadioListTile(
                                contentPadding:  EdgeInsets.all(1.0),
                                title: const Text('Beginner',style: TextStyle(color: Colors.white,fontSize: 12)),
                                value:0,
                                groupValue:(_searchResult[index] as Map)["langtype"],
                                onChanged: (dynamic value) {
                                  setState(() {
                                    (_searchResult[index] as Map)["langtype"] = value;
                                  });
                                }
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              contentPadding:  EdgeInsets.all(1.0),
                              title: const Text('Intermediate',style: TextStyle(color: Colors.white,fontSize: 12)),
                              value:1,
                              groupValue: (_searchResult[index] as Map)["langtype"],
                              onChanged: (dynamic value) {
                                setState(() {
                                  (_searchResult[index] as Map)["langtype"] = value;
                                });
                              },

                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                                contentPadding:  EdgeInsets.all(1.0),
                                dense: true,
                                title: const Text('Fluent',style: TextStyle(color: Colors.white,fontSize: 12)),
                                value:2,
                                groupValue:(_searchResult[index] as Map)["langtype"],
                                onChanged: (dynamic value) {
                                  setState(() {
                                    (_searchResult[index] as Map)["langtype"] = value;
                                  });
                                }
                            ),
                          ),

                        ],
                      ):Container()
                    ],
                  );
                },
              ),
            )

          ],
        ),
      ),

    );
  }
  void onSearchTextChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      _searchResult.addAll(defaultLanguagesList);
      if(_searchResult.length>0){
        setState(() {});
      }
    }
    defaultLanguagesList.forEach((userDetail) {
      if ((userDetail as Map)["name"].toLowerCase().contains(value.toLowerCase()))
        _searchResult.add(userDetail);
    });
    if(_searchResult.length>0){
      setState(() {});
    }
  }

}
