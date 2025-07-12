import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/user_state.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final _nameCtrl = TextEditingController();
  final _sentenceCtrl = TextEditingController();

  bool isPalindrome(String text) {
    final clean = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    return clean == clean.split('').reversed.join();
  }

  void _checkPalindrome() {
    final input = _sentenceCtrl.text.trim();
    if (input.isEmpty) return;
    final result = isPalindrome(input);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Palindrome Check'),
        content: Row(
          children: [
            Icon(result ? Icons.check_circle : Icons.cancel,
                color: result ? Colors.green : Colors.red),
            const SizedBox(width: 12),
            Text(result ? '✔ isPalindrome' : '❌ not palindrome'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _goToNextScreen() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    context.read<UserState>().setName(name);
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Screen2()));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _sentenceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome Checker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Enter Your Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Your Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _sentenceCtrl,
              decoration: InputDecoration(
                labelText: 'Sentence to Check',
                prefixIcon: const Icon(Icons.text_snippet),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _checkPalindrome,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Check Palindrome'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _goToNextScreen,
              icon: const Icon(Icons.arrow_forward_ios),
              label: const Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
