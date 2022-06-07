import 'package:flutter/material.dart';
import 'package:lyrics_app/local_data.dart';
import 'package:lyrics_app/music_bloc/music_model.dart';

class BookmarkWidget extends StatefulWidget {
  const BookmarkWidget({
    Key? key,
    required this.musicModel,
    required this.trackId,
  }) : super(key: key);

  final MusicModel musicModel;
  final String trackId;

  @override
  State<BookmarkWidget> createState() => _BookmarkWidgetState();
}

class _BookmarkWidgetState extends State<BookmarkWidget> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    localData.doesMusicExist(widget.trackId).then((v) {
      isBookmarked = v;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isBookmarked) {
          _showSnackBar("This track is already bookmarked");
          return;
        }
        localData.addMusic(widget.trackId, widget.musicModel.trackName ?? "");
        isBookmarked = true;
        _showSnackBar("Bookmarked track successfully!");
        setState(() {});
      },
      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_outline),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1, milliseconds: 500),
    ));
  }
}
