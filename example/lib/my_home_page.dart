import 'package:flutter/material.dart';
import 'package:observable_state_example/my_state.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends MyState<MyHomePage> {
  @override
  List<Type> get observing => [Increment];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Counter: ${state.counter}')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          mutate(Increment());
        },
      ),
    );
  }
}
