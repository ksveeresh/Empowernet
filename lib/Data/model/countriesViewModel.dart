import 'dart:convert';
import 'package:flutter/material.dart';
import 'Countries.dart';
class PlayersViewModel {
  static List<countries> players;
  static Future loadPlayers(BuildContext context) async {
    try {
      players = new List<countries>();
      String jsonString = await DefaultAssetBundle.of(context).loadString('assets/players.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['players'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        players.add(new countries.fromJson(categoryJson[i]));
      }
    } catch (e) {
    }
  }
}