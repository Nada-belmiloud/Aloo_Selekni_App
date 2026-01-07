import 'package:flutter/material.dart';
import 'need_help_screen.dart';
import 'register_screen.dart';
import 'explore_screen.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/explore_card.dart';
import '../widgets/page_header.dart';
import '../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/volunteer.dart';
import '../widgets/bottom_navbar_wrapper.dart'; 

class RoleSelectionScreen extends StatelessWidget {
  final Volunteer volunteer; // <-- logged-in volunteer

  const RoleSelectionScreen({Key? key, required this.volunteer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    const double headerHeight = 170.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PageHeader(onBack: () => Navigator.pop(context)),
      body: Stack(
        children: [
          // Background image + gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight + 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/help (1).jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF4A8BB3),
                          const Color(0xFF4A8BB3).withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        loc.headerImageMissing,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 71, 72, 73).withOpacity(0.5),
                        const Color.fromARGB(255, 17, 17, 18).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Header text over image
          Positioned(
            top: MediaQuery.of(context).padding.top + 40,
            left: 0,
            right: 0,
            child: Text(
              loc.roleSelectionHeader,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // White content background
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(color: const Color(0xFFF5F5F5)),
          ),

          // Explore cards
          Positioned(
            top: 210,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExploreCard(
                    title: loc.needHelpCard,
                    imagePath: 'assets/images/ambulance.png',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NeedHelpScreen(volunteer: volunteer),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ExploreCard(
                    title: loc.volunteerCard,
                    imagePath: 'assets/images/volunteer.png',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ExploreCard(
                    title: loc.exploreCard,
                    imagePath: 'assets/images/explore.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExploreScreen(volunteer: volunteer),
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
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1, // HOME
        currentVolunteer: volunteer,
        onEmergencyTap: () async {
          final Uri phoneUri = Uri.parse('tel:14');
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }
}
