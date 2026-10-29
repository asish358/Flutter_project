import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_profile_app/main.dart';

void main() {
  testWidgets('Student Profile App opens and lists Experiment 9', (tester) async {
    await tester.pumpWidget(const StudentProfileApp());

    expect(find.text('Student Profile App'), findsOneWidget);

    final experiment9 = find.text('Experiment 9 - REST API');
    await tester.scrollUntilVisible(
      experiment9,
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(experiment9, findsOneWidget);
  });
}
