import 'package:http/http.dart' as http;
import 'package:lyrics_app/music_bloc/music_model.dart';
import 'package:lyrics_app/globals.dart';

import 'dart:convert';

Future<List<MusicModel>> getTracks() async {
  http.Response response = await http.get(Uri.parse(BASE_URL + GET_TRACKS));

  Map data = json.decode(response.body)['message']['body'];
  List<dynamic> tracks = data['track_list'];

  List<MusicModel> musicList = [];

  for (var e in tracks) {
    int trackId = e['track']['track_id'];
    String url = "$BASE_URL$TRACK_DETAILS$trackId&apikey=$APIKEY";

    http.Response newResponse = await http.get(Uri.parse(url));
    Map<String, dynamic> map =
        json.decode(newResponse.body)['message']['body']['track'];
    MusicModel musicModel = MusicModel.fromMap(map);
    print(map);
    musicList.add(musicModel);
  }
  return musicList;
}

Future<String> getLyrics(String id) async {
  http.Response response =
      await http.get(Uri.parse('$BASE_URL$TRACK_LYRICS$id&apikey=$APIKEY'));

  Map data = json.decode(response.body)['message']['body'];
  return data['lyrics']['lyrics_body'];
}
