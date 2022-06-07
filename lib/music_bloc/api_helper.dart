import 'package:http/http.dart' as http;
import 'package:lyrics_app/music_bloc/music_model.dart';

import 'dart:convert';

//* API Related Strings

const String APIKEY = "82b223129b864c98b51c5eb2904eeb7c";
const String BASE_URL = "https://api.musixmatch.com/ws/1.1/";

const String GET_TRACKS = "chart.tracks.get?apikey=$APIKEY";
const String TRACK_DETAILS = "track.get?track_id=";
const String TRACK_LYRICS = "track.lyrics.get?track_id=";

/* 
* Gets data in one go but very slow not efficient
* because of 2 API's call, for each item
*/
//! OBSELETE
Future<List<MusicModel>> getTracks() async {
  http.Response response = await http.get(Uri.parse(BASE_URL + GET_TRACKS));

  Map data = json.decode(response.body)['message']['body'];
  List<dynamic> tracks = data['track_list'];

  List<MusicModel> musicList = [];

  for (var e in tracks) {
    int trackId = e['track']['track_id'];

    MusicModel musicModel = await getMusicDetailsFromId(trackId.toString());

    musicList.add(musicModel);
  }
  return musicList;
}

//* Gets data item by item, fast and efficient
//! USED IN THE APP
Stream<List<MusicModel>> getTrackStream() async* {
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

    musicList.add(musicModel);
    yield musicList;
  }
}

Future<MusicModel> getMusicDetailsFromId(String trackId) async {
  String url = "$BASE_URL$TRACK_DETAILS$trackId&apikey=$APIKEY";

  http.Response newResponse = await http.get(Uri.parse(url));
  Map<String, dynamic> map =
      json.decode(newResponse.body)['message']['body']['track'];
  MusicModel musicModel = MusicModel.fromMap(map);
  return musicModel;
}

Future<String> getLyrics(String id) async {
  http.Response response =
      await http.get(Uri.parse('$BASE_URL$TRACK_LYRICS$id&apikey=$APIKEY'));

  Map data = json.decode(response.body)['message']['body'];
  return data['lyrics']['lyrics_body'];
}
