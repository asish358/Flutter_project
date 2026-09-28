import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
        cardTheme: const CardThemeData(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

// Custom widget for a profile header.
class ProfileHeader extends StatelessWidget {
  final String name;
  final String course;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              child: Icon(Icons.person, size: 35),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(course),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom reusable widget for profile information.
class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

// Custom styled button.
class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.edit),
      label: Text(text),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 6'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProfileHeader(
            name: 'Student Name',
            course: 'Computer Science Engineering',
          ),
          const SizedBox(height: 8),
          const ProfileInfoCard(
            icon: Icons.school,
            title: 'CGPA',
            value: '8.5',
          ),
          const ProfileInfoCard(
            icon: Icons.event_available,
            title: 'Attendance',
            value: '92%',
          ),
          const ProfileInfoCard(
            icon: Icons.code,
            title: 'Skills',
            value: 'Flutter, Dart, Java',
          ),
          const SizedBox(height: 12),
          ProfileButton(
            text: 'Edit Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit Profile clicked'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
