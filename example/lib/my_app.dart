import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';
import 'package:observable_state_example/my_home_page.dart';
import 'package:observable_state_example/my_state.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ObservableProvider(
      state: MyProps(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.pink),
        home: MyHomePage(),
      ),
    );
  }
}
