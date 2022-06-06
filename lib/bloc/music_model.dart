import 'dart:convert';

MusicModel musicModelFromMap(String str) =>
    MusicModel.fromMap(json.decode(str));

String musicModelToMap(MusicModel data) => json.encode(data.toMap());

class MusicModel {
  MusicModel({
    this.trackId,
    this.trackName,
    this.trackRating,
    this.commontrackId,
    this.instrumental,
    required this.explicit,
    this.hasLyrics,
    this.hasSubtitles,
    this.hasRichsync,
    this.numFavourite,
    this.albumId,
    this.albumName,
    this.artistId,
    this.artistName,
    this.restricted,
  });

  int? trackId;
  String? trackName;
  int? trackRating;
  int? commontrackId;
  int? instrumental;
  int explicit;
  int? hasLyrics;
  int? hasSubtitles;
  int? hasRichsync;
  int? numFavourite;
  int? albumId;
  String? albumName;
  int? artistId;
  String? artistName;
  int? restricted;

  factory MusicModel.fromMap(Map<String, dynamic> json) => MusicModel(
        trackId: json["track_id"],
        trackName: json["track_name"],
        trackRating: json["track_rating"],
        commontrackId: json["commontrack_id"],
        instrumental: json["instrumental"],
        explicit: json["explicit"],
        hasLyrics: json["has_lyrics"],
        hasSubtitles: json["has_subtitles"],
        hasRichsync: json["has_richsync"],
        numFavourite: json["num_favourite"],
        albumId: json["album_id"],
        albumName: json["album_name"],
        artistId: json["artist_id"],
        artistName: json["artist_name"],
        restricted: json["restricted"],
      );

  Map<String, dynamic> toMap() => {
        "track_id": trackId,
        "track_name": trackName,
        "track_rating": trackRating,
        "commontrack_id": commontrackId,
        "instrumental": instrumental,
        "explicit": explicit,
        "has_lyrics": hasLyrics,
        "has_subtitles": hasSubtitles,
        "has_richsync": hasRichsync,
        "num_favourite": numFavourite,
        "album_id": albumId,
        "album_name": albumName,
        "artist_id": artistId,
        "artist_name": artistName,
        "restricted": restricted,
      };
}
