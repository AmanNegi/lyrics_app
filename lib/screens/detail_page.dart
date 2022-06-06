import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyrics_app/music_bloc/api_helper.dart';
import 'package:lyrics_app/music_bloc/music_bloc.dart';
import 'package:lyrics_app/music_bloc/music_model.dart';

class DetailPage extends StatefulWidget {
  final MusicModel musicModel;
  const DetailPage({Key? key, required this.musicModel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Track Details"),
      ),
      body: ListView(
        children: [
          _getElement("Name", widget.musicModel.trackName),
          _getElement("Artist", widget.musicModel.artistName),
          _getElement("Album Name", widget.musicModel.albumName),
          _getElement(
              "Explicit", widget.musicModel.explicit == 1 ? "True" : "False"),
          _getElement("Rating", widget.musicModel.trackRating.toString()),
          FutureBuilder(
            future: getLyrics(widget.musicModel.trackId.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("Lyrics not available");
                }
                return _getElement("Lyrics", snapshot.data.toString());
              } else if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text("An error occured");
              }
            },
          )
        ],
      ),
    );
  }

  _getElement(String title, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(data ?? ""),
        ],
      ),
    );
  }
}
