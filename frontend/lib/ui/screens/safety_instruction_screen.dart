import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/accident_card.dart';
import '../widgets/page_header.dart';
import '../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/volunteer.dart';

class SafetyInstructionsScreen extends StatelessWidget {
  final Volunteer volunteer;

  const SafetyInstructionsScreen({Key? key, required this.volunteer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final accidents = [
      {
        'title': local.fire,
        'icon': Icons.local_fire_department,
        'image': 'assets/images/fire background.jpeg',
        'key': 'fire',
      },
      {
        'title': local.trafficAccident,
        'icon': Icons.directions_car,
        'image': 'assets/images/accident backgound.jpeg',
        'key': 'trafficAccident',
      },
      {
        'title': local.earthquake,
        'icon': Icons.terrain,
        'image': 'assets/images/seiesm.jpeg',
        'key': 'earthquake',
      },
      {
        'title': local.flood,
        'icon': Icons.water_drop,
        'image': 'assets/images/fayadan back.jpeg',
        'key': 'flood',
      },
      {
        'title': local.buildingCollapse,
        'icon': Icons.business,
        'image': 'assets/images/fayadan back.jpeg',
        'key': 'buildingCollapse',
      },
      {
        'title': local.electricAccident,
        'icon': Icons.electrical_services,
        'image': 'assets/images/electri back.jpeg',
        'key': 'electricShock',
      },
      {
        'title': local.injuries,
        'icon': Icons.monitor_heart,
        'image': 'assets/images/isabat.jpeg',
        'key': 'injuries',
      },
      {
        'title': local.drowning,
        'icon': Icons.waves,
        'image': 'assets/images/drown.jpeg',
        'key': 'drowning',
      },
      {
        'title': local.poisoning,
        'icon': Icons.dangerous,
        'image': 'assets/images/toxic.jpeg',
        'key': 'poisoning',
      },
      {
        'title': local.suffocation,
        'icon': Icons.air,
        'image': 'assets/images/no breath.jpeg',
        'key': 'suffocation',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          PageHeader(
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: accidents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final accident = accidents[index];
                  return AccidentCard(
                    title: accident['title'] as String,
                    icon: accident['icon'] as IconData,
                    imagePath: accident['image'] as String,
                    accidentKey: accident['key'] as String,
                    volunteer: volunteer,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentVolunteer: volunteer,
        onEmergencyTap: () async {
          final Uri phoneUri = Uri.parse('tel:14');
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(local.cannotOpenPhoneApp),
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
