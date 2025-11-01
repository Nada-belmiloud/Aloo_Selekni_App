import 'package:flutter/material.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الشاشة الرئيسية',
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A8BB3),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'مرحباً في التطبيق',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}