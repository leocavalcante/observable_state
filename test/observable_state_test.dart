import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observable_state/observable_state.dart';

enum Changes {
  increment,
}

class MyState extends Observable<Changes> {
  MyState({int counter = 0}) : _counter = counter;

  int _counter;
  int get counter => _counter;

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends StateObserver<TestWidget, MyState, Changes> {
  @override
  List<Changes> get changes => [Changes.increment];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Text(state.counter.toString()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: state.increment,
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Counter example', (tester) async {
    await tester.pumpWidget(ObservableProvider(
      state: MyState(),
      child: TestWidget(),
    ));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
