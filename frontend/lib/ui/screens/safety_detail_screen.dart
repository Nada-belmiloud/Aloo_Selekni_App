import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/page_header.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import '../widgets/bottom_navbar_wrapper.dart'; 

class SafetyDetailScreen extends StatelessWidget {
  final Volunteer volunteer; // <-- pass the volunteer
  final String accidentKey;  // key for type of accident
  final String title;        // localized title
  final IconData icon;
  final String imagePath;

  const SafetyDetailScreen({
    Key? key,
    required this.volunteer, // <-- required volunteer
    required this.accidentKey,
    required this.title,
    required this.icon,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safetyInstructions = _getSafetyInstructions(context, accidentKey);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // PageHeader at the top
          PageHeader(
            onBack: () => Navigator.pop(context),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.safetyInstructions,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE57373),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE57373).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.health_and_safety_outlined,
                                    color: Color(0xFFE57373),
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            ...safetyInstructions.asMap().entries.map((entry) {
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
                                        color: const Color(0xFFE57373),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWrapper(
  selectedIndex: 0, // change per page
  volunteer: volunteer, // can be null if page doesn't have a volunteer
),

    );
  }

  List<String> _getSafetyInstructions(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;

    switch (key) {
      case 'fire':
        return [
          loc.fireSafety1,
          loc.fireSafety2,
          loc.fireSafety3,
          loc.fireSafety4,
          loc.fireSafety5,
          loc.fireSafety6,
          loc.fireSafety7,
        ];
      case 'trafficAccident':
        return [
          loc.trafficAccidentSafety1,
          loc.trafficAccidentSafety2,
          loc.trafficAccidentSafety3,
          loc.trafficAccidentSafety4,
          loc.trafficAccidentSafety5,
          loc.trafficAccidentSafety6,
          loc.trafficAccidentSafety7,
        ];
      case 'earthquake':
        return [
          loc.earthquakeSafety1,
          loc.earthquakeSafety2,
          loc.earthquakeSafety3,
        ];
      case 'flood':
        return [
          loc.floodSafety1,
          loc.floodSafety2,
          loc.floodSafety3,
        ];
      case 'buildingCollapse':
        return [
          loc.buildingCollapseSafety1,
          loc.buildingCollapseSafety2,
          loc.buildingCollapseSafety3,
        ];
      case 'electricShock':
        return [
          loc.electricShockSafety1,
          loc.electricShockSafety2,
          loc.electricShockSafety3,
        ];
      case 'drowning':
        return [
          loc.drowningSafety1,
          loc.drowningSafety2,
          loc.drowningSafety3,
        ];
      case 'poisoning':
        return [
          loc.poisoningSafety1,
          loc.poisoningSafety2,
          loc.poisoningSafety3,
        ];
      case 'suffocation':
        return [
          loc.suffocationSafety1,
          loc.suffocationSafety2,
          loc.suffocationSafety3,
        ];
      default:
        return [loc.noSafetyInfoAvailable];
    }
  }
}
