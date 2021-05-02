import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/Pages/my_navigator.dart';
import 'package:easy_localization/easy_localization.dart';
class verifiecation extends StatefulWidget {
  var emailfild =true;
  var contryCode ="+91";
  var arguments;
  verifiecation(this.arguments);
  @override
  _verifiecationState createState() => _verifiecationState();
}

class _verifiecationState extends State<verifiecation> {
  TextEditingController UserIdController;

  String userid;

  SignupRequest mSignupRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mSignupRequest=SignupRequest.fromJson(widget.arguments);
    userid=mSignupRequest.userid.toString();
    UserIdController=TextEditingController(text: userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
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
              Text("Let’s confirm your ${widget.emailfild==true?"email":"mobile number"}.",style: TextStyle(fontSize: 17,color: Colors.white),),
              Text("We will send a verification code (SNS) to the ${widget.emailfild==true?"email":"mobile number"} below.",style: TextStyle(fontSize: 11,color: Colors.white),),
              Row(children: [
                Visibility(
                  visible:widget.emailfild==true?false:true,
                  child: GestureDetector(
                    onTap: (){
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            widget.contryCode="+${country.phoneCode}";
                          });
                        },
                      );
                    },
                    child:Container(
                      width: 70,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(widget.contryCode,style: TextStyle(fontSize: 16,color: Colors.white),),
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
                          controller: UserIdController,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            setState(() {
                              widget.emailfild=text.toString().length==0?true:text.contains(new RegExp(r'[A-Za-z]'));
                            });                                    },
                          keyboardType:TextInputType.text,
                          obscureText:false,
                        )
                      ],
                    ),
                  ),
                ),
              ],),
              Divider(height: 3,thickness:3 ,color: Colors.white,),
              Text("txt_Username".tr(),style: TextStyle(color: Colors.white),),
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
                          MyNavigator.goOtpPage(context,mSignupRequest);
                          // if(widget.emailfild!=true) {
                          //   var lkl=auth.verifyPhoneNumber(
                          //       phoneNumber: "${widget.contryCode}${UserIdController.text.toString()}",
                          //       timeout: Duration(seconds: 60),
                          //       verificationCompleted: (AuthCredential auth){
                          //         print("Done");
                          //       },
                          //       verificationFailed: (FirebaseAuthException authException){
                          //         print(authException.message);
                          //       },
                          //       codeSent: (String verificationId, [int forceResendingToken]){
                          //         print(forceResendingToken);
                          //
                          //       },
                          //       codeAutoRetrievalTimeout: (String verificationId){
                          //
                          //       }
                          //   );
                          //
                          // }else {
                          //   int min = 10000; //min and max values act as your 6 digit range
                          //   int max = 99999;
                          //   var randomizer = new Random();
                          //   var rNum = min + randomizer.nextInt(max - min);
                          //   mSendMail().CreateMail(rNum,UserIdController.text.toString());
                          // }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Send Code",style: TextStyle(color: Colors.black87),),

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
}
