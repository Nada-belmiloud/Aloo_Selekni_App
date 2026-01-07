import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/prevention_card.dart';
import '../widgets/page_header.dart';
import 'prevention_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import '../widgets/bottom_navbar_wrapper.dart'; 

class PreventionMethodsScreen extends StatelessWidget {
  final Volunteer volunteer; // <-- pass the volunteer

  const PreventionMethodsScreen({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final preventionItems = [
      {
        'title': local.fire,
        'icon': Icons.local_fire_department,
        'image': 'assets/images/fire background.jpeg',
      },
      {
        'title': local.trafficAccident,
        'icon': Icons.directions_car,
        'image': 'assets/images/accident backgound.jpeg',
      },
      {
        'title': local.earthquake,
        'icon': Icons.terrain,
        'image': 'assets/images/seiesm.jpeg',
      },
      {
        'title': local.flood,
        'icon': Icons.water_drop,
        'image': 'assets/images/fayadan back.jpeg',
      },
      // Add more items here with localization
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // PageHeader
      appBar: PageHeader(
        onBack: () => Navigator.pop(context),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 120),
          itemCount: preventionItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = preventionItems[index];
            return PreventionCard(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              imagePath: item['image'] as String,
              detailScreen: PreventionDetailScreen(
                title: item['title'] as String,
                icon: item['icon'] as IconData,
                imagePath: item['image'] as String,
                volunteer: volunteer, // <-- pass volunteer
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: BottomNavBarWrapper(
  selectedIndex: 0, // change per page
  volunteer: volunteer, // can be null if page doesn't have a volunteer
),

    );
  }
}
