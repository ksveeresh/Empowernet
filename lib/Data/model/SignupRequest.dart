// To parse this JSON data, do
//
//     final signupRequest = signupRequestFromJson(jsonString);

import 'dart:convert';

SignupRequest signupRequestFromJson(String str) => SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  SignupRequest({
    this.name,
    this.userid,
    this.lastname,
    this.password,
    this.Confpassword,
    this.term,
    this.contry_code,
    this.profile_img,
    this.Cv,
    this.status,
    this.mentorship_type,
    this.usertype,
    this.id,
  });
var id;
  var name;
  var userid;
  var lastname;
  var password;
  var Confpassword;
  var term=false;
  var contry_code;
  var profile_img;
  var Cv;
  var status;
  var mentorship_type;
  var usertype;

   SignupRequest.fromJson(Map<String, dynamic> json){
     name= json["name"];
     userid= json["userid"];
     lastname=json["lastname"];
     password= json["password"];
     Confpassword= json["Confpassword"];
     term= json["term"];
     contry_code= json["contry_code"];
     profile_img= json["profile_img"];
     Cv= json["Cv"];
     status= json["status"];
     mentorship_type= json["mentorship_type"];
     usertype= json["usertype"];
     id= json["id"];
   }

  Map<String, dynamic> toJson() => {
    "name": name,
    "userid": userid,
    "lastname": lastname,
    "password": password,
    "Confpassword": Confpassword,
    "term": term,
    "contry_code": contry_code,
    "profile_img": profile_img,
    "Cv": Cv,
    "status": status,
    "mentorship_type": mentorship_type,
    "usertype": usertype,
    "id": id
  };


}
