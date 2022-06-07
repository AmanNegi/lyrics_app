import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyrics_app/screens/bookmark_page.dart';
import 'package:lyrics_app/screens/detail_page.dart';

import '../music_bloc/music_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    //* Dispatch the event to notify the BLoC to load data
    BlocProvider.of<MusicBloc>(context).add(const LoadMusicListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Trending"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BookmarkPage(),
            ),
          );
        },
        child: const Icon(Icons.bookmark_added_sharp),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          debugPrint(state.toString());

          //* Provide different Widgets for different cases
          if (state is MusicListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MusicListLoaded) {
            return _getTracksList(state);
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  ListView _getTracksList(MusicListLoaded state) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      itemBuilder: (context, index) {
        var e = state.newMusic[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPage(
                musicModel: e,
                trackId: e.trackId.toString(),
              ),
            ));
          },
          isThreeLine: true,
          leading: const Icon(Icons.library_music_rounded),
          title: Text(e.trackName ?? "", maxLines: 2),
          subtitle: Text(e.albumName ?? "", maxLines: 2),
          trailing: SizedBox(
            width: 0.2 * MediaQuery.of(context).size.width,
            child: SizedBox(
              child: Text(
                e.artistName ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
      itemCount: state.newMusic.length,
    );
  }
}
