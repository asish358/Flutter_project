import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CounterProvider(),
    child: const StudentProfileApp(),
  ));
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Profile App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          '/responsive': (_) => const ResponsiveScreen(),
          '/state': (_) => const StateScreen(),
          '/form': (_) => const StudentFormScreen(),
          '/animation': (_) => const AnimationScreen(),
          '/api': (_) => const RestApiScreen(),
        },
      );
}

class CounterProvider extends ChangeNotifier {
  int count = 0;
  void increase() { count++; notifyListeners(); }
  void decrease() { count--; notifyListeners(); }
  void reset() { count = 0; notifyListeners(); }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const items = <({String title, String subtitle, IconData icon, Widget page})>[
    (title: 'Experiment 1 - Dart Basics', subtitle: 'Variables, types, operations and conditions', icon: Icons.code, page: DartBasicsScreen()),
    (title: 'Experiment 2 - Widgets & Layouts', subtitle: 'Row, Column, Stack and profile UI', icon: Icons.dashboard, page: WidgetsLayoutScreen()),
    (title: 'Experiment 3 - Responsive UI', subtitle: 'Mobile, tablet and desktop layouts', icon: Icons.devices, page: ResponsiveScreen()),
    (title: 'Experiment 4 - Navigation', subtitle: 'Named route navigation example', icon: Icons.alt_route, page: NavigationScreen()),
    (title: 'Experiment 5 - State Management', subtitle: 'setState and Provider counters', icon: Icons.exposure_plus_1, page: StateScreen()),
    (title: 'Experiment 6 - Custom Widgets & Themes', subtitle: 'Reusable widgets and app styling', icon: Icons.palette, page: CustomWidgetsScreen()),
    (title: 'Experiment 7 - Form Validation', subtitle: 'Student form with validation', icon: Icons.assignment, page: StudentFormScreen()),
    (title: 'Experiment 8 - Animations', subtitle: 'Fade and slide transitions', icon: Icons.animation, page: AnimationScreen()),
    (title: 'Experiment 9 - REST API', subtitle: 'Fetch and display JSON data', icon: Icons.cloud_download, page: RestApiScreen()),
    (title: 'Experiment 10 - Testing & Debugging', subtitle: 'Widget tests and Flutter debugging tools', icon: Icons.bug_report, page: TestingDebuggingScreen()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Student Profile App')),
        body: LayoutBuilder(builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 600 ? 2 : 1;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: columns == 1 ? 4.0 : 2.25,
                children: items.map((item) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        CircleAvatar(child: Icon(item.icon)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(item.subtitle, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        )),
                        const Icon(Icons.chevron_right),
                      ]),
                    ),
                  ),
                )).toList(),
              ),
            ),
          );
        }),
      );
}

class PageShell extends StatelessWidget {
  final String title;
  final Widget child;
  const PageShell({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: child);
}

class InfoTile extends StatelessWidget {
  final String label, value;
  final IconData? icon;
  const InfoTile({super.key, required this.label, required this.value, this.icon});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: icon == null ? null : CircleAvatar(child: Icon(icon)),
    title: Text(label), subtitle: Text(value),
  ));
}

class ProfileHeader extends StatelessWidget {
  final String name, course;
  const ProfileHeader({super.key, required this.name, required this.course});
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(children: [
      const CircleAvatar(radius: 35, child: Icon(Icons.person, size: 35)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4), Text(course),
      ])),
    ]),
  ));
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const ProfileInfoCard({super.key, required this.icon, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: CircleAvatar(child: Icon(icon)),
    title: Text(title), subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
  ));
}

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ProfileButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed, icon: const Icon(Icons.edit), label: Text(text),
  );
}

// Experiment 1: Dart variables, data types, arithmetic and conditions.
class DartBasicsScreen extends StatelessWidget {
  const DartBasicsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const name = 'Student Name';
    const year = 2;
    const cgpa = 8.5;
    const enrolled = true;
    const a = 12, b = 4;
    return PageShell(title: 'Experiment 1 - Dart Basics', child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Dart Basics', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const InfoTile(label: 'String', value: name),
      const InfoTile(label: 'Integer', value: '$year'),
      const InfoTile(label: 'Double', value: '$cgpa'),
      const InfoTile(label: 'Boolean', value: '$enrolled'),
      const Divider(),
      const InfoTile(label: '$a + $b', value: '${a + b}'),
      const InfoTile(label: '$a - $b', value: '${a - b}'),
      const InfoTile(label: '$a × $b', value: '${a * b}'),
      const InfoTile(label: '$a ÷ $b', value: '${a ~/ b}'),
      Text(cgpa >= 8 ? 'Result: Excellent academic performance!' : 'Keep working hard!',
        style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
    ]));
  }
}

// Experiment 2: Row, Column, Stack and Flutter widgets.
class WidgetsLayoutScreen extends StatelessWidget {
  const WidgetsLayoutScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 2 - Widgets & Layouts', child: ListView(padding: const EdgeInsets.all(20), children: [
    Stack(alignment: Alignment.bottomLeft, children: [
      Container(height: 155, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [Colors.indigo, Colors.blue]),
      )),
      const Positioned(left: 20, top: 20, child: CircleAvatar(radius: 34, child: Icon(Icons.person, size: 40))),
      const Positioned(left: 20, bottom: 20, child: Text('Student Profile', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
    ]),
    const SizedBox(height: 16),
    const InfoTile(label: 'Course', value: 'Computer Science Engineering', icon: Icons.school),
    const InfoTile(label: 'CGPA', value: '8.5', icon: Icons.grade),
    const InfoTile(label: 'Attendance', value: '92%', icon: Icons.event_available),
    const InfoTile(label: 'Skills', value: 'Flutter, Dart, Java', icon: Icons.code),
    const Text('Row layout example:'),
    const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.home), Icon(Icons.person), Icon(Icons.settings)]),
  ]));
}

// Experiment 3: responsive UI using LayoutBuilder.
class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 3 - Responsive UI', child: LayoutBuilder(builder: (context, c) {
    final wide = c.maxWidth >= 700;
    const details = [
      InfoTile(label: 'Course', value: 'CSE', icon: Icons.school),
      InfoTile(label: 'CGPA', value: '8.5', icon: Icons.grade),
      InfoTile(label: 'Attendance', value: '92%', icon: Icons.event_available),
      InfoTile(label: 'Skills', value: 'Flutter, Dart, Java', icon: Icons.code),
    ];
    return SingleChildScrollView(padding: const EdgeInsets.all(20), child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(children: [
        const ProfileHeader(name: 'Student Name', course: 'Computer Science Engineering'),
        if (wide) GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 4, children: details)
        else ...details,
        Text(wide ? 'Wide screen layout (tablet/desktop)' : 'Compact layout (mobile)', style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
      ]),
    )));
  }));
}

// Experiment 4: named route navigation.
class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 4 - Navigation', child: ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Named Route Navigation', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const Text('Use these buttons to open other experiment screens.'),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/responsive'), child: const Text('Open Responsive UI')),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/state'), child: const Text('Open State Management')),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/form'), child: const Text('Open Student Form')),
    FilledButton(onPressed: () => Navigator.pushNamed(context, '/animation'), child: const Text('Open Animations')),
  ]));
}

// Experiment 5: StatefulWidget/setState and Provider/ChangeNotifier.
class StateScreen extends StatefulWidget {
  const StateScreen({super.key});
  @override
  State<StateScreen> createState() => _StateScreenState();
}
class _StateScreenState extends State<StateScreen> {
  int localCount = 0;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CounterProvider>();
    return PageShell(title: 'Experiment 5 - State Management', child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('A. StatefulWidget + setState()', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(child: ListTile(
        title: Text('Local counter: $localCount'),
        trailing: Wrap(children: [
          IconButton(onPressed: () => setState(() => localCount--), icon: const Icon(Icons.remove)),
          IconButton(onPressed: () => setState(() => localCount++), icon: const Icon(Icons.add)),
        ]),
      )),
      const SizedBox(height: 20),
      const Text('B. Provider + ChangeNotifier', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Text('Provider counter: ${provider.count}', style: const TextStyle(fontSize: 24)),
        Wrap(spacing: 8, children: [
          FilledButton(onPressed: provider.decrease, child: const Text('-1')),
          FilledButton(onPressed: provider.increase, child: const Text('+1')),
          OutlinedButton(onPressed: provider.reset, child: const Text('Reset')),
        ]),
      ]))),
    ]));
  }
}

// Experiment 6: custom widgets and ThemeData.
class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 6 - Custom Widgets & Themes', child: ListView(padding: const EdgeInsets.all(20), children: [
    const ProfileHeader(name: 'Student Name', course: 'Computer Science Engineering'),
    const ProfileInfoCard(icon: Icons.school, title: 'CGPA', value: '8.5'),
    const ProfileInfoCard(icon: Icons.event_available, title: 'Attendance', value: '92%'),
    const ProfileInfoCard(icon: Icons.code, title: 'Skills', value: 'Flutter, Dart, Java'),
    ProfileButton(text: 'Edit Profile', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Profile clicked')))),
  ]));
}

// Experiment 7: student form and validation.
class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});
  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}
class _StudentFormScreenState extends State<StudentFormScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final course = TextEditingController();

  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your name';
    if (v.trim().length < 3) return 'Name must contain at least 3 characters';
    return null;
  }
  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }
  String? validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Phone number must contain 10 digits';
    return null;
  }
  void submit() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile submitted for ${name.text.trim()}!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fix the errors in the form')));
    }
  }
  @override
  void dispose() {
    name.dispose(); email.dispose(); phone.dispose(); course.dispose(); super.dispose();
  }
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 7 - Student Form', child: Form(
    key: formKey,
    child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Student Registration', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()), validator: validateName),
      const SizedBox(height: 16),
      TextFormField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()), validator: validateEmail),
      const SizedBox(height: 16),
      TextFormField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()), validator: validatePhone),
      const SizedBox(height: 16),
      TextFormField(controller: course, decoration: const InputDecoration(labelText: 'Course', prefixIcon: Icon(Icons.school), border: OutlineInputBorder()), validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your course' : null),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: submit, icon: const Icon(Icons.check), label: const Text('Submit')),
    ]),
  ));
}

// Experiment 8: fade and slide animations.
class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}
class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    fade = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();
  }
  void replay() => controller.forward(from: 0);
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => PageShell(title: 'Experiment 8 - Animations', child: Center(child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: Card(child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(children: [
          const CircleAvatar(radius: 42, child: Icon(Icons.school, size: 42)),
          const SizedBox(height: 16),
          Text('Student Profile', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Fade + Slide Animation'),
          const SizedBox(height: 12),
          const Icon(Icons.auto_awesome, size: 32, color: Colors.indigo),
        ]),
      )))),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: replay, icon: const Icon(Icons.replay), label: const Text('Replay Animation')),
    ]),
  )));
}


// Experiment 9: fetch REST API data, parse JSON and display results.
class RestApiScreen extends StatefulWidget {
  const RestApiScreen({super.key});
  @override
  State<RestApiScreen> createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  late Future<List<Map<String, dynamic>>> albums;

  @override
  void initState() {
    super.initState();
    albums = loadAlbums();
  }

  Future<List<Map<String, dynamic>>> loadAlbums() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums?_limit=10'))
        .timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('API request failed: ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  void refresh() => setState(() => albums = loadAlbums());

  @override
  Widget build(BuildContext context) => PageShell(
    title: 'Experiment 9 - REST API',
    child: FutureBuilder<List<Map<String, dynamic>>>(
      future: albums,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator(), SizedBox(height: 12), Text('Loading API data...')],
          ));
        }
        if (snapshot.hasError) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.cloud_off, size: 48),
              const SizedBox(height: 12),
              const Text('Unable to fetch data. Check your connection and retry.', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(onPressed: refresh, icon: const Icon(Icons.refresh), label: const Text('Try again')),
            ]),
          ));
        }
        final rows = snapshot.data ?? <Map<String, dynamic>>[];
        return ListView(padding: const EdgeInsets.all(16), children: [
          Card(color: Theme.of(context).colorScheme.primaryContainer, child: ListTile(
            leading: const Icon(Icons.cloud_done, size: 32),
            title: const Text('Live API response'),
            subtitle: Text('${rows.length} records fetched from JSONPlaceholder'),
            trailing: IconButton(onPressed: refresh, icon: const Icon(Icons.refresh), tooltip: 'Refresh'),
          )),
          ...rows.map((album) => Card(child: ListTile(
            leading: CircleAvatar(child: Text('${album['id']}')),
            title: Text('${album['title']}', maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text('Album ID: ${album['id']} • User ID: ${album['userId']}'),
          ))),
        ]);
      },
    ),
  );
}


// Experiment 10: UI testing and Flutter debugging.
class TestingDebuggingScreen extends StatelessWidget {
  const TestingDebuggingScreen({super.key});

  @override
  Widget build(BuildContext context) => PageShell(
    title: 'Experiment 10 - Testing & Debugging',
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Testing Flutter UI Components',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Widget tests verify what a user can see and do without manually tapping through every screen.',
        ),
        const SizedBox(height: 12),
        const InfoTile(
          label: 'Test 1: Profile header',
          value: 'Verify the student name and course are displayed.',
          icon: Icons.verified,
        ),
        const InfoTile(
          label: 'Test 2: Form validation',
          value: 'Submit an empty registration form and verify validation messages.',
          icon: Icons.fact_check,
        ),
        const InfoTile(
          label: 'Test 3: Navigation',
          value: 'Verify that the Experiment 10 card opens this screen.',
          icon: Icons.route,
        ),
        const Divider(height: 32),
        const Text(
          'Flutter Debugging Tools',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const InfoTile(
          label: 'Flutter Inspector',
          value: 'Inspect the widget tree, layout constraints, padding, and alignment.',
          icon: Icons.account_tree,
        ),
        const InfoTile(
          label: 'DevTools / Performance view',
          value: 'Inspect rebuilds, frame performance, memory, and runtime behavior.',
          icon: Icons.speed,
        ),
        const InfoTile(
          label: 'Breakpoints and debugger',
          value: 'Pause execution and inspect variables and call stacks in the IDE.',
          icon: Icons.pause_circle,
        ),
        const InfoTile(
          label: 'Console and logging',
          value: 'Use debugPrint() and exception details to locate the source of a problem.',
          icon: Icons.terminal,
        ),
        const Divider(height: 32),
        const Text(
          'Commands used for verification',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const InfoTile(
          label: 'flutter analyze',
          value: 'Finds static analysis and lint issues.',
          icon: Icons.search,
        ),
        const InfoTile(
          label: 'flutter test',
          value: 'Runs unit and widget tests.',
          icon: Icons.play_circle,
        ),
        const InfoTile(
          label: 'flutter run --debug',
          value: 'Runs the app in debug mode for interactive investigation.',
          icon: Icons.bug_report,
        ),
        const SizedBox(height: 12),
        const Text(
          'Example issue and fix: if a widget test cannot find a card because it is outside the visible area, scroll the test viewport until the card is built and visible before asserting it exists.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}



// Demo-only role login. Use Firebase Authentication and a database for production.
class StudentRecord {
  final String name, rollNo, email, course, year, cgpa, skills, projects;
  const StudentRecord(this.name, this.rollNo, this.email, this.course, this.year, this.cgpa, this.skills, this.projects);
}
const demoStudents = <StudentRecord>[
  StudentRecord('G. Asish', '24AG1A0522', 'asish@student.demo', 'B.Tech CSE', '2nd Year', '9.2', 'Python, Java, C, Flutter, DSA', 'Student Profile App, Student Grade Tracker'),
  StudentRecord('Aarav Kumar', '24AG1A0508', 'aarav@student.demo', 'B.Tech CSE', '2nd Year', '8.7', 'Python, HTML, CSS', 'Attendance Tracker'),
  StudentRecord('Priya Sharma', '24AG1A0516', 'priya@student.demo', 'B.Tech CSE', '2nd Year', '9.0', 'Java, SQL, UI Design', 'Library Management System'),
  StudentRecord('Rahul Reddy', '24AG1A0531', 'rahul@student.demo', 'B.Tech CSE', '2nd Year', '8.4', 'C, Python, Networking', 'Network Monitor'),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String role = 'Student';
  String? error;
  bool hidePassword = true;
  void login() {
    final id = email.text.trim().toLowerCase();
    if (role == 'Admin' && id == 'admin@college.com' && password.text == 'admin123') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
      return;
    }
    final found = demoStudents.where((s) => s.email == id);
    if (role == 'Student' && password.text == 'student123' && found.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StudentHome(record: found.first)));
      return;
    }
    setState(() => error = 'Invalid login. Please check the demo details below.');
  }
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F6FB),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 430),
        child: Card(child: Padding(padding: const EdgeInsets.all(28), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const CircleAvatar(radius: 30, backgroundColor: Color(0xFFE9EDFF), child: Icon(Icons.school, color: Color(0xFF4057B2), size: 34)),
          const SizedBox(height: 16),
          const Text('Student Profile Portal', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Sign in to continue', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF667085))),
          const SizedBox(height: 24),
          SegmentedButton<String>(segments: const [
            ButtonSegment(value: 'Student', label: Text('Student'), icon: Icon(Icons.person_outline)),
            ButtonSegment(value: 'Admin', label: Text('Admin'), icon: Icon(Icons.admin_panel_settings_outlined)),
          ], selected: {role}, onSelectionChanged: (v) => setState(() { role = v.first; error = null; })),
          const SizedBox(height: 16),
          TextField(controller: email, keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email / Login ID', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder())),
          const SizedBox(height: 14),
          TextField(controller: password, obscureText: hidePassword,
            decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => hidePassword = !hidePassword)), border: const OutlineInputBorder())),
          if (error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(error!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center)),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: login, icon: const Icon(Icons.login), label: const Padding(padding: EdgeInsets.all(12), child: Text('Login'))),
          const SizedBox(height: 18),
          Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFF3F5FA), borderRadius: BorderRadius.circular(12)),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Demo login details', style: TextStyle(fontWeight: FontWeight.w800)),
              SizedBox(height: 8),
              Text('Admin: admin@college.com / admin123'),
              Text('Student: asish@student.demo / student123'),
              Text('Other sample students: use their email / student123'),
            ])),
          const SizedBox(height: 12),
          const Text('Demo only — do not enter real passwords or private student data.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Color(0xFF7B8496))),
        ]))),
      ),
    )),
  );
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final list = demoStudents.where((s) => s.name.toLowerCase().contains(query.toLowerCase()) || s.rollNo.toLowerCase().contains(query.toLowerCase()) || s.email.toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(title: const Text('Admin Dashboard'), actions: [
        TextButton.icon(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false), icon: const Icon(Icons.logout), label: const Text('Logout')),
      ]),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000),
        child: ListView(padding: const EdgeInsets.all(22), children: [
          const Text('All student profiles', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          const Text('Search the directory and open a student profile.', style: TextStyle(color: Color(0xFF667085))),
          const SizedBox(height: 18),
          Card(child: ListTile(leading: const Icon(Icons.groups, color: Color(0xFF4057B2)), title: const Text('Total students'), trailing: Text(demoStudents.length.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 12),
          TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(hintText: 'Search name, roll number or email', prefixIcon: Icon(Icons.search), border: OutlineInputBorder())),
          const SizedBox(height: 12),
          ...list.map((s) => Card(child: ListTile(
            leading: const CircleAvatar(backgroundColor: Color(0xFFE9EDFF), child: Icon(Icons.person, color: Color(0xFF4057B2))),
            title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(s.rollNo + '  •  ' + s.email + '  •  CGPA ' + s.cgpa),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDetailScreen(record: s))),
          ))),
          if (list.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Text('No matching students found.', textAlign: TextAlign.center)),
          const SizedBox(height: 10),
          const Text('These are sample demo records. Connect a database for real student information.', style: TextStyle(fontSize: 12, color: Color(0xFF7B8496))),
        ]),
      )),
    );
  }
}

class StudentHome extends StatelessWidget {
  final StudentRecord record;
  const StudentHome({super.key, required this.record});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final skills = record.skills.split(',').map((s) => s.trim()).toList();
    final projects = record.projects.split(',').map((s) => s.trim()).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Row(children: [
          Icon(Icons.school_rounded, color: Color(0xFF4057B2)),
          SizedBox(width: 10),
          Text('Student Profile Portal', style: TextStyle(fontWeight: FontWeight.w800)),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 850;
        final cardWidth = wide ? (constraints.maxWidth - 52) / 2 : constraints.maxWidth;
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: ListView(
              padding: EdgeInsets.all(wide ? 28 : 16),
              children: [
                Container(
                  padding: EdgeInsets.all(wide ? 30 : 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF263B83), Color(0xFF536BD1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(children: [
                    CircleAvatar(
                      radius: wide ? 38 : 30,
                      backgroundColor: Colors.white.withValues(alpha: 0.18),
                      child: const Icon(Icons.person, color: Colors.white, size: 38),
                    ),
                    const SizedBox(width: 18),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('STUDENT DASHBOARD', style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1.3, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 7),
                        Text('Welcome, ${record.name}', style: TextStyle(color: Colors.white, fontSize: wide ? 27 : 21, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 5),
                        Text('${record.course}  •  ${record.year}', style: const TextStyle(color: Colors.white70)),
                      ],
                    )),
                  ]),
                ),
                const SizedBox(height: 22),
                const Text('Your overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF202A44))),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _StudentStatCard(width: wide ? (constraints.maxWidth - 36) / 4 : (constraints.maxWidth - 12) / 2, title: 'CGPA', value: record.cgpa, icon: Icons.grade_rounded, tint: const Color(0xFFE9EDFF)),
                  _StudentStatCard(width: wide ? (constraints.maxWidth - 36) / 4 : (constraints.maxWidth - 12) / 2, title: 'Academic year', value: record.year, icon: Icons.calendar_month_rounded, tint: const Color(0xFFE8F7EE)),
                  _StudentStatCard(width: wide ? (constraints.maxWidth - 36) / 4 : (constraints.maxWidth - 12) / 2, title: 'Projects', value: '${projects.length}', icon: Icons.folder_copy_outlined, tint: const Color(0xFFFFF2DF)),
                  _StudentStatCard(width: wide ? (constraints.maxWidth - 36) / 4 : (constraints.maxWidth - 12) / 2, title: 'Skills', value: '${skills.length}', icon: Icons.code_rounded, tint: const Color(0xFFF2EAFE)),
                ]),
                const SizedBox(height: 24),
                const Text('My profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF202A44))),
                const SizedBox(height: 12),
                Wrap(spacing: 16, runSpacing: 16, children: [
                  SizedBox(width: cardWidth, child: _StudentInfoBox(
                    title: 'Personal details',
                    icon: Icons.person_outline,
                    child: Column(children: [
                      _StudentDetailLine('Full name', record.name, Icons.badge_outlined),
                      _StudentDetailLine('Roll number', record.rollNo, Icons.confirmation_number_outlined),
                      _StudentDetailLine('Email', record.email, Icons.email_outlined),
                    ]),
                  )),
                  SizedBox(width: cardWidth, child: _StudentInfoBox(
                    title: 'Education',
                    icon: Icons.school_outlined,
                    child: Column(children: [
                      _StudentDetailLine('Course', record.course, Icons.menu_book_outlined),
                      _StudentDetailLine('Year', record.year, Icons.calendar_today_outlined),
                      _StudentDetailLine('CGPA', record.cgpa, Icons.grade_outlined),
                    ]),
                  )),
                  SizedBox(width: cardWidth, child: _StudentInfoBox(
                    title: 'My skills',
                    icon: Icons.code_rounded,
                    child: Wrap(spacing: 8, runSpacing: 8, children: skills.map((skill) => Chip(
                      avatar: const Icon(Icons.check_circle_outline, size: 16),
                      label: Text(skill),
                      backgroundColor: const Color(0xFFF0F2FF),
                      side: BorderSide.none,
                    )).toList()),
                  )),
                  SizedBox(width: cardWidth, child: _StudentInfoBox(
                    title: 'My projects',
                    icon: Icons.folder_open_outlined,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: projects.map((project) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Icon(Icons.task_alt, color: Color(0xFF4057B2), size: 20),
                        const SizedBox(width: 10),
                        Expanded(child: Text(project, style: const TextStyle(fontWeight: FontWeight.w600))),
                      ]),
                    )).toList()),
                  )),
                ]),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE7EAF2))),
                  child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.info_outline, color: Color(0xFF4057B2)),
                    SizedBox(width: 12),
                    Expanded(child: Text('This dashboard displays your own student information. Contact your college administrator if any profile details need to be updated.', style: TextStyle(color: Color(0xFF667085), height: 1.4))),
                  ]),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _StudentStatCard extends StatelessWidget {
  final double width;
  final String title, value;
  final IconData icon;
  final Color tint;
  const _StudentStatCard({required this.width, required this.title, required this.value, required this.icon, required this.tint});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Color(0xFFE7EAF2))),
      child: Padding(padding: const EdgeInsets.all(17), child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF4057B2))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF202A44))),
          const SizedBox(height: 3),
          Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
        ])),
      ])),
    ),
  );
}

class _StudentInfoBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _StudentInfoBox({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Color(0xFFE7EAF2))),
    child: Padding(padding: const EdgeInsets.all(20), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFE9EDFF), borderRadius: BorderRadius.circular(11)), child: Icon(icon, color: const Color(0xFF4057B2), size: 21)),
          const SizedBox(width: 11),
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF202A44))),
        ]),
        const SizedBox(height: 16),
        child,
      ],
    )),
  );
}
class StudentDetailScreen extends StatelessWidget {
  final StudentRecord record;
  const StudentDetailScreen({super.key, required this.record});
  static const ink=Color(0xFF17233D), blue=Color(0xFF4057B2), muted=Color(0xFF68758D);
  @override Widget build(BuildContext context) {
    final skills=record.skills.split(',').map((s)=>s.trim()).where((s)=>s.isNotEmpty).toList();
    final projects=record.projects.split(',').map((s)=>s.trim()).where((s)=>s.isNotEmpty).toList();
    final wide=MediaQuery.sizeOf(context).width>=850;
    return Scaffold(backgroundColor:const Color(0xFFF4F6FB),appBar:AppBar(backgroundColor:Colors.white,surfaceTintColor:Colors.white,elevation:0,title:const Text('Student profile',style:TextStyle(color:ink,fontWeight:FontWeight.w800)),actions:[Padding(padding:const EdgeInsets.only(right:18),child:Center(child:Chip(avatar:const Icon(Icons.verified_rounded,color:Color(0xFF23804D),size:17),label:const Text('ADMIN VIEW',style:TextStyle(color:Color(0xFF23804D),fontWeight:FontWeight.w800,fontSize:11)),backgroundColor:const Color(0xFFEAF7EF),side:BorderSide.none)))]),
      body:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1180),child:ListView(padding:EdgeInsets.all(wide?30:16),children:[
        Container(padding:EdgeInsets.all(wide?30:22),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF182653),Color(0xFF344B9B),Color(0xFF6578D6)],begin:Alignment.topLeft,end:Alignment.bottomRight),borderRadius:BorderRadius.circular(26),boxShadow:[BoxShadow(color:blue.withValues(alpha:.18),blurRadius:28,offset:const Offset(0,12))]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('STUDENT RECORD  /  PROFILE OVERVIEW',style:TextStyle(color:Color(0xFFDCE4FF),fontSize:11,fontWeight:FontWeight.w800,letterSpacing:1.1)),const SizedBox(height:24),
          if(wide)Row(children:[_AdminAvatar(name:record.name,size:100),const SizedBox(width:22),Expanded(child:_AdminIdentity(record:record)),const Icon(Icons.arrow_outward_rounded,color:Colors.white70,size:25)]) else Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_AdminAvatar(name:record.name,size:84),const SizedBox(height:16),_AdminIdentity(record:record)]),
          const SizedBox(height:22),Wrap(spacing:9,runSpacing:9,children:[_AdminPill(icon:Icons.badge_outlined,text:record.rollNo),_AdminPill(icon:Icons.school_outlined,text:record.course),_AdminPill(icon:Icons.calendar_month_outlined,text:record.year)]),
        ])),
        const SizedBox(height:25),const _AdminHeading(eyebrow:'AT A GLANCE',title:'Academic snapshot',subtitle:'A quick overview of this student’s profile'),const SizedBox(height:14),
        LayoutBuilder(builder:(context,c){final n=c.maxWidth>=850?4:c.maxWidth>=520?2:1;final w=(c.maxWidth-(n-1)*12)/n;return Wrap(spacing:12,runSpacing:12,children:[
          _AdminMetric(width:w,icon:Icons.workspace_premium_rounded,label:'CGPA',value:record.cgpa,note:'Academic score',tint:const Color(0xFFECEFFF),accent:const Color(0xFF485CC0)),
          _AdminMetric(width:w,icon:Icons.code_rounded,label:'SKILLS',value:'${skills.length}',note:'Listed skills',tint:const Color(0xFFE8F7F1),accent:const Color(0xFF23805B)),
          _AdminMetric(width:w,icon:Icons.folder_special_rounded,label:'PROJECTS',value:'${projects.length}',note:'Listed projects',tint:const Color(0xFFFFF2E5),accent:const Color(0xFFB66A22)),
          _AdminMetric(width:w,icon:Icons.school_rounded,label:'PROGRAMME',value:record.year,note:record.course,tint:const Color(0xFFF3ECFF),accent:const Color(0xFF8054B8)),
        ]);}),
        const SizedBox(height:28),const _AdminHeading(eyebrow:'STUDENT INFORMATION',title:'Profile details',subtitle:'Personal and academic information in one place'),const SizedBox(height:14),
        LayoutBuilder(builder:(context,c){final n=c.maxWidth>=850?2:1;final w=n==2?(c.maxWidth-14)/2:c.maxWidth;return Wrap(spacing:14,runSpacing:14,children:[
          SizedBox(width:w,child:_AdminPanel(icon:Icons.person_rounded,title:'Personal information',subtitle:'Student identity and contact',child:Column(children:[_AdminRow(label:'Full name',value:record.name,icon:Icons.person_outline_rounded),_AdminRow(label:'Roll number',value:record.rollNo,icon:Icons.confirmation_number_outlined),_AdminRow(label:'Email address',value:record.email,icon:Icons.alternate_email_rounded)]))),
          SizedBox(width:w,child:_AdminPanel(icon:Icons.school_rounded,title:'Academic information',subtitle:'Current course and performance',child:Column(children:[_AdminRow(label:'Programme',value:record.course,icon:Icons.menu_book_rounded),_AdminRow(label:'Academic year',value:record.year,icon:Icons.calendar_today_rounded),_AdminRow(label:'Current CGPA',value:record.cgpa,icon:Icons.grade_rounded)]))),
          SizedBox(width:w,child:_AdminPanel(icon:Icons.auto_awesome_rounded,title:'Skills & technologies',subtitle:'${skills.length} skills listed',child:Wrap(spacing:9,runSpacing:9,children:skills.map((s)=>Container(padding:const EdgeInsets.symmetric(horizontal:13,vertical:9),decoration:BoxDecoration(color:const Color(0xFFF1F3FF),borderRadius:BorderRadius.circular(12),border:Border.all(color:const Color(0xFFE1E6FF))),child:Row(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.check_circle_rounded,size:15,color:blue),const SizedBox(width:7),Text(s,style:const TextStyle(color:ink,fontWeight:FontWeight.w700,fontSize:12))]))).toList()))),
           SizedBox(
             width: w,
             child: _AdminPanel(
               icon: Icons.rocket_launch_rounded,
               title: 'Projects & work',
               subtitle: '${projects.length} projects listed',
               child: Column(
                 children: projects.map((p) => Padding(
                   padding: const EdgeInsets.only(bottom: 12),
                   child: Row(children: [
                     Container(width: 34, height: 34, decoration: BoxDecoration(color: const Color(0xFFFFF2E5), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.folder_open_rounded, color: Color(0xFFB66A22), size: 18)),
                     const SizedBox(width: 11),
                     Expanded(child: Text(p, style: const TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13))),
                     const Icon(Icons.north_east_rounded, size: 16, color: Color(0xFF9AA4B5)),
                   ]),
                 )).toList(),
               ),
             ),
           ),
        ]);}),
        const SizedBox(height:22),Container(padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:const Color(0xFFEFF2FF),borderRadius:BorderRadius.circular(17),border:Border.all(color:const Color(0xFFDDE3FF))),child:const Row(children:[Icon(Icons.info_outline_rounded,color:blue),SizedBox(width:12),Expanded(child:Text('Administrator view · This screen displays information available in the current demo student record. Connect a secure database to manage verified student information.',style:TextStyle(color:Color(0xFF46547A),height:1.45,fontSize:12)))])),
        const SizedBox(height:18),Align(alignment:Alignment.centerLeft,child:OutlinedButton.icon(onPressed:()=>Navigator.pop(context),icon:const Icon(Icons.arrow_back_rounded),label:const Text('Back to student directory'),style:OutlinedButton.styleFrom(padding:const EdgeInsets.symmetric(horizontal:18,vertical:15),foregroundColor:blue,side:const BorderSide(color:Color(0xFFD5DCF4))))),
      ]))),
    );
  }
}
class _AdminAvatar extends StatelessWidget {
  final String name;final double size;const _AdminAvatar({required this.name,required this.size});
  @override Widget build(BuildContext context){final initials=name.trim().split(RegExp(r'\s+')).where((p)=>p.isNotEmpty).take(2).map((p)=>p[0].toUpperCase()).join();return Container(width:size,height:size,decoration:BoxDecoration(shape:BoxShape.circle,color:Colors.white.withValues(alpha:.15),border:Border.all(color:Colors.white.withValues(alpha:.55),width:2),boxShadow:[BoxShadow(color:Colors.black.withValues(alpha:.12),blurRadius:18,offset:const Offset(0,8))]),child:Center(child:Text(initials.isEmpty?'S':initials,style:TextStyle(color:Colors.white,fontSize:size*.31,fontWeight:FontWeight.w900))));}
}
class _AdminIdentity extends StatelessWidget {
  final StudentRecord record;const _AdminIdentity({required this.record});
  @override Widget build(BuildContext context)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(record.name,style:const TextStyle(color:Colors.white,fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:8),Text('${record.course} · ${record.year}',style:const TextStyle(color:Color(0xFFE1E7FF),fontSize:14,fontWeight:FontWeight.w600)),const SizedBox(height:7),Text(record.email,style:const TextStyle(color:Color(0xFFD2DBFF),fontSize:13))]);
}
class _AdminPill extends StatelessWidget {
  final IconData icon;final String text;const _AdminPill({required this.icon,required this.text});
  @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:8),decoration:BoxDecoration(color:Colors.white.withValues(alpha:.12),borderRadius:BorderRadius.circular(11),border:Border.all(color:Colors.white.withValues(alpha:.2))),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,size:15,color:const Color(0xFFE1E7FF)),const SizedBox(width:7),Text(text,style:const TextStyle(color:Colors.white,fontSize:11,fontWeight:FontWeight.w700))]));
}
class _AdminHeading extends StatelessWidget {
  final String eyebrow,title,subtitle;const _AdminHeading({required this.eyebrow,required this.title,required this.subtitle});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(eyebrow, style: const TextStyle(color: Color(0xFF77839A), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
      const SizedBox(height: 5),
      Text(title, style: const TextStyle(color: Color(0xFF17233D), fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: Color(0xFF68758D), fontSize: 13)),
    ],
  );
}
class _AdminMetric extends StatelessWidget {
  final double width;final IconData icon;final String label,value,note;final Color tint,accent;
  const _AdminMetric({required this.width,required this.icon,required this.label,required this.value,required this.note,required this.tint,required this.accent});
  @override Widget build(BuildContext context)=>SizedBox(width:width,child:Container(padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(18),border:Border.all(color:const Color(0xFFE7EBF3)),boxShadow:[BoxShadow(color:const Color(0xFF23345F).withValues(alpha:.035),blurRadius:14,offset:const Offset(0,5))]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Container(width:39,height:39,decoration:BoxDecoration(color:tint,borderRadius:BorderRadius.circular(12)),child:Icon(icon,color:accent,size:20)),const Spacer(),const Icon(Icons.trending_up_rounded,color:Color(0xFF9AA4B5),size:17)]),const SizedBox(height:16),Text(value,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Color(0xFF17233D),fontSize:23,fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(label,style:const TextStyle(color:Color(0xFF46536B),fontSize:10,fontWeight:FontWeight.w900,letterSpacing:.8)),const SizedBox(height:5),Text(note,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Color(0xFF8993A5),fontSize:11))])));
}
class _AdminPanel extends StatelessWidget {
  final IconData icon;final String title,subtitle;final Widget child;const _AdminPanel({required this.icon,required this.title,required this.subtitle,required this.child});
  @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(20),border:Border.all(color:const Color(0xFFE7EBF3)),boxShadow:[BoxShadow(color:const Color(0xFF23345F).withValues(alpha:.03),blurRadius:16,offset:const Offset(0,5))]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Container(width:40,height:40,decoration:BoxDecoration(color:const Color(0xFFEEF1FF),borderRadius:BorderRadius.circular(12)),child:Icon(icon,color:const Color(0xFF4057B2),size:21)),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(color:Color(0xFF17233D),fontSize:15,fontWeight:FontWeight.w900)),const SizedBox(height:3),Text(subtitle,style:const TextStyle(color:Color(0xFF8993A5),fontSize:11))]))]),const SizedBox(height:18),child]));
}
class _AdminRow extends StatelessWidget {
  final String label,value;final IconData icon;const _AdminRow({required this.label,required this.value,required this.icon});
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:10),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,size:17,color:const Color(0xFF8390A7)),const SizedBox(width:10),SizedBox(width:112,child:Text(label,style:const TextStyle(color:Color(0xFF7B879B),fontSize:12,fontWeight:FontWeight.w600))),const SizedBox(width:8),Expanded(child:Text(value,style:const TextStyle(color:Color(0xFF26334D),fontSize:12,fontWeight:FontWeight.w800)))]));
}
class _StudentDetailLine extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _StudentDetailLine(this.label, this.value, this.icon);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 20, color: const Color(0xFF4057B2)), const SizedBox(width: 12),
      SizedBox(width: 105, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
      Expanded(child: Text(value)),
    ]));
}


/// Responsive student dashboard used as the Flutter Web landing page.
class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'Overview': GlobalKey(),
    'Education': GlobalKey(),
    'Skills': GlobalKey(),
    'Projects': GlobalKey(),
    'Achievements': GlobalKey(),
    'Contact': GlobalKey(),
    'Experiments': GlobalKey(),
  };

  void _goTo(String section) {
    final context = _sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 450), curve: Curves.easeInOut, alignment: 0.04);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.school_rounded, color: Color(0xFF4057B2)),
            SizedBox(width: 10),
            Text('Student Profile App', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
        actions: [
          if (wide)
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(color: const Color(0xFFE8F7EE), borderRadius: BorderRadius.circular(30)),
                  child: const Text('Student Portfolio', style: TextStyle(color: Color(0xFF247044), fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
            ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth >= 1200 ? 1120.0 : 920.0;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: wide ? 28 : 16, vertical: 24),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _sectionKeys.keys.map((section) => ActionChip(
                    label: Text(section),
                    avatar: Icon(_sectionIcon(section), size: 17),
                    onPressed: () => _goTo(section),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE1E6F0)),
                  )).toList(),
                ),
                const SizedBox(height: 22),
                Container(
                  key: _sectionKeys['Overview'],
                  padding: EdgeInsets.all(wide ? 30 : 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF263B83), Color(0xFF536BD1)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: wide
                    ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        _avatar(82),
                        const SizedBox(width: 24),
                        const Expanded(child: _HeroCopy()),
                        const SizedBox(width: 18),
                        const _AvailabilityTag(),
                      ])
                    : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _avatar(72),
                        const SizedBox(height: 18),
                        const _HeroCopy(),
                        const SizedBox(height: 18),
                        const _AvailabilityTag(),
                      ]),
                ),
                const SizedBox(height: 18),
                GridView.count(
                  crossAxisCount: wide ? 4 : constraints.maxWidth >= 520 ? 2 : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: wide ? 1.8 : constraints.maxWidth >= 520 ? 2.1 : 3.4,
                  children: const [
                    _StatCard(icon: Icons.school_outlined, label: 'Degree', value: 'B.Tech CSE'),
                    _StatCard(icon: Icons.grade_outlined, label: 'CGPA', value: '9.2'),
                    _StatCard(icon: Icons.code_rounded, label: 'Focus', value: 'Development'),
                    _StatCard(icon: Icons.location_on_outlined, label: 'Location', value: 'Hyderabad'),
                  ],
                ),
                const SizedBox(height: 28),
                _sectionTitle('Education', 'Academic background', Icons.school_outlined, _sectionKeys['Education']),
                const SizedBox(height: 12),
                _panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('B.Tech — Computer Science and Engineering', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  SizedBox(height: 7),
                  Text('Ace Engineering College · Hyderabad, Telangana', style: TextStyle(color: Color(0xFF5F6B80))),
                  SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    _Pill(text: 'CGPA: 9.2'),
                    _Pill(text: 'Undergraduate'),
                    _Pill(text: 'Expected graduation: 2028'),
                  ]),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Skills', 'Tools I am learning and using', Icons.build_outlined, _sectionKeys['Skills']),
                const SizedBox(height: 12),
                _panel(child: Wrap(spacing: 10, runSpacing: 10, children: const [
                  _SkillChip(label: 'Python', icon: Icons.code),
                  _SkillChip(label: 'Java', icon: Icons.coffee_outlined),
                  _SkillChip(label: 'C', icon: Icons.terminal),
                  _SkillChip(label: 'Dart', icon: Icons.flutter_dash),
                  _SkillChip(label: 'Flutter', icon: Icons.phone_android),
                  _SkillChip(label: 'DSA', icon: Icons.account_tree_outlined),
                  _SkillChip(label: 'REST APIs', icon: Icons.cloud_outlined),
                  _SkillChip(label: 'Git & GitHub', icon: Icons.commit),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Projects', 'Things I have worked on', Icons.folder_open_outlined, _sectionKeys['Projects']),
                const SizedBox(height: 12),
                LayoutBuilder(builder: (context, box) {
                  final columns = box.maxWidth >= 700 ? 2 : 1;
                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: columns == 2 ? 1.5 : 2.0,
                    children: [
                      _ProjectCard(
                        icon: Icons.person_outline_rounded,
                        title: 'Student Profile App',
                        description: 'A responsive Flutter app demonstrating reusable widgets, forms, state management, animations and API integration.',
                        tags: const ['Flutter', 'Dart', 'Provider'],
                        onTap: () => _goTo('Experiments'),
                      ),
                      _ProjectCard(
                        icon: Icons.school_outlined,
                        title: 'Student Grade Tracker',
                        description: 'A programming project focused on recording student marks and presenting grade information.',
                        tags: const ['Python', 'Logic', 'GitHub'],
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add your project demo URL here when ready.'))),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 28),
                _sectionTitle('Achievements', 'Progress worth highlighting', Icons.emoji_events_outlined, _sectionKeys['Achievements']),
                const SizedBox(height: 12),
                _panel(child: const Column(children: [
                  _AchievementRow(icon: Icons.menu_book_outlined, title: 'Consistent learning', subtitle: 'Practising programming and core computer science concepts.'),
                  Divider(height: 24),
                  _AchievementRow(icon: Icons.verified_outlined, title: 'NPTEL course', subtitle: 'Completed an NPTEL course.'),
                  Divider(height: 24),
                  _AchievementRow(icon: Icons.code_rounded, title: 'Coding practice', subtitle: 'Building problem-solving skills through coding exercises.'),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Contact', 'Let’s connect', Icons.mail_outline, _sectionKeys['Contact']),
                const SizedBox(height: 12),
                _panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Interested in internships, projects and learning opportunities.', style: TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 14),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Replace this with your preferred contact email.'))),
                      icon: const Icon(Icons.email_outlined),
                      label: const Text('Email'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add your GitHub profile URL to this button.'))),
                      icon: const Icon(Icons.code),
                      label: const Text('GitHub'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add your LinkedIn profile URL to this button.'))),
                      icon: const Icon(Icons.work_outline),
                      label: const Text('LinkedIn'),
                    ),
                  ]),
                ])),
                const SizedBox(height: 28),
                _sectionTitle('Experiments', 'Flutter learning lab · 1–10', Icons.science_outlined, _sectionKeys['Experiments']),
                const SizedBox(height: 12),
                ...HomeScreen.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Color(0xFFE5E9F2))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: CircleAvatar(backgroundColor: const Color(0xFFEEF1FF), child: Icon(item.icon, color: const Color(0xFF4057B2))),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(item.subtitle),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                const Center(child: Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('Built with Flutter · Student Profile App', style: TextStyle(color: Color(0xFF7B8496), fontSize: 12)),
                )),
              ],
            ),
          ),
        );
      }),
    );
  }

  IconData _sectionIcon(String section) {
    switch (section) {
      case 'Overview': return Icons.home_outlined;
      case 'Education': return Icons.school_outlined;
      case 'Skills': return Icons.build_outlined;
      case 'Projects': return Icons.folder_open_outlined;
      case 'Achievements': return Icons.emoji_events_outlined;
      case 'Contact': return Icons.mail_outline;
      default: return Icons.science_outlined;
    }
  }

  Widget _avatar(double radius) => CircleAvatar(
    radius: radius / 2,
    backgroundColor: Colors.white.withValues(alpha: 0.18),
    child: Icon(Icons.person_rounded, size: radius * 0.56, color: Colors.white),
  );

  Widget _sectionTitle(String title, String subtitle, IconData icon, GlobalKey? key) => Padding(
    key: key,
    padding: const EdgeInsets.only(top: 2),
    child: Row(children: [
      Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE9EDFF), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF4057B2))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937))),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
      ])),
    ]),
  );

  Widget _panel({required Widget child}) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE5E9F2))),
    child: child,
  );
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();
  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('HELLO, I AM', style: TextStyle(color: Color(0xFFD8DFFF), letterSpacing: 1.7, fontSize: 11, fontWeight: FontWeight.w800)),
      SizedBox(height: 8),
      Text('G. Asish', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800, height: 1.1)),
      SizedBox(height: 8),
      Text('Computer Science Engineering Student', style: TextStyle(color: Colors.white, fontSize: 15)),
      SizedBox(height: 8),
      Text('Learning, building and improving one project at a time.', style: TextStyle(color: Color(0xFFE0E6FF), fontSize: 13, height: 1.4)),
    ],
  );
}

class _AvailabilityTag extends StatelessWidget {
  const _AvailabilityTag();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withValues(alpha: 0.25))),
    child: const Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.circle, size: 8, color: Color(0xFF8FE0B1)),
      SizedBox(width: 8),
      Text('Open to opportunities', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E9F2))),
    child: Row(children: [
      Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFEEF1FF), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF4057B2), size: 20)),
      const SizedBox(width: 10),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Color(0xFF7B8496), fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(color: Color(0xFF263248), fontWeight: FontWeight.w800, fontSize: 14)),
      ])),
    ]),
  );
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(color: const Color(0xFFF0F3FF), borderRadius: BorderRadius.circular(30)),
    child: Text(text, style: const TextStyle(color: Color(0xFF4057B2), fontSize: 12, fontWeight: FontWeight.w700)),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SkillChip({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 17, color: const Color(0xFF4057B2)),
    label: Text(label),
    backgroundColor: const Color(0xFFF7F8FC),
    side: const BorderSide(color: Color(0xFFE1E6F0)),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
  );
}

class _ProjectCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final VoidCallback onTap;
  const _ProjectCard({required this.icon, required this.title, required this.description, required this.tags, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE5E9F2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE9EDFF), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF4057B2))),
          const Spacer(),
          const Icon(Icons.north_east_rounded, color: Color(0xFF8B95A7), size: 18),
        ]),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 7),
        Expanded(child: Text(description, style: const TextStyle(color: Color(0xFF667085), height: 1.4, fontSize: 13))),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: tags.map((tag) => _Pill(text: tag)).toList()),
      ]),
    ),
  );
}

class _AchievementRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _AchievementRow({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFE9EDFF), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF4057B2), size: 20)),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(color: Color(0xFF667085), height: 1.4, fontSize: 13)),
    ])),
  ]);
}