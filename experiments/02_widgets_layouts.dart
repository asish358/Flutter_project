import 'package:flutter/material.dart';

// Experiment 2: Explore Flutter widgets and layout using Row, Column and Stack.
void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Profile')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          // Column arranges the main profile sections vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack places the profile avatar over the banner.
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade100,
                    ),
                    child: const Center(
                      child: Icon(Icons.school, size: 70),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Student Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Flutter Developer | Computer Science Student'),
              const SizedBox(height: 20),
              // Row displays the student statistics horizontally.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _InfoItem(icon: Icons.school, label: '8.5 CGPA'),
                  _InfoItem(icon: Icons.event_available, label: '92% Attendance'),
                  _InfoItem(icon: Icons.workspace_premium, label: '5 Skills'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
