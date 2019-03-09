import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

import 'state.dart';

void main() {
  final initialState = AppState(
    title: 'GitHub Search',
  );

  runApp(
    ObservableProvider(
      state: initialState,
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: observableStateOf<AppState>(context).title,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(observableStateOf<AppState>(context).title)),
        body: Column(
          children: <Widget>[
            _SearchField(),
            ObserverBuilder<AppState, Changes>(
              changes: [
                Changes.searchResults,
                Changes.searchError,
              ],
              builder: (context, state) {
                if (state.searchError != null || state.results == null) {
                  return Center(child: Text(state.searchError));
                }

                return Expanded(
                  child: _SearchResults(results: state.results),
                );
              },
            )
          ],
        ));
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
      onChanged: (term) {
        bind<AppState>(context, (state) => state.search(term))();
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List results;

  const _SearchResults({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final repo = results.elementAt(index);

        return ListTile(
          key: ValueKey(index),
          title: Text(repo['full_name']),
        );
      },
    );
  }
}
