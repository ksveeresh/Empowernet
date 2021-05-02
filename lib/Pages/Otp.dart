import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soughted/Data/model/SendMail.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/Pages/my_navigator.dart';
import 'package:soughted/main.dart';
import 'dart:math';
import 'dart:convert';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:firebase_database/firebase_database.dart';
class Otp extends StatefulWidget {
  var arguments;
  var emailfild =true;
  Otp(this.arguments);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  SignupRequest mSignupRequest;
  TextEditingController UserIdController=TextEditingController();
  String verificationId;
  String userid;
  FirebaseAuth auth;
  DatabaseReference ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mSignupRequest=SignupRequest.fromJson(widget.arguments);
    userid=mSignupRequest.userid.toString();
    print(userid);
    widget.emailfild=userid.contains(new RegExp(r'[A-Za-z]'));
    auth = FirebaseAuth.instanceFor(app: app);
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    sendOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF4b91e3),
          padding: EdgeInsets.all(20),
          height:  MediaQuery
              .of(context)
              .size
              .height,
          alignment: Alignment.center,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 70,),
              Text("Enter code sent to ${userid}.",style: TextStyle(fontSize: 17,color: Colors.white),),
              Text("This is the confirm your access to this ${widget.emailfild==true?"email":"mobile number"} below.",style: TextStyle(fontSize: 11,color: Colors.white),),
              Row(children: [
                Expanded(
                  child: Container(
                    child: Wrap(
                      children: [
                        TextField(
                          cursorColor: Colors.white,
                          enabled: true,
                          textAlign: TextAlign.start,
                          controller: UserIdController,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {


                          },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                        )
                      ],
                    ),
                  ),
                ),
              ],),
              Divider(height: 3,thickness:3 ,color: Colors.white,),
              Text("Enter Code",style: TextStyle(color: Colors.white),),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                      width: 100,
                      child:RaisedButton(
                        padding: EdgeInsets.all(10),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.white,
                        textColor: Color(0xFF444444),
                        onPressed:() async {
                          VerifyOtp();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Verify Code",style: TextStyle(color: Colors.black87),),

                          ],
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }

  void sendOtp() {
    if(widget.emailfild!=true) {
      print("${mSignupRequest.contry_code}${userid}");
      auth.verifyPhoneNumber(
          phoneNumber: "${mSignupRequest.contry_code}${userid}",
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential auth){
            print("Done");
          },
          verificationFailed: (FirebaseAuthException authException){
            print(authException.message);
          },
          codeSent: (String verificationId, [int forceResendingToken]){
            this.verificationId = verificationId;

          },
          codeAutoRetrievalTimeout: (String verificationId){

          }
      );

    }else {
      int min = 10000; //min and max values act as your 6 digit range
      int max = 99999;
      var randomizer = new Random();
      verificationId = "${min + randomizer.nextInt(max - min)}";
      mSendMail().CreateMail(int.parse(verificationId),userid);
    }
  }

  Future<void> VerifyOtp() async {
    if(widget.emailfild!=true) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: UserIdController.text.toString().trim(),
        );
        UserCredential user = await auth.signInWithCredential(credential);
        if(user!=null){
          var ref1 = ref.child('Users');
          mSignupRequest.id=ref.child('Usersids').push().key;
          ref.child('Usersids').child(EncryptModel().Encryptedata(mSignupRequest.userid).toString().replaceAll("/", "*")).set(mSignupRequest.id);
          userdata = mSignupRequest;
          ref1.child(mSignupRequest.id).set(EncryptModel().Encryptedata(jsonEncode(mSignupRequest)));
          MyNavigator.goToCreateProfil(context);
        }else{
          Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }catch(e){
        Fluttertoast.showToast(
            msg: "Invalid Otp. please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }else{
      if(verificationId== UserIdController.text.toString().trim()){
        var ref1 = ref.child('Users');
        mSignupRequest.id=ref.child('Usersids').push().key;
        ref.child('Usersids').child(EncryptModel().Encryptedata(mSignupRequest.userid).toString().replaceAll("/", "*")).set(mSignupRequest.id);
        ref1.child(mSignupRequest.id).set(EncryptModel().Encryptedata(jsonEncode(mSignupRequest)));
        MyNavigator.goToCreateProfil(context);
      }else{
        Fluttertoast.showToast(
            msg: "Invalid Otp. please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }
}
