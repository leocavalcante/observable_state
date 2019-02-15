import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';
import 'package:observable_state_example/state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ObservableState<HomePage, MyState, Changes> {
  @override
  List<Changes> get changes => [Changes.increment];

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
          state.increment();
        },
      ),
    );
  }
}
