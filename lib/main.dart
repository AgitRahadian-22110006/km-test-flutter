import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screen1.dart';
import 'state/user_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App Agit Rahadian',
      debugShowCheckedModeBanner: false,

      // --------- THEME SETUP ---------
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,

        // Primary colors
        primaryColor: Colors.teal.shade700,
        primarySwatch: Colors.teal,

        // Scaffold background
        scaffoldBackgroundColor: const Color(0xFFF4FAF9),

        // AppBar style
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade700,
          elevation: 2,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Text styles
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade900,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.teal.shade700,
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          labelStyle: TextStyle(
            color: Colors.teal.shade700,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal.shade300, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal.shade300, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
          ),
        ),

        // Button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade600,
            foregroundColor: Colors.white,
            elevation: 2,
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Card style
       cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),

      // Dark theme
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal.shade300,
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade900,
          titleTextStyle: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,

      // Entry point
      home: const Screen1(),
    );
  }
}
