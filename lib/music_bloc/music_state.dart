part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicListLoading extends MusicState {}

class MusicListLoaded extends MusicState {
  final List<MusicModel> newMusic;
  final int length;
  MusicListLoaded({this.newMusic = const [], this.length = 0});

  @override
  List<Object> get props => [newMusic, length];
}

class MusicListLoadComplete extends MusicState {}
