import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lyrics_app/music_bloc/api_helper.dart';
import 'package:lyrics_app/music_bloc/music_model.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicListLoading()) {
    on<LoadMusicListEvent>(_onLoadMusicList);
  }
}

void _onLoadMusicList(
    LoadMusicListEvent event, Emitter<MusicState> emit) async {
  emit(MusicListLoading());

//* Emits events from Stream one by one, as the API logic
//* takes a long time to get details of all tracks together.
  await for (var e in getTrackStream()) {
    emit(MusicListLoaded(newMusic: e, length: e.length));
  }
}
