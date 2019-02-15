# observable_state
🔭 Observable State: Yet Another Flutter's State Manager.

## But this time
- State mutations are handled by OO Encapsulation Principle on Plain-old objects.
- You can freely Unit Test your State and its Mutations, like pure Dart (because **it is** pure Dart).
- Keep track of every State Change using an Enum, simple like that.
- Notify only the specific States that are Observing the triggered Change, **NOT** the entire Widget tree.
- Actually, *observable_state* does not mess with Widgets, it's all about the State. Stateless are kept Stateless.
- No Streams or new Widgets, it is purely State and setState, like Vanilla, but :zap: **Reactive!**

## How it works
It's a sweet, sweet sugar on top of the battle-tested Observer pattern. Your State is stored in a List of Observables in a given Subject (Change) and it's `setState()` is called only when your Model explicity tells to notify about that Change.
- It is no BLoC, but you still can maitain, test and visualize your Business Logic away from the UI.
- It is no Flux **(Redux/Rx/Stream)**, but you still can control data in an unidirectional flow.
