// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import '../../main.dart';
//
// class SubUser {
//   var id;
//   var name;
//   var email;
//   var phone;
//   var gander;
//   var profile;
//
//   SubUser({this.id, this.name, this.email, this.phone, this.gander, this.profile});
//
//   SubUser.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     gander = json['gander'];
//     profile = json['profile'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, String> data = new Map<String, String>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['gander'] = this.gander;
//     data['profile'] = this.profile;
//     return data;
//   }
// }
//
// class UsersViewModel {
//
//   static Future loadPlayers(BuildContext context) async {
//     try {
//       Users = new List<SubUser>();
//       String jsonString = await DefaultAssetBundle.of(context).loadString('assets/user.json');
//       var data =json.decode(jsonString) as List<dynamic>;
//       for (int i = 0; i < data.length; i++) {
//         Users.add(SubUser.fromJson(data[i]));
//       }
//
//     } catch (e) {
//     }
//   }
// }