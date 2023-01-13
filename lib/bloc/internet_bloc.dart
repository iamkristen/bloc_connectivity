import 'dart:async';

import 'package:bloc_practice/bloc/internet_events.dart';
import 'package:bloc_practice/bloc/internet_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvents, InternetStates> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialStates()) {
    on<InternetLostEvents>((event, emit) => emit(InternetLostStates()));
    on<InternetBackEvents>((event, emit) => emit(InternetBackStates()));

    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(InternetBackEvents());
      } else {
        add(InternetLostEvents());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
