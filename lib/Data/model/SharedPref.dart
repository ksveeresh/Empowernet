import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)) {
      return json.decode(prefs.getString(key));
    }else{
      return "";
    }
  }



  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  saveValue(String key, Map value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  readValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  removeValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}