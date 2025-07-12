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
      title: 'KM Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4FAF9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        colorScheme: const ColorScheme.dark(primary: Colors.teal),
      ),
      themeMode: ThemeMode.system,
      home: const Screen1(),
    );
  }
}
