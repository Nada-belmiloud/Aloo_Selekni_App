import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/register_screen.dart';

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
       initialRoute: '/roleSelection',
  routes: {
    '/roleSelection': (context) => const RoleSelectionScreen(),
    '/register': (context) => const RegisterScreen(),
  },
    );
  }
}