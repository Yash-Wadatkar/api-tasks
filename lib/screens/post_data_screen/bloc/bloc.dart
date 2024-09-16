import 'dart:async';

import 'package:api_tasks/repository/api_service.dart';
import 'package:api_tasks/screens/post_data_screen/bloc/event.dart';
import 'package:api_tasks/screens/post_data_screen/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDataScreenBloc extends Bloc<PostScreenEvent, PostScreenState> {
  final ApiService apiService;
  PostDataScreenBloc(this.apiService) : super(PostScreenInitialState()) {
    /// event handler for submit button clicked event
    on<SubmitButtonClickedEvent>(submitButtonClickedEvent);
  }

  Future<void> submitButtonClickedEvent(
      SubmitButtonClickedEvent event, Emitter<PostScreenState> emit) async {
    emit(LoadingState());
    try {
      final response = await apiService.createEmployee(
          age: event.age, name: event.name, salary: event.sallary);
      if (response != null) {
        emit(PostDataSuccessState());
        emit(PostScreenInitialState());
      } else {
        emit(ErrorState(error: 'No response from server'));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
