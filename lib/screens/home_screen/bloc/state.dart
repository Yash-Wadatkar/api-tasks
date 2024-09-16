// states of home screen

sealed class HomeScreenState {}

/// initial state of home Screen

class InitialState extends HomeScreenState {}

/// loading state
class LoadingState extends HomeScreenState {}

/// data successfully fetched state

class DataSuccessfullyFetchedState extends HomeScreenState {
  final List newsDataList;

  DataSuccessfullyFetchedState({required this.newsDataList});
}

/// error state
class ErroState extends HomeScreenState {
  final String error;

  ErroState({required this.error});
}

/// listner state
final class HomeScreenListnerState extends HomeScreenState {}

/// move to next screen state
final class MoveToNextScreenState extends HomeScreenListnerState {}
