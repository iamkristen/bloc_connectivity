import 'package:bloc_practice/bloc/internet_bloc.dart';
import 'package:bloc_practice/bloc/internet_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bloc Practice",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: BlocConsumer<InternetBloc, InternetStates>(
          listener: (context, state) {
            if (state is InternetBackStates) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Online",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
            } else if (state is InternetLostStates) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Offline",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            } else {
              const Text("Loading");
            }
          },
          builder: (context, state) {
            if (state is InternetBackStates) {
              return const Text("Online");
            } else if (state is InternetLostStates) {
              return const Text("Offline");
            } else {
              return const Text("Loading");
            }
          },
        ),
      ),
    );
  }
}
