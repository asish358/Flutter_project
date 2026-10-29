import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_profile_app/main.dart';

void main() {
  group('Experiment 10 - UI widget tests', () {
    testWidgets('ProfileHeader displays the student name and course',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProfileHeader(
              name: 'Test Student',
              course: 'Computer Science Engineering',
            ),
          ),
        ),
      );

      expect(find.text('Test Student'), findsOneWidget);
      expect(find.text('Computer Science Engineering'), findsOneWidget);
    });

    testWidgets('Student form shows validation messages when submitted empty',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: StudentFormScreen()),
      );

      await tester.ensureVisible(find.text('Submit'));
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your phone number'), findsOneWidget);
      expect(find.text('Please enter your course'), findsOneWidget);
    });

    testWidgets('Experiment 10 card opens the testing and debugging screen',
        (tester) async {
      await tester.pumpWidget(const StudentProfileApp());

      final experiment10 = find.text('Experiment 10 - Testing & Debugging');
      await tester.scrollUntilVisible(
        experiment10,
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(experiment10);
      await tester.pumpAndSettle();

      expect(find.text('Flutter Debugging Tools'), findsOneWidget);
      expect(find.text('flutter analyze'), findsOneWidget);
      expect(find.text('flutter test'), findsOneWidget);
    });
  });
}
