import 'package:example/app.dart';
import 'package:example/app_state.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

void main() {
  final initialState = AppState();

  runApp(ObservableProvider(
    initialState,
    child: App(),
  ));
}
