import 'package:api_tasks/repository/api_service.dart';
import 'package:api_tasks/screens/home_screen/bloc/bloc.dart';
import 'package:api_tasks/screens/home_screen/bloc/event.dart';
import 'package:api_tasks/screens/home_screen/bloc/state.dart';
import 'package:api_tasks/screens/post_data_screen/pages/post_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenBloc = HomeBloc(ApiService());

  @override
  void initState() {
    super.initState();
    homeScreenBloc.add(FetchApiDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocConsumer<HomeBloc, HomeScreenState>(
        bloc: homeScreenBloc,
        buildWhen: (previous, current) => current is! HomeScreenListnerState,
        listenWhen: (previous, current) => current is HomeScreenListnerState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case MoveToNextScreenState:
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PostDataScreen();
                },
              ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return const Center(child: CircularProgressIndicator());

            case DataSuccessfullyFetchedState:
              final dataFetchedState = state as DataSuccessfullyFetchedState;

              return ListView.builder(
                itemCount: dataFetchedState.newsDataList.length,
                itemBuilder: (context, index) {
                  final article = dataFetchedState.newsDataList[index];
                  return ListTile(
                    leading: article.urlToImage != null &&
                            article.urlToImage.isNotEmpty
                        ? Image.network(article.urlToImage,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.browse_gallery),
                    title: Text(
                      article.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      article.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              );

            case ErroState:
              final errorState = state as ErroState;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${errorState.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        homeScreenBloc
                            .add(FetchApiDataEvent()); // Retry fetching data
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            default:
              return const Center(child: Text('Something went wrong'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          homeScreenBloc.add(MoveToNextScreenEvent());
        },
      ),
    );
  }
}
