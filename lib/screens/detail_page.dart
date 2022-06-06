import 'package:flutter/material.dart';
import 'package:lyrics_app/bloc/music_model.dart';

class DetailPage extends StatefulWidget {
  final MusicModel musicModel;
  const DetailPage({Key? key, required this.musicModel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Details"),
      ),
      body: ListView(
        children: [
          _getElement("Name", widget.musicModel.trackName),
          _getElement("Artist", widget.musicModel.artistName),
          _getElement("Album Name", widget.musicModel.albumName),
          _getElement(
              "Explicit", widget.musicModel.explicit == 1 ? "True" : "False"),
          _getElement("Rating", widget.musicModel.trackRating.toString()),

          
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
          Text(data ?? ""),
        ],
      ),
    );
  }
}
