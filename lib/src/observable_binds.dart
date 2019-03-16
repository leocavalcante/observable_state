part of observable_state;

/// Calls the update function passing the current [Observable]
/// from the [ObservableProvider] [context].
void Function() bind<O extends Observable>(
    BuildContext context, void update(O state)) {
  return () {
    update(ObservableProvider.of<O>(context).state);
  };
}

/// Builds a [Widget] aware about the observable state.
Widget bindWidget<O extends Observable>(
    BuildContext context, Widget builder(O state)) {
  return builder(ObservableProvider.of<O>(context).state);
}
