import 'dart:convert';

import 'package:observable_state/observable_state.dart';
import 'package:http/http.dart' as http;

enum Changes {
  searchResults,
  searchError,
}

class AppState extends Observable<Changes> {
  AppState({String title}) {
    _title = title;
  }

  String _title;
  String get title => _title;

  List _results = [];
  List get results => _results;

  String _searchError;
  String get searchError => _searchError;

  void search(String term) {
    http
        .get('https://api.github.com/search/repositories?q=$term')
        .then((response) => json.decode(response.body))
        .then((data) {
      if (data['items'] == null) {
        return setState(() {
          _searchError = data['message'];
          _results = null;
        }, notify: Changes.searchError);
      }

      setState(() {
        _results = data['items'];
        _searchError = null;
      }, notify: Changes.searchResults);
    });
  }
}
