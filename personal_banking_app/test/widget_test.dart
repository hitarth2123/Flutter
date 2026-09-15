import 'package:flutter_test/flutter_test.dart';
import 'package:personal_banking_app/main.dart';

void main() {
  testWidgets('Banking app renders dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PersonalBankingApp());
    expect(find.text('Personal Banking'), findsOneWidget);
  });
}
