import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:observable_state_example/app.dart';
import 'package:observable_state_example/home_page.dart';
import 'package:observable_state_example/splash_screen.dart';
import 'package:observable_state_example/state.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App(state: MyState()));
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Counter: 42'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Incrementing'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Counter: 43'), findsOneWidget);
  });
}
