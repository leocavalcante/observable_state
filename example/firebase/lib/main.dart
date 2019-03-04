import 'package:firebase/app.dart';
import 'package:firebase/app_state.dart';
import 'package:firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

void main() {
  final service = FirebaseService(firebaseAuth: FirebaseAuth.instance);
  final initialState = MyState(service: service);

  runApp(
    ObservableProvider(
      state: initialState,
      child: App(),
    ),
  );
}
