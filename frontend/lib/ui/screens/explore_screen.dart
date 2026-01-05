import 'package:flutter/material.dart';
import 'list_volunteer.dart';
import 'prevention_method_screen.dart';
import 'safety_instruction_screen.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/explore_card.dart';
import '../widgets/page_header.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';

class ExploreScreen extends StatelessWidget {
  final Volunteer volunteer;

  const ExploreScreen({Key? key, required this.volunteer}) : super(key: key);

  Future<void> _makeEmergencyCall(BuildContext context) async {
    final Uri phoneUri = Uri.parse('tel:14');
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
  }

  @override
  Widget build(BuildContext context) {
    const double whiteContainerTop = 300.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PageHeader(onBack: () => Navigator.pop(context)),
      body: Stack(
        children: [
          // Header image with gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: whiteContainerTop,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/explore back.jpg', fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 71, 72, 73).withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Title text
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: Text(
              AppLocalizations.of(context)!.exploreTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // White background container
          Positioned(
            top: 320,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(color: const Color(0xFFF5F5F5)),
          ),

          // Cards section
          Positioned(
            top: 230,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExploreCard(
                    title: AppLocalizations.of(context)!.preventionMethods,
                    imagePath: 'assets/images/explore.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PreventionMethodsScreen(volunteer: volunteer),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ExploreCard(
                    title: AppLocalizations.of(context)!.safetyInstructions,
                    imagePath: 'assets/images/ambulance.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SafetyInstructionsScreen(volunteer: volunteer),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ExploreCard(
                    title: AppLocalizations.of(context)!.volunteerList,
                    imagePath: 'assets/images/mos3if.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VolunteerListScreen(volunteer: volunteer),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentVolunteer: volunteer,
        onEmergencyTap: () => _makeEmergencyCall(context),
      ),
    );
  }
}
