import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SAVED_MUSIC_KEY = "music_list";

//* Adds, Updates, Fetches data from device using SharedPreferences

class LocalData {
  late SharedPreferences sharedPreferences;

  addMusic(String trackId, String trackName) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(SAVED_MUSIC_KEY);
    List tracks = [];
    if (data != null && data.isNotEmpty) {
      tracks = json.decode(data);
    }
    tracks.add({'track_id': trackId, 'track_name': trackName});
    sharedPreferences.setString(SAVED_MUSIC_KEY, json.encode(tracks));
    debugPrint("Saving ${json.encode(tracks)} ");
  }

  doesMusicExist(String trackId) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(SAVED_MUSIC_KEY);
    if (data == null || data.isEmpty) return;
    List tracks = json.decode(data);

    for (Map e in tracks) {
      if (e['track_id'] == trackId) {
        return true;
      }
    }
    return false;
  }

  Future<List> getMusicList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(SAVED_MUSIC_KEY)) {
      String? data = sharedPreferences.getString(SAVED_MUSIC_KEY);

      List<dynamic> tracks = json.decode(data ?? "[]");
      return tracks;
    }
    return [];
  }

  //* Further Developments: Add Delete Track Logic
}

//Singleton Instance
LocalData localData = LocalData();
