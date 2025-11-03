import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'role_selection_screen.dart';

class EmergencyButtonScreen extends StatelessWidget {
  const EmergencyButtonScreen({Key? key}) : super(key: key);

  Future<void> _makeEmergencyCall(BuildContext context) async {
    final Uri phoneUri = Uri.parse('tel:14');
    
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يمكن فتح تطبيق الهاتف'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'كاين خطر!! محتاج نجدة؟',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'اضغط على الزر الكبير\nتنفس بعمق... كلشي يروح لباس',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                // Emergency button
                GestureDetector(
                  onTap: () => _makeEmergencyCall(context),
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFFE74C3C),
                          Color.fromARGB(255, 147, 36, 36),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 25, 0).withOpacity(0.2),
                          blurRadius: 60,
                          spreadRadius: 20,
                        ),
                        BoxShadow(
                          color: const Color.fromARGB(255, 236, 74, 56).withOpacity(0.1),
                          blurRadius: 90,
                          spreadRadius: 40,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.touch_app,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                // Skip button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoleSelectionScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF4A8BB3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'تخطى',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}