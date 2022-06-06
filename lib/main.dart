import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyrics_app/music_bloc/music_bloc.dart';
import 'package:lyrics_app/network_bloc/network_bloc.dart';
import 'package:lyrics_app/screens/home_page.dart';

import 'screens/error_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NetworkBloc()..add(ListenConnection())),
        BlocProvider(create: (context) => MusicBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkSuccess)
              return HomePage();
            else
              return ErrorPage();
          },
        ),
      ),
    );
  }
}
