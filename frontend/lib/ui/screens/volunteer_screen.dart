import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart'; 
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/bottom_navbar_wrapper.dart'; 
import '../../data/models/volunteer.dart';

class VolunteerScreen extends StatelessWidget {
  final Volunteer volunteer;
  const VolunteerScreen({Key? key, required this.volunteer}) : super(key: key);

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
      bottomNavigationBar: BottomNavBarWrapper(
  selectedIndex: 0, // change per page
  volunteer: volunteer, // can be null if page doesn't have a volunteer
),

    );
  }
}
