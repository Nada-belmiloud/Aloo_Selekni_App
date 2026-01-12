import 'package:flutter/material.dart';
import 'custom_bottom_navbar.dart';
import '../../data/models/volunteer.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBarWrapper extends StatelessWidget {
  final Volunteer? volunteer; // <-- make nullable
  final int selectedIndex;

  const BottomNavBarWrapper({
    Key? key,
    this.volunteer, // <-- nullable
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      selectedIndex: selectedIndex,
      currentVolunteer: volunteer, // can be null
      onEmergencyTap: () async {
        final Uri phoneUri = Uri.parse('tel:14');
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
