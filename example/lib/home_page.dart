import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';
import 'package:observable_state_example/state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ObservableState<HomePage, MyState, Changes> {
  @override
  List<Changes> get changes => [
        Changes.increment,
        Changes.doneAsyncIncrement,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observable state #${state.counter}'),
      ),
      body: Center(child: Text('Counter: ${state.counter}')),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Incrementing'),
                        ),
                      )
                    ],
                  ),
                ),
              );

              await state.asyncIncrement();

              Scaffold.of(context).hideCurrentSnackBar();
            },
          );
        },
      ),
    );
  }
}
