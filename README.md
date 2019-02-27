# Observable state [![Pub](https://img.shields.io/pub/v/observable_state.svg)](https://pub.dartlang.org/packages/observable_state) [![Build Status](https://api.cirrus-ci.com/github/leocavalcante/observable_state.svg)](https://cirrus-ci.com/github/leocavalcante/observable_state)

Flutter's State Manager for Reactive Apps in a Centralized and Predictable container.

#### [Using React? Check out!](https://github.com/leocavalcante/observable-state)

## But this time

- 🧰 State changes are handled using [encapsulation](https://martinfowler.com/bliki/TellDontAsk.html) on plain-old objects.
- ✔️ You can freely test your state and its changes, like pure Dart; because **IT IS** pure Dart.
- 🎯 Notify only the specific `State`s that are observing the triggered change, **NOT** the entire Widget tree.
- 💧 No Streams or new Widgets, it is purely `State` and `setState()`; like Vanilla, but in a **Centralized** and **Predictable** state container. **Your Container!**

## How it works

It's a sweet, sweet sugar on top of the battle-tested **Observer pattern.** Your state is stored in a list of `Observable`s of a given subject (see `Change` below) and it's `setState()` is called only when your Model explicit tells to notify about that change.

- **It _isn't_ BLoC**, but you still can maintain, test and visualize your Business Logic away from the UI.
- **It _isn't_ Flux** *(Redux/Rx/Stream)*, but you still can control data in an unidirectional flow.

## Get started

The fact is: **state is hard!** Probably the hardest thing (after naming, of course). This is why things like BLoC, Flux/Redux and ScopedModel appears; to help you solve that.

And that is why **observable_state** is here too.

> Talk is cheap. Show me the code &mdash; <cite>Torvalds, Linus</cite>

### Installing

```yaml
dependencies:
  observable_state: ^0.1.0
```

### State modeling

```dart
class MyState {
  int counter;
}
```

From a simple model like that, to add **observable_state** super-powers you just need to:

```dart
class MyState extends Observable<Changes> {
  int counter;
}
```

Then make sure you declare what changes to your state are:

```dart
enum Changes {
  increment,
}
```

Even better, remember that [changes are handled by encapsulation](https://martinfowler.com/bliki/TellDontAsk.html):

```dart
enum Changes {
  increment,
}

class MyState extends Observable<Changes> {
  int _counter;
  int get counter => _counter;

  void increment() {
    _counter++;
  }
}
```

### How to notify about the `increment` change?

*Observable state* borrows the same Flutter API for local state (`setState()`) with a slight difference: the `notify` argument:

```dart
enum Changes {
  increment,
}

class MyState extends Observable<Changes> {
  int _counter;
  int get counter => _counter;

  void increment() {
    setState(
      () => _counter++,
      notify: Changes.increment,
    );
  }
}
```

That is it. Your `Observable` is notifying about `MyState` changes.

### How to listen to then?

**Here comes the `StateObserver`**.

`StatelessWidget`s are state-less as the name suggests. We are not going to mess with them adding Streams or whatever. Actually, even the `StatefulWidget` remains the same. We are going to **super-power** the `State` only!

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends StateObserver<MyStatefulWidget, MyState, Changes> {
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

Note that we are extending `StateObserver` instead of `State` and we are given a list of changes we are interest in, like `Changes.increment`.
`StateObserver` already got the `state` so we can get `counter` and we can call `increment()` on it as well.
Whenever `increment()` is called, since it notifies about `Changes.increment`, whoever `Observer` (like a `StateObserver`) is observing this change, it will automatically calls its inner `setState()` method, then rebuilding it.

### Where does the `state` comes from?

The last piece: `ObservableProvider`.

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ObservableProvider(
      state: MyState(),
      child: MaterialApp(home: MyStatefulWidget()),
    );
  }
}
```

It's an `InheritedWidget` responsible to provide our state from its context.

**That is it! You're ready to Rock! 🎸**

`Observable` has no dependency at all with any Flutter APIs, so you can unit test your state using plain-old `test` package. And you can test your Widgets using a mock or a real state without any hassle.

Check out the [example directory](example) for a complete example with async-flows, services, dependency injection, Firebase integration and a lot more!

*****

Feel free to, and I'd be glad if you, try it and leave some feedback. Just be aware that while on early stages, API may change.
