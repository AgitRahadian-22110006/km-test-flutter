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
        title: Text(
          'Palindrome Check Suitmedia',
          style: TextStyle(color: Colors.teal.shade900),
        ),
        content: Row(
          children: [
            Icon(
              result ? Icons.check_circle : Icons.cancel,
              color: result ? Colors.green : Colors.redAccent,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                result ? '✔ is Palindrome' : '❌ not palindrome',
                style: TextStyle(
                  fontSize: 16,
                  color: result ? Colors.green.shade700 : Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.teal.shade700,
            ),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Screen2()),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _sentenceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsiveness: adapt padding based on screen width
    final isWide = MediaQuery.of(context).size.width > 600;
    final sidePadding = isWide ? 100.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        elevation: 1,
        title: const Text('Palindrome Checker Suitmedia'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter Your Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isWide ? 32 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 32),
            _buildInputField(
              controller: _nameCtrl,
              label: 'Your Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 24),
            _buildInputField(
              controller: _sentenceCtrl,
              label: 'Sentence to Check',
              icon: Icons.text_snippet,
            ),
            const SizedBox(height: 36),
            ElevatedButton.icon(
              onPressed: _checkPalindrome,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Check Palindrome'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _goToNextScreen,
              icon: const Icon(Icons.arrow_forward_ios),
              label: const Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade800,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Colors.teal.shade700,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal.shade700),
        prefixIcon: Icon(icon, color: Colors.teal.shade700),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
        ),
      ),
    );
  }
}
