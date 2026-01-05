import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart'; 
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';

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
      bottomNavigationBar: CustomBottomNavBar(
          onEmergencyTap: () async {
            // Make emergency call to 14
            final Uri phoneUri = Uri.parse('tel:14');
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
    );
  }
}
