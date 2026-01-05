import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/page_header.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';

class PreventionDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;
  final Volunteer volunteer; // <-- add volunteer here

  const PreventionDetailScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.imagePath,
    required this.volunteer, // required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preventionMethods = _getPreventionMethods(context, title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // Header
      appBar: PageHeader(
        onBack: () => Navigator.pop(context),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Prevention methods
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.preventionMethods,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A8BB3),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A8BB3).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: Color(0xFF4A8BB3),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // List of prevention methods
                  ...preventionMethods.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6, left: 12),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A8BB3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 17,
                                height: 1.7,
                                color: Colors.black87,
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentVolunteer: volunteer, // use the passed volunteer
        onEmergencyTap: () async {
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

  List<String> _getPreventionMethods(BuildContext context, String accidentType) {
    final loc = AppLocalizations.of(context)!;
    switch (accidentType) {
      case 'حريق':
        return [
          loc.firePrevention1,
          loc.firePrevention2,
          loc.firePrevention3,
          loc.firePrevention4,
          loc.firePrevention5,
          loc.firePrevention6,
          loc.firePrevention7,
        ];
      case 'حادث مروري':
        return [
          loc.trafficAccidentPrevention1,
          loc.trafficAccidentPrevention2,
          loc.trafficAccidentPrevention3,
          loc.trafficAccidentPrevention4,
          loc.trafficAccidentPrevention5,
          loc.trafficAccidentPrevention6,
          loc.trafficAccidentPrevention7,
        ];
      case 'اختناق':
        return [
          loc.suffocationPrevention1,
          loc.suffocationPrevention2,
          loc.suffocationPrevention3,
          loc.suffocationPrevention4,
          loc.suffocationPrevention5,
        ];
      case 'غرق':
        return [
          loc.drowningPrevention1,
          loc.drowningPrevention2,
          loc.drowningPrevention3,
          loc.drowningPrevention4,
          loc.drowningPrevention5,
        ];
      case 'حروق':
        return [
          loc.burnPrevention1,
          loc.burnPrevention2,
          loc.burnPrevention3,
          loc.burnPrevention4,
          loc.burnPrevention5,
        ];
      case 'كسور':
        return [
          loc.fracturePrevention1,
          loc.fracturePrevention2,
          loc.fracturePrevention3,
          loc.fracturePrevention4,
          loc.fracturePrevention5,
        ];
      case 'تسمم':
        return [
          loc.poisoningPrevention1,
          loc.poisoningPrevention2,
          loc.poisoningPrevention3,
          loc.poisoningPrevention4,
        ];
      default:
        return [loc.noPreventionInfoAvailable];
    }
  }
}
