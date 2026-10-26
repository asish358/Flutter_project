import 'package:flutter/material.dart';
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
        home: const HomeScreen(),
        routes: {
          '/responsive': (_) => const ResponsiveScreen(),
          '/state': (_) => const StateScreen(),
          '/form': (_) => const StudentFormScreen(),
          '/animation': (_) => const AnimationScreen(),
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
