import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_profile_app/main.dart';

void main() {
  testWidgets('Login screen displays the student portal and demo details',
      (tester) async {
    await tester.pumpWidget(const StudentProfileApp());

    expect(find.text('Student Profile Portal'), findsOneWidget);
    expect(find.text('Sign in to continue'), findsOneWidget);
    expect(find.text('Admin: admin@college.com / admin123'), findsOneWidget);
  });

  testWidgets('Student login opens the personalized dashboard',
      (tester) async {
    await tester.pumpWidget(const StudentProfileApp());

    await tester.enterText(
      find.byType(TextField).at(0),
      'asish@student.demo',
    );
    await tester.enterText(find.byType(TextField).at(1), 'student123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, G. Asish'), findsOneWidget);
    expect(find.text('Your overview'), findsOneWidget);
    expect(find.text('9.2'), findsOneWidget);
  });
}
