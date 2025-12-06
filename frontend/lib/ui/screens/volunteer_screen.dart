import 'package:flutter/material.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاب نتطوع'),
        backgroundColor: const Color(0xFF5B9FCA),
      ),
      body: const Center(
        child: Text(
          'Volunteer Screen\nBecome a responder',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
