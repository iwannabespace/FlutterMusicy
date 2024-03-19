part of 'music_cubit.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

class MusicsLoading extends MusicState {}

class MusicDownloading extends MusicState {}

class MusicDownloaded extends MusicState {}

class MusicsLoaded extends MusicState {
  final List<Music> musics;
  const MusicsLoaded({required this.musics});

  @override
  List<Object> get props => [musics];
}

class MusicConversionCancelled extends MusicState {
  final String errorMessage;
  const MusicConversionCancelled(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class MusicConversionFailed extends MusicState {
  final String errorMessage;
  const MusicConversionFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class MusicError extends MusicState {
  final String errorMessage;
  const MusicError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
