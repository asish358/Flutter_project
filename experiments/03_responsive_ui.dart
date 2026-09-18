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
      title: 'Student Profile',
      home: const ResponsiveProfilePage(),
    );
  }
}

class ResponsiveProfilePage extends StatelessWidget {
  const ResponsiveProfilePage({super.key});

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= desktopBreakpoint;
    final isTablet = width >= tabletBreakpoint;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 32 : 16),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _ProfileCard(isTablet: true)),
                      const SizedBox(width: 24),
                      Expanded(child: _DetailsCard(isTablet: true)),
                    ],
                  )
                : ListView(
                    children: [
                      _ProfileCard(isTablet: isTablet),
                      const SizedBox(height: 16),
                      _DetailsCard(isTablet: isTablet),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final bool isTablet;

  const _ProfileCard({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 28 : 20),
        child: Column(
          children: const [
            CircleAvatar(radius: 45, child: Icon(Icons.person, size: 48)),
            SizedBox(height: 16),
            Text('Student Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Computer Science Engineering'),
          ],
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final bool isTablet;

  const _DetailsCard({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 28 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Academic Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 14),
            ListTile(leading: Icon(Icons.school), title: Text('CGPA'), trailing: Text('8.5')),
            ListTile(leading: Icon(Icons.event_available), title: Text('Attendance'), trailing: Text('92%')),
            ListTile(leading: Icon(Icons.code), title: Text('Skills'), trailing: Text('Flutter, Dart')),
          ],
        ),
      ),
    );
  }
}
