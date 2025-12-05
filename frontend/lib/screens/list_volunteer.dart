import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/volunteer_card.dart';

class VolunteerListScreen extends StatefulWidget {
  final String? wilaya;

  const VolunteerListScreen({Key? key, this.wilaya}) : super(key: key);

  @override
  State<VolunteerListScreen> createState() => _VolunteerListScreenState();
}

class _VolunteerListScreenState extends State<VolunteerListScreen> {
  final List<Map<String, dynamic>> volunteers = List.generate(
    20,
    (index) => {
      'name': 'اسم المتطوع ${index + 1}',
      'location': 'الجزائر',
      'phone': '00987654321',
      'image': 'assets/images/profile.png',
    },
  );

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 250.0; // Reduced header height
    const double whiteContainerTop = 250.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: null,
      body: Stack(
        children: [
          // 1. IMAGE HEADER SECTION with Gradient Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Actual Image
                Image.asset(
                  'assets/images/volunteer back.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF5B9FCA),
                            const Color(0xFF5B9FCA).withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Header Image Missing',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                // Gradient Overlay
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

          // 2. Back Button (Manually positioned)
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 3. Title (Manually positioned below the Status Bar area)
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Text(
                'قائمة المسعفين',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

    
          

          
          Positioned(
            top: whiteContainerTop + 20, // Cards start 20px below white container
            left: 20,
            right: 20,
            bottom: 10, // Leave space for bottom navbar
            child: ListView.separated(
  padding: const EdgeInsets.only(top: 10),
  itemCount: volunteers.length,
  separatorBuilder: (_, __) => const SizedBox(height: 10),
  itemBuilder: (context, index) {
    final volunteer = volunteers[index]; // inside a block {}
    return VolunteerCard(
      imagePath: volunteer['image'],
      name: volunteer['name'],
      location: volunteer['location'],
      onCall: () => _makePhoneCall(volunteer['phone']),
    );
  },
),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        // optional: handle emergency button
        // onEmergencyTap: () { ... },
      ),
    );
    
  }
Future<void> _makePhoneCall(String phoneNumber) async {
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('اتصال بـ $phoneNumber'),
        backgroundColor: Colors.green,
      ),
    );
  }
}


}