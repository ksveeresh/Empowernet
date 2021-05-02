import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soughted/Data/model/CreateprofileResponse.dart';
import 'package:soughted/Data/model/LoginRequest.dart';
import 'package:soughted/Data/model/LoginResponse.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/Data/model/SignupRequest.dart';
import 'package:soughted/Data/model/SignupResponses.dart';


class Api{
  Future<LoginResponse> Login(LoginRequest request) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> headers = {'Content-Type':'application/json'};
    final response=await post(prefs.getString("ServiceUrl")+"login",headers:headers,body:jsonEncode(request));
    if(response.statusCode==200){
      String responseString=response.body;
      return LoginResponse.fromJson(jsonDecode(responseString));
    }else{
      return LoginResponse(Status:"400",message:"Internal Server Error");
    }
  }

  Future<SignupResponses> Signup(SignupRequest request)async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> headers = {'Content-Type':'application/json'};
    final response=await post(prefs.getString("ServiceUrl")+"regression",headers:headers,body:jsonEncode(request));
    if(response.statusCode==200){
      String responseString=response.body;
      return SignupResponses.fromJson(jsonDecode(responseString));
    }else{
      return SignupResponses(Status:"400",message:"Internal Server Error");
    }
  }

  Future<CreateprofileResponse> createProfile(ProfileData request) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> headers = {'Content-Type':'application/json'};
    final response=await post(prefs.getString("ServiceUrl")+"PersonlCV",headers:headers,body:jsonEncode(request));
    if(response.statusCode==200){
      String responseString=response.body;
      return CreateprofileResponse.fromJson(jsonDecode(responseString));
    }else{
      return CreateprofileResponse(Status:"400",message:"Internal Server Error");
    }
  }

}
