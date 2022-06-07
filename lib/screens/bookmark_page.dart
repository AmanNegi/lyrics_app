import 'package:flutter/material.dart';
import 'package:lyrics_app/local_data.dart';

import 'detail_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Bookmarks"),
          elevation: 0,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: localData.getMusicList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text("Error"));
              }
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No items Bookmarked"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var e = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(
                          localRequest: true,
                          trackId: e['track_id'],
                        ),
                      ));
                    },
                    leading: const Icon(Icons.music_note),
                    title: Text(e['track_name']),
                    subtitle: Text("Id: ${e["track_id"]}"),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
