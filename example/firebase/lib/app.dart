import 'package:firebase/app_state.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:firebase/routes.dart';
import 'package:firebase/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends StateObserver<App, MyState, Changes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          return MaterialPageRoute(builder: (context) {
            state.initState().then((_) {
              Navigator.of(context).pushReplacementNamed(state.initialRoute);
            });

            return SplashScreen();
          });
        }

        if (settings.name == routeNameLogin) {
          return MaterialPageRoute(builder: (context) {
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
