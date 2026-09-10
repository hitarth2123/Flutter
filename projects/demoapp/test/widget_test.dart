// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:demoapp/main.dart';

void main() {
  testWidgets('home screen opens the three concept screens', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Concepts Lab'), findsOneWidget);
    expect(find.text('User Input & Forms'), findsOneWidget);
    expect(find.text('Images & Fonts'), findsOneWidget);
    expect(find.text('Animations'), findsOneWidget);

    await tester.tap(find.text('User Input & Forms'));
    await tester.pumpAndSettle();

    expect(find.text('Every field is validated before the form is submitted.'), findsOneWidget);
  });

  testWidgets('form displays validation messages', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('User Input & Forms'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Submit information'));
    await tester.pump();

    expect(find.text('Enter at least 2 characters.'), findsOneWidget);
    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  testWidgets('animation button changes the container state', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Animations'));
    await tester.pumpAndSettle();
    expect(find.text('Tap below'), findsOneWidget);

    await tester.tap(find.text('Animate container'));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('Expanded'), findsOneWidget);
  });
}
