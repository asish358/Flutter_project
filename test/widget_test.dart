import 'package:flutter_test/flutter_test.dart';
import 'package:student_profile_app/main.dart';

void main() {
  testWidgets('Student Profile App opens and lists Experiment 9', (tester) async {
    await tester.pumpWidget(const StudentProfileApp());

    expect(find.text('Student Profile App'), findsOneWidget);
    expect(find.text('Experiment 9 - REST API'), findsOneWidget);
  });
}
