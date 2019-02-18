import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observable_state/observable_state.dart';

enum Changes {
  willIncrement,
  doneIncrement,
}

class State extends Observable<State, Changes> {
  int _counter = 0;
  int get counter => _counter;

  bool _loading = false;
  bool get loading => _loading;

  Future<bool> initState() async {
    await Future.delayed(const Duration(seconds: 2));
    _counter = 1;
    return true;
  }

  Future<void> increment() async {
    setState(() {
      _loading = true;
    }, notify: Changes.willIncrement);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _loading = false;
      _counter++;
    }, notify: Changes.doneIncrement);
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key key, @required this.state}) : super(key: key);

  final State state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: state.initState(),
        initialData: false,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || !snapshot.data) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return HomePage();
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateObserver<HomePage, State, Changes> {
  @override
  List<Changes> get subjects => [
        Changes.willIncrement,
        Changes.doneIncrement,
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(state.counter.toString())),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Incrementing...')));

            await state.increment();

            Scaffold.of(context).hideCurrentSnackBar();
          },
        );
      }),
    );
  }
}

void main() {
  final initialState = State();

  testWidgets('Async', (tester) async {
    await tester.pumpWidget(ObservableProvider(initialState,
        child: TestWidget(state: initialState)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Incrementing...'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });
}
