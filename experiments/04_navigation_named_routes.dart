import 'package:flutter/material.dart';

void main() => runApp(const StudentProfileApp());

class AppRoutes {
  static const profile = '/';
  static const details = '/details';
  static const skills = '/skills';
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profile',
      initialRoute: AppRoutes.profile,
      routes: {
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.details: (context) => const DetailsScreen(),
        AppRoutes.skills: (context) => const SkillsScreen(),
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
            const SizedBox(height: 12),
            const Text('Sai Ranga Asish', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('Flutter Developer'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.details),
              child: const Text('View Details'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.skills),
              child: const Text('View Skills'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Details')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Academic Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Course: Computer Science'),
            Text('Year: 3rd Year'),
            Text('Attendance: 88%'),
          ],
        ),
      ),
    );
  }
}

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Skills')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          ListTile(leading: Icon(Icons.code), title: Text('Dart & Flutter')),
          ListTile(leading: Icon(Icons.cloud), title: Text('Firebase')),
          ListTile(leading: Icon(Icons.storage), title: Text('Database Basics')),
        ],
      ),
    );
  }
}
