import 'package:flutter/material.dart';
import 'package:lyrics_app/music_bloc/api_helper.dart';
import 'package:lyrics_app/music_bloc/music_model.dart';
import 'package:lyrics_app/widgets/bookmark_widget.dart';

class DetailPage extends StatefulWidget {
  //* Receive Data from constructor to check navigated from which page
  final MusicModel? musicModel;
  final bool localRequest;
  final String trackId;

  const DetailPage({
    Key? key,
    this.musicModel,
    this.localRequest = false,
    this.trackId = "",
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late MusicModel musicModel;
  bool isLoading = false;
  @override
  void initState() {
    //* If local request, request data from API and load
    if (widget.localRequest) {
      isLoading = true;
      getMusicDetailsFromId(widget.trackId).then((value) {
        musicModel = value;
        isLoading = false;
        if (mounted) setState(() {});
      });
    }
    // * If From HomePage, simply get the musicModel from parent
    else {
      musicModel = widget.musicModel!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Track Details"),
        actions: [
          isLoading
              ? Container()
              : BookmarkWidget(
                  musicModel: musicModel,
                  trackId: widget.trackId,
                ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                _getTrackDetail(musicModel),
                _getLyricsWidget(widget.trackId),
              ],
            ),
    );
  }

  Widget _getTrackDetail(MusicModel musicModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getElement("Name", musicModel.trackName),
        _getElement("Artist", musicModel.artistName),
        _getElement("Album Name", musicModel.albumName),
        _getElement("Explicit", musicModel.explicit == 1 ? "True" : "False"),
        _getElement("Rating", musicModel.trackRating.toString()),
      ],
    );
  }

  Widget _getLyricsWidget(String trackId) {
    //* Using FutureBuilder to get lyrics from the server
    return FutureBuilder(
      future: getLyrics(trackId),
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
          return const Text("An error occured");
        }
      },
    );
  }

  _getElement(String title, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(data ?? ""),
        ],
      ),
    );
  }
}
