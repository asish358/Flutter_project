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

    testWidgets('Testing and debugging screen displays its tools',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: TestingDebuggingScreen()),
      );

      expect(find.text('Testing Flutter UI Components'), findsOneWidget);
      expect(find.text('Test 1: Profile header'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Flutter Debugging Tools'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Flutter Debugging Tools'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('flutter analyze'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('flutter analyze'), findsOneWidget);
      expect(find.text('flutter test'), findsOneWidget);
    });
  });
}
