import 'package:example/app_state.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateObserver<HomePage, AppState, Changes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Homepage'),
      ),
    );
  }
}
