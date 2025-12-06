import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/prevention_card.dart';
import 'prevention_detail_screen.dart';

class PreventionMethodsScreen extends StatelessWidget {
  const PreventionMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preventionItems = [
      {
        'title': 'حريق',
        'icon': Icons.local_fire_department,
        'image': 'assets/images/fire background.jpeg',
      },
      {
        'title': 'حادث مروري',
        'icon': Icons.directions_car,
        'image': 'assets/images/accident backgound.jpeg',
      },
      {
        'title': 'زلزال',
        'icon': Icons.terrain,
        'image': 'assets/images/seiesm.jpeg',
      },
      {
        'title': 'فيضان',
        'icon': Icons.water_drop,
        'image': 'assets/images/fayadan back.jpeg',
      },
      // Add more items here
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A8BB3),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'طرق الوقاية',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
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
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
