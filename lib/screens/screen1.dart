// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(
          'SUITMEDIA',
          style: TextStyle(color: Colors.purpleAccent.shade100),
        ),
        content: Row(
          children: [
            Icon(
              result ? Icons.check_circle : Icons.cancel,
              color: result ? Colors.greenAccent : Colors.redAccent,
              size: 28,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                result ? '✔ is Palindrome' : '❌ not palindrome',
                style: TextStyle(
                  fontSize: 16,
                  color: result ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: Colors.purpleAccent.shade100)),
          ),
        ],
      ),
    );
  }

  void _goToNextScreen() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    context.read<UserState>().setName(name);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Screen2()),
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
    final isWide = MediaQuery.of(context).size.width > 600;
    final sidePadding = isWide ? 120.0 : 24.0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2), // neon purple
              Color(0xFF4A00E0), // deep purple
              Color(0xFF000428), // dark navy
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Palindrome Checker Suitmedia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isWide ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent.shade100,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black87,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.purpleAccent.shade100.withValues(alpha: 76)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Enter Your Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.purpleAccent.shade100,
                        ),
                      ),
                      SizedBox(height: 24),
                      _buildInputField(
                        controller: _nameCtrl,
                        label: 'Your Name',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 20),
                      _buildInputField(
                        controller: _sentenceCtrl,
                        label: 'Sentence to Check',
                        icon: Icons.create_outlined,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _checkPalindrome,
                        icon: Icon(Icons.check_circle_outline),
                        label: Text('Check Palindrome'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent.shade100,
                          foregroundColor: Colors.black87,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _goToNextScreen,
                        icon: Icon(Icons.arrow_forward_ios),
                        label: Text('Next'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade400,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
      cursorColor: Colors.purpleAccent.shade100,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.purpleAccent.shade100),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white24, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purpleAccent.shade100, width: 2),
        ),
      ),
    );
  }
}
