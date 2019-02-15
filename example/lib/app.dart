import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';
import 'package:observable_state_example/home_page.dart';
import 'package:observable_state_example/routes.dart';
import 'package:observable_state_example/splash_screen.dart';
import 'package:observable_state_example/state.dart';

class App extends StatelessWidget {
  const App({Key key, this.state}) : super(key: key);

  final MyState state;

  @override
  Widget build(BuildContext context) {
    return ObservableProvider(
      state,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink),
        onGenerateRoute: (settings) {
          if (settings.isInitialRoute) {
            return MaterialPageRoute(builder: (context) {
              state.initState().then((_) =>
                  Navigator.pushReplacementNamed(context, kRouteHomePage));

              return SplashScreen();
            });
          }

          if (settings.name == kRouteHomePage) {
            return new MaterialPageRoute(builder: (context) => HomePage());
          }
        },
      ),
    );
  }
}
