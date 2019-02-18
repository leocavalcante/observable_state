import 'package:example/app_state.dart';
import 'package:example/routes.dart';
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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.offline_bolt),
            onPressed: () {
              state.logout();
              Navigator.of(context).pushReplacementNamed(routeNameLogin);
            },
          )
        ],
      ),
      body: Center(
        child: Text('Homepage'),
      ),
    );
  }
}
