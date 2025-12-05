import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/accident_card.dart'; // <-- import new widget

class SafetyInstructionsScreen extends StatelessWidget {
  const SafetyInstructionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A8BB3),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'إرشادات السلامة',
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
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            AccidentCard(
              title: 'حريق',
              icon: Icons.local_fire_department,
              imagePath: 'assets/images/fire background.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'حادث مروري',
              icon: Icons.directions_car,
              imagePath: 'assets/images/accident backgound.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'زلزال',
              icon: Icons.terrain,
              imagePath: 'assets/images/seiesm.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'فيضان',
              icon: Icons.water_drop,
              imagePath: 'assets/images/fayadan back.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'انهيار مبنى',
              icon: Icons.business,
              imagePath: 'assets/images/fayadan back.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'حادث كهربائي',
              icon: Icons.electrical_services,
              imagePath: 'assets/images/electri back.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'إصابات',
              icon: Icons.monitor_heart,
              imagePath: 'assets/images/isabat.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'غرق',
              icon: Icons.waves,
              imagePath: 'assets/images/drown.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'تسمم',
              icon: Icons.dangerous,
              imagePath: 'assets/images/toxic.jpeg',
            ),
            SizedBox(height: 16),
            AccidentCard(
              title: 'اختناق',
              icon: Icons.air,
              imagePath: 'assets/images/no breath.jpeg',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
