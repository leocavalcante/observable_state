import 'package:example/app_state.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/pages/login_page.dart';
import 'package:example/routes.dart';
import 'package:example/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends StateObserver<App, AppState, Changes> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Observable State Example',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      onGenerateRoute: (settings) {
        if (settings.isInitialRoute) {
          return new MaterialPageRoute(builder: (context) {
            state.initState().then((_) {
              Navigator.of(context).pushReplacementNamed(state.initialRoute);
            });

            return SplashScreen();
          });
        }

        if (settings.name == routeNameLogin) {
          return new MaterialPageRoute(builder: (context) {
            return LoginPage();
          });
        }

        if (settings.name == routeNameHome) {
          return MaterialPageRoute(builder: (context) {
            return HomePage();
          });
        }
      },
    );
  }
}
