// events of home screen
sealed class HomeScreenEvent {}

/// fetched api data event
class FetchApiDataEvent extends HomeScreenEvent {}

/// move to next screen event
class MoveToNextScreenEvent extends HomeScreenEvent {}
