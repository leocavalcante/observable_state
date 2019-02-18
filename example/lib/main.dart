import 'package:example/app.dart';
import 'package:example/app_state.dart';
import 'package:example/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

void main() {
  final service = FirebaseService(firebaseAuth: FirebaseAuth.instance);
  final initialState = AppState(service: service);

  runApp(ObservableProvider(
    initialState,
    child: App(),
  ));
}
