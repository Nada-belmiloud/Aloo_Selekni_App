import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'role_selection_screen.dart';
import '../widgets/settings_icon.dart';
import '../../l10n/app_localizations.dart';
import 'settings.dart';
import '../../data/models/volunteer.dart';
import 'firebase_test_screen.dart'; 
import '../widgets/bottom_navbar_wrapper.dart'; 

class EmergencyButtonScreen extends StatelessWidget {
  final Volunteer currentVolunteer;

  const EmergencyButtonScreen({Key? key, required this.currentVolunteer})
      : super(key: key);

  Future<void> _makeEmergencyCall(BuildContext context) async {
    final Uri phoneUri = Uri.parse('tel:14');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorOccurred} $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Header with settings icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SettingsIcon(volunteer: currentVolunteer), //  Pass volunteer
                ],
              ),
              const SizedBox(height: 20),

              // Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      AppLocalizations.of(context)!.emergencyTitle,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Subtitle
                    Text(
                      AppLocalizations.of(context)!.emergencySubtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Emergency button
                    GestureDetector(
                      onTap: () => _makeEmergencyCall(context),
                      child: Container(
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFFE74C3C),
                              Color.fromARGB(255, 147, 36, 36),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 30,
                            ),
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              blurRadius: 60,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.touch_app,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Skip button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RoleSelectionScreen(volunteer: currentVolunteer),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF4A8BB3),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.skipButton,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FirebaseTestScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF4A8BB3),
        tooltip: 'Test Firebase Connection',
        child: const Icon(Icons.cloud_done, color: Colors.white),
      ),
    );
  }
}
