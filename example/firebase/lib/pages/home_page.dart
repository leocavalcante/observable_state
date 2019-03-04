import 'package:firebase/app_state.dart';
import 'package:firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.offline_bolt),
            onPressed: () {
              bind<MyState>(context, (state) => state.logout());
              Navigator.of(context).pushReplacementNamed(routeNameLogin);
            },
          ),
        ],
      ),
      body: Center(
        child: ObserverBuilder<MyState, Changes>(
          builder: (context, state) {
            return Text(state.user.email ?? 'No user');
          },
        ),
      ),
    );
  }
}
