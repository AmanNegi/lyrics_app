part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class LoadMusicListEvent extends MusicEvent {
  final List<MusicModel> music;

  const LoadMusicListEvent({this.music = const []});
}

