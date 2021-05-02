
import 'package:country_picker/country_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_strength/password_strength.dart';
import 'package:soughted/Data/model/EncryptModel.dart';

import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/Pages/my_navigator.dart';
import 'package:soughted/widgetHelper/MyButtonFormField.dart';
import 'package:soughted/widgetHelper/MyTextFormField.dart';
import '../main.dart';
import 'package:easy_localization/easy_localization.dart';
class SignUpPage extends StatefulWidget {
  var term=false;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var mSignupRequest;
  DatabaseReference ref;
  String PwdStrength="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mSignupRequest=SignupRequest();
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        body: Container(
          color: Color(0xFF4990e2),
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(

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
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 5,right: 5),
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
                              mSignupRequest.name=text.toString().replaceAll(".", "*").replaceAll("#", "!").replaceAll("\$", "^").replaceAll("[", "|").replaceAll("]", "&").toString();
                            },
                            keyboardType:TextInputType.text,
                            obscureText:false,
                          )
                      ),
                      Divider(height: 3,thickness:3 ,color: Colors.white,),
                      Text("txt_FirstName".tr(),style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child:TextField(
                          cursorColor: Colors.white,
                          enabled: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          onChanged: (text) {
                            mSignupRequest.lastname=text.toString().replaceAll(".", "*").replaceAll("#", "!").replaceAll("\$", "^").replaceAll("[", "|").replaceAll("]", "&").toString();
                          },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                        ),
                      ),
                      Divider(height: 3,thickness:3 ,color: Colors.white,),
                      Text("txt_LastName".tr(),style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 40,
                        child:Row(children: [
                          Visibility(
                            visible:emailfild==true?false:true,
                            child: GestureDetector(
                              onTap: (){
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    setState(() {
                                      contryCode="+${country.phoneCode}";
                                    });
                                  },
                                );
                              },
                              child:Container(
                                width: 70,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Text(contryCode,style: TextStyle(fontSize: 16,color: Colors.white),),
                                    Icon(Icons.arrow_drop_down)
                                  ],),
                              ) ,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Wrap(
                                children: [
                                  TextField(
                                    cursorColor: Colors.white,
                                    enabled: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 16,color: Colors.white),
                                    decoration: InputDecoration(

                                      contentPadding: EdgeInsets.only(bottom: 10.0),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (text) {
                                      setState(() {
                                        mSignupRequest.userid=text.toString();
                                        emailfild=text.toString().length==0?true:text.contains(new RegExp(r'[A-Za-z]'));
                                      });                                    },
                                    keyboardType:TextInputType.text,
                                    obscureText:false,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],),
                      ),
                      Divider(height: 3,thickness:3 ,color: Colors.white,),
                      Text("txt_Username".tr(),style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 40,
                        child:TextField(
                          cursorColor: Colors.white,
                          enabled: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          onChanged: (text) {
                            if(text!="") {
                              double strength = estimatePasswordStrength(text);
                              if (strength < 0.3) {
                                setState(() {
                                  PwdStrength="weak";
                                });
                                print('This password is weak!');
                              } else if (strength < 0.7) {
                                setState(() {
                                  PwdStrength="alright";
                                });
                                print('This password is alright.');
                              } else {
                                setState(() {
                                  PwdStrength="strong";
                                });
                                print('This passsword is strong!');
                              }
                              mSignupRequest.password =
                                  text.toString().replaceAll(".", "*")
                                      .replaceAll("#", "!").replaceAll(
                                      "\$", "^").replaceAll("[", "|")
                                      .replaceAll("]", "&")
                                      .toString();
                            }else{
                              setState(() {
                                PwdStrength="";
                              });

                            }
                          },
                          keyboardType:TextInputType.text,
                          obscureText:true,
                        ),
                      ),
                      Divider(height: 3,thickness:3 ,color: Colors.white,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("txt_Password".tr(),style: TextStyle(color:Colors.white),),
                          Text(PwdStrength,style: TextStyle(color:PwdStrength=="weak"?Colors.red:PwdStrength=="alright"?Colors.yellow:Colors.green[800])),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 5,right: 5),
                          child:TextField(
                            cursorColor: Colors.white,
                            enabled: true,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16,color: Colors.white),
                            onChanged: (text) {

                              mSignupRequest.Confpassword=text.toString().replaceAll(".", "*").replaceAll("#", "!").replaceAll("\$", "^").replaceAll("[", "|").replaceAll("]", "&").toString();
                            },
                            keyboardType:TextInputType.text,
                            obscureText:false,
                          )
                      ),
                      Divider(height: 3,thickness:3 ,color: Colors.white,),
                      Text("txt_VerifyPassword".tr(),style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10),
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
                                        mSignupRequest.term=true;
                                        if(mSignupRequest.name.toString()==null||mSignupRequest.lastname==null||mSignupRequest.userid==null||mSignupRequest.password==null||mSignupRequest.Confpassword==null){
                                          Fluttertoast.showToast(
                                              msg: "Please fill in all fields",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          return;
                                        }
                                        if(mSignupRequest.password!=mSignupRequest.Confpassword){
                                          Fluttertoast.showToast(
                                              msg: "Password and confirm password does not match",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          return;
                                        }
                                        if(mSignupRequest.term!=true){
                                          Fluttertoast.showToast(
                                              msg: "Not accepted terms and conditions",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                          return;
                                        }
                                        mSignupRequest.contry_code=contryCode;
                                        mSignupRequest.profile_img="";
                                        mSignupRequest.Cv="";
                                        mSignupRequest.status=0;
                                        ref.child('Usersids').child(EncryptModel().Encryptedata(mSignupRequest.userid)).onValue.listen((e) {
                                          var datasnapshot = e.snapshot.value;
                                          if(datasnapshot==null){
                                            MyNavigator.goOtpPage(context,mSignupRequest);
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "User already exists.....",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        });

                                      },
                                      child: Row(
                                        children: [
                                          Text("${"btn_join.".tr()}!"),
                                        ],
                                      ),
                                    )


                                ),
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("txt_t_and_c1".tr(),style: TextStyle(color: Colors.white,fontSize: 10),),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(fontSize: 10),
                                  children: <TextSpan>[
                                    TextSpan(text: 'txt_t_and_c2'.tr(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900],decoration: TextDecoration.underline)),
                                    TextSpan(text: 'txt_t_and_c3'.tr(),style: TextStyle(color: Colors.white),),
                                    TextSpan(text: 'txt_t_and_c4'.tr(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[900],decoration: TextDecoration.underline)),
                                    TextSpan(text: '.',style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }



}