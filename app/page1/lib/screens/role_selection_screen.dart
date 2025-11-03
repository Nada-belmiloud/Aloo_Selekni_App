import 'package:flutter/material.dart';
import 'need_help_screen.dart';
import 'volunteer_screen.dart';
import 'explore_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A8BB3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A8BB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Blue background section
          Column(
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'واش راك حاب تدير؟',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 16, 16, 16),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          // White container with cards
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
            ),
          ),
          // Cards overlaying the blue section
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Need Help Card
                  _buildRoleCard(
                    context,
                    title: 'اختر اقرب مسعف',
                    imagePath: 'assets/images/ambulance.png', 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NeedHelpScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  // Volunteer Card
                  _buildRoleCard(
                    context,
                    title: 'حاب نتطوع !',
                    imagePath: 'assets/images/volunteer.png', 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VolunteerScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  // Explore Card
                  _buildRoleCard(
                    context,
                    title: 'استكشاف',
                    imagePath: 'assets/images/explore.png', // Replace with your image path
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExploreScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  // Emergency Button with Image
                  Image.asset(
                    'assets/images/Button.png', // Replace with your button image path
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if image not found
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                 
                  const Text(
                    'راك في خطر؟ محتاج نجدة؟',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 12, 12, 12),
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            // Image on the right
            Image.asset(
              imagePath,
              width: 70,
              height: 70,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if image not found
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    color: Colors.red,
                    size: 35,
                  ),
                );
              },
            ),
            // Text in the center
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}