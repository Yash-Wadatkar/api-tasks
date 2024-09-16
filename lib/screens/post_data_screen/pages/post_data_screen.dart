import 'package:api_tasks/repository/api_service.dart';
import 'package:api_tasks/screens/post_data_screen/bloc/event.dart';
import 'package:api_tasks/screens/post_data_screen/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_tasks/screens/post_data_screen/bloc/bloc.dart'; // Import your BLoC and state files

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({super.key});

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  final postScreenBloc = PostDataScreenBloc(ApiService());
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _salary = '';
  String _age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Data Screen')),
      body: BlocConsumer(
        bloc: postScreenBloc,
        buildWhen: (previous, current) => current is! PostScreenListnerState,
        listenWhen: (previous, current) => current is PostScreenListnerState,
        listener: (context, state) {
          if (state is PostDataSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data posted successfully!')),
            );
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostScreenInitialState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Name', border: OutlineInputBorder()),
                      onChanged: (value) {
                        _name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Salary', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _salary = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a salary';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Age', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _age = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Call your BLoC event to post data
                          postScreenBloc.add(
                            SubmitButtonClickedEvent(
                                age: _age, name: _name, sallary: _salary),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
