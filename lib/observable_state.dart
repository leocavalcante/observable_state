/// Flutter's State Manager for Reactive Apps in a Centralized and Predictable container.
library observable_state;

import 'package:flutter/widgets.dart';

part 'src/observable_binds.dart';
part 'src/observable_provider.dart';
part 'src/observable.dart';
part 'src/observer_builder.dart';
part 'src/observer.dart';
part 'src/state_observer.dart';

/// A [WidgetBuilder] aware about the state.
typedef Widget ObservableWidgetBuilder<S extends Observable>(
    BuildContext context, S state);
