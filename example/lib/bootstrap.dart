import 'package:flutter/material.dart';
import 'package:observable_state_example/di.dart';
import 'package:observable_state_example/routes.dart';
import 'package:observable_state_example/state.dart';

class Bootstrap extends StatefulWidget {
  @override
  _BootstrapState createState() => _BootstrapState();
}

class _BootstrapState extends MyState<Bootstrap> {
  @override
  void didChangeDependencies() async {
    state.counter = await DI.of(context).service.getCounter();

    Navigator.of(context).pushReplacementNamed(homePage);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
