import 'package:firebase/app_state.dart';
import 'package:firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateObserver<LoginPage, MyState, Changes> {
  TextEditingController _email;
  TextEditingController _password;
  FocusNode _passwordFocus;
  String _error;

  void _doLogin(BuildContext context) async {
    setState(() => _error = null);

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Login...'),
              ),
            ),
          ],
        ),
      ),
    );

    final user = await state.login(_email.text, _password.text);

    Scaffold.of(context).hideCurrentSnackBar();

    if (user == null) {
      return setState(() {
        _error = 'Invalid email or password';
      });
    }

    Navigator.of(context).pushReplacementNamed(routeNameHome);
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _error,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                ),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => _doLogin(context),
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () => _doLogin(context),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
