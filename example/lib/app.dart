import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';
import 'package:observable_state_example/bootstrap.dart';
import 'package:observable_state_example/di.dart';
import 'package:observable_state_example/home_page.dart';
import 'package:observable_state_example/routes.dart';
import 'package:observable_state_example/service_impl.dart';
import 'package:observable_state_example/state.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DI(
      service: ServiceImpl(),
      child: ObservableProvider(
        state: Props(),
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.pink),
          onGenerateRoute: (settings) {
            if (settings.isInitialRoute) {
              return MaterialPageRoute(builder: (context) => Bootstrap());
            }

            if (settings.name == homePage) {
              return new MaterialPageRoute(builder: (context) => HomePage());
            }
          },
        ),
      ),
    );
  }
}
