import 'package:flutter/material.dart';
import 'package:observable_state_example/state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MyState<HomePage> {
  @override
  List<Type> get observing => [Increment];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observable state #${state.counter}'),
      ),
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
