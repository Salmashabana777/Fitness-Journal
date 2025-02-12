import 'package:flutter/material.dart';
import 'package:live_well/splashscreen.dart';
import 'package:live_well/quiz_screen.dart';
import 'package:live_well/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6D3B47), // Deep Mauve
          secondary: const Color(0xFFFFD28E), // Apricot
          background: const Color(0xFFFFF7E6), // Ivory Warm
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
            letterSpacing: 2,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/quiz': (context) => QuizScreen(),
      },
    );
  }
}
