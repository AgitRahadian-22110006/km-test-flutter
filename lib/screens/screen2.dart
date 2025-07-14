// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/user_state.dart';
import 'screen3.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final st = context.watch<UserState>();
    final isWide = MediaQuery.of(context).size.width > 600;
    final horizontalPadding = isWide ? 80.0 : 24.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A00E0), // deep purple
              Color(0xFF8E2DE2), // neon violet
              Color(0xFF000428), // midnight
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isWide ? 40 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tombol kembali
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hello, ${st.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isWide ? 28 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent.shade100,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black87,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // info card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.purpleAccent.shade100.withValues(alpha: 76),
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle,
                              size: 28, color: Colors.purpleAccent.shade100),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              st.name.isNotEmpty
                                  ? 'Your Name: ${st.name}'
                                  : 'Name not set',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purpleAccent.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24, thickness: 1),
                      const SizedBox(height: 16),
                      if (st.selectedUserName.isNotEmpty) ...[
                        Text(
                          'Selected User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.purpleAccent.shade100,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(st.selectedUserAvatar),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          st.selectedUserName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          st.selectedUserEmail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'No user selected yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Screen3()),
                  ),
                  icon: const Icon(Icons.person_search),
                  label: const Text('Choose a User'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent.shade100,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
