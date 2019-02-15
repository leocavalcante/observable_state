# observable_state
🔭 Observable State: Yet Another Flutter's State Manager.

## But this time
- State mutations are handled by OO Encapsulation Principle on Plain-old objects.
- You can freely Unit Test your State and its Mutations, like pure Dart (because **is is** pure Dart).
- Keep track of every State Change using an Enum.
- Notify only the specific States that are Observing the triggered Change, **not** the entire Widget tree.
- Actually, *observable_state* does not mess with Widgets, it's about the State. Stateless are kept Stateless.
- No Streams or new Widgets, it is purely State and setState, like Vanilla, but :zap: **Reactive!**

## How it works
