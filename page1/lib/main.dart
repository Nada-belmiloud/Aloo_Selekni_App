import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const EmergencyApp());
}

class EmergencyApp extends StatelessWidget {
  const EmergencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency App',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4A8BB3),
      ),
      // Add RTL support
      locale: const Locale('ar', 'DZ'),
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}