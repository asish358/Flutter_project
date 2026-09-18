// Experiment 1(b): Simple Dart program to understand language basics.
// Covers variables, primitive data types, arithmetic, string interpolation,
// and a basic if/else decision.

void main() {
  // Dart variable examples.
  String studentName = 'Student';
  int age = 20;
  double cgpa = 8.5;
  bool isActive = true;

  print('Student Profile');
  print('Name: $studentName');
  print('Age: $age');
  print('CGPA: $cgpa');
  print('Active: $isActive');

  // Basic arithmetic and conditional statement.
  int marks1 = 85;
  int marks2 = 90;
  int total = marks1 + marks2;

  print('Total Marks: $total');

  if (total >= 150) {
    print('Result: Excellent');
  } else {
    print('Result: Keep improving');
  }
}
