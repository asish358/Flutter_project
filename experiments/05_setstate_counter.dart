import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: CounterScreen(),
));

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  void change(int value) {
    setState(() => count = value < 0 ? 0 : value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Value', style: TextStyle(fontSize: 22)),
            Text('$count', style: const TextStyle(
              fontSize: 60, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: () => change(count + 1),
                child: const Text('Increase')),
            ElevatedButton(onPressed: () => change(count - 1),
                child: const Text('Decrease')),
            ElevatedButton(onPressed: () => change(0),
                child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
