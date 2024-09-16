import 'dart:async';

import 'package:api_tasks/model/news_data_model.dart';
import 'package:api_tasks/repository/api_service.dart';
import 'package:api_tasks/screens/home_screen/bloc/event.dart';
import 'package:api_tasks/screens/home_screen/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;

  HomeBloc(this.apiService) : super(InitialState()) {
    /// Event handler for fetching API data
    on<FetchApiDataEvent>(fetchApiDataEvent);

    /// event handler to move to next screen
    on<MoveToNextScreenEvent>(moveToNextScreenEvent);
  }

  FutureOr<void> fetchApiDataEvent(
      FetchApiDataEvent event, Emitter<HomeScreenState> emit) async {
    emit(LoadingState());
    try {
      final dynamic response = await apiService.getNews(); // get the news data
      final ArticleResponse articleResponse =
          ArticleResponse.fromJson(response);

      emit(
          DataSuccessfullyFetchedState(newsDataList: articleResponse.articles));
    } catch (e) {
      emit(ErroState(error: e.toString()));
    }
  }

  FutureOr<void> moveToNextScreenEvent(
      MoveToNextScreenEvent event, Emitter<HomeScreenState> emit) {
    emit(MoveToNextScreenState());
  }
}
