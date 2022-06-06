import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lyrics_app/bloc/music_model.dart';
import 'package:lyrics_app/globals.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  setUpAll(() async {
    HttpOverrides.global = _MyHttpOverrides();
  });
  test("Check GetTracks Function", () async {
    http.Response response = await http.get(Uri.parse(BASE_URL + GET_TRACKS));

    Map data = json.decode(response.body)['message']['body'];
    List<dynamic> tracks = data['track_list'];

    List<MusicModel> musicList = [];

    for (var e in tracks) {
      int trackId = e['track']['track_id'];
      response = await http.get(
        Uri.parse("$BASE_URL$TRACK_DETAILS$trackId&apiKey=$APIKEY"),
      );
      MusicModel musicModel = MusicModel.fromMap(
        json.decode(response.body)['message']['body'],
      );
      musicList.add(musicModel);
    }

    print(musicList.toString());
    await Future.delayed(Duration(seconds: 2));
  });
}

Future<List> getTracks() async {
  http.Response response = await http.get(Uri.parse(BASE_URL + GET_TRACKS));

  Map data = json.decode(response.body);
  List<Map> tracks = data['track_list'];

  List<String> trackIDs = [];
  tracks.map((e) => trackIDs.add(e['track_id']));
  print(trackIDs.toString());
  return trackIDs;
}

class _MyHttpOverrides extends HttpOverrides {}
