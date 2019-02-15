# 🔭 Observable state ![https://pub.dartlang.org/packages/observable_state](https://img.shields.io/pub/v/observable_state.svg?style=flat-square)
Yet Another Flutter State Manager for a Reactive Application Architecture.

## But this time
- State mutations are handled by OO Encapsulation Principle on Plain-old objects.
- You can freely Unit Test your State and its Mutations, like pure Dart (because **it is** pure Dart).
- Keep track of every State Change using an Enum, simple like that.
- Notify only the specific States that are Observing the triggered Change, **NOT** the entire Widget tree.
- Actually, *observable_state* does not mess with Widgets, it's all about the State. Stateless are kept Stateless.
- No Streams or new Widgets, it is purely `State` and `setState()`, like Vanilla, but :zap: **Reactive!**

## How it works
It's a sweet, sweet sugar on top of the battle-tested **Observer pattern.** Your State is stored in a List of Observables in a given Subject (Change) and it's `setState()` is called only when your Model explicit tells to notify about that Change.
- **It is not BLoC**, but you still can maintain, test and visualize your Business Logic away from the UI.
- **It is not Flux** *(Redux/Rx/Stream)*, but you still can control data in an unidirectional flow.

## Usage guide (Get started)
The fact is: **state is hard!** Probably the hardest thing (after naming, of course). This is why things like BLoC, Flux/Redux and ScopedModel appears; to help you solve that.

And that is why **observable_state** is here too.

> Talk is cheap. Show me the code &mdash; <cite>Torvalds, Linus</cite>

### Installing
```yaml
dependencies:
  observable_state: ^0.0.1
```

### State modeling
```dart
class MyState {
  int counter;
}
```
From a simple model like that, to add **observable_state** super-powers you just need to:
```dart
class MyState extends ObservableModel<MyState, Changes> {
  int counter;
}
```
Then make sure you declare what changes to your Model are:
```dart
enum Changes {
  increment,
}
```
Even better, remember that [Mutations are handled by the OO Encapsulation Principle](https://martinfowler.com/bliki/TellDontAsk.html), so:
```dart
enum Changes {
  increment,
}

class MyState extends ObservableModel<MyState, Changes> {
  int _counter;
  int get counter => _counter;

  void increment() {
    _counter++;
  }
}
```

### Ok, cool, but how to notify about the `increment` Change?
Well, how Flutter does it with local state? With the `setState()` method, right? *observable_state* borrows the same API, but with a little difference: the `notify` argument to notify States listening to this change!
```dart
enum Changes {
  increment,
}

class MyState extends ObservableModel<MyState, Changes> {
  int _counter;
  int get counter => _counter;

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }
}
```
That is it. Your `ObservableModel` is notifying about State changes.

### How to listen to then?

**Here comes the `ObservableState`**.

Remember: `StatelessWiget`s are state-less as the name suggests. We are not going to mess with them adding Streams or whatever. Actually, even the `StatefulWidget` remains the same. We are going to **super-power** the `State`!

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends ObservableState<MyStatefulWidget, MyState, Changes> {
  @override
  List<Changes> get changes => [Changes.increment];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Observable state #${state.counter}')),
      body: Center(child: Text('Counter: ${state.counter}')),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              state.increment();
            },
          );
        },
      ),
    );
  }
}
```

Notice that we are extending `ObservableState` instead of `State` and we are given a list of Changes we are interest in, like `Changes.increment`.
`ObservableState` already got the `state` so we can get `counter` and we can call `increment()` on it as well.
Wherever `increment()` is called, since it notifies about `Changes.increment`, whoever `Observable` is observing this change, it will automatically calls its inner `setState()` method, then rebuilding it.

### Where does the `state` comes from?

The last piece: `ObservableProvider`.

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ObservableProvider(
      MyState(),
      child: MaterialApp(home: MyStatefulWidget()),
    );
  }
}
```

It's an InheritedWidget responsible to instantiate your initial State and handle it on its Context.

**That is it! You're ready to Rock! 🎸**

`ObservableModel` has no dependency at all with any Flutter APIs, so you can Unit test your Model using Plain-old `test` package. And you can test your Widgets using a Mock or a real state without any hassle.

⚠️ For now, use with caution, API may change.

---
&copy; 2019
