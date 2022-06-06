part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicListLoading extends MusicState {}

class MusicListLoaded extends MusicState {
  final List<MusicModel> music;

  const MusicListLoaded({this.music = const []});

  @override
  List<Object> get props => music;
}

