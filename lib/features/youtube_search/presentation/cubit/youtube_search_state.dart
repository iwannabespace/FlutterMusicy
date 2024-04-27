part of 'youtube_search_cubit.dart';

abstract class YoutubeSearchState extends Equatable {
  const YoutubeSearchState();

  @override
  List<Object> get props => [];
}

class YoutubeSearchInitial extends YoutubeSearchState {}

class YoutubeSearching extends YoutubeSearchState {}

class YoutubeSearched extends YoutubeSearchState {
  final YoutubeSearchResult youtubeSearchResult;
  const YoutubeSearched({required this.youtubeSearchResult});

  @override
  List<Object> get props => [youtubeSearchResult];
}

class YoutubeSearchFailed extends YoutubeSearchState {
  final String errorMessage;
  const YoutubeSearchFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
