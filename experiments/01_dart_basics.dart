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

  // Basic arithmetic operations.
  int marks1 = 85;
  int marks2 = 90;
  int total = marks1 + marks2;
  double average = total / 2;

  print('Total Marks: $total');
  print('Average Marks: $average');

  // Basic conditional statement.
  if (total >= 150) {
    print('Result: Excellent');
  } else {
    print('Result: Keep improving');
  }
}
