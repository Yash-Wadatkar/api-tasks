// states of post screen

sealed class PostScreenState {}

/// post screen initial state
class PostScreenInitialState extends PostScreenState {}

/// listner state for post screen

final class PostScreenListnerState extends PostScreenState {}

/// post data state

final class PostDataState extends PostScreenListnerState {}

/// loading state

class LoadingState extends PostScreenState {}

/// post data success state
final class PostDataSuccessState extends PostScreenListnerState {}

/// error state
final class ErrorState extends PostScreenListnerState {
  final String error;
  ErrorState({required this.error});
}
