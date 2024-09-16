// events of post screen state
sealed class PostScreenEvent {}

// submit button clicked event
class SubmitButtonClickedEvent extends PostScreenEvent {
  final String name;
  final String age;
  final String sallary;

  SubmitButtonClickedEvent(
      {required this.name, required this.age, required this.sallary});
}
