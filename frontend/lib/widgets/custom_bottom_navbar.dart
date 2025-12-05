import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback? onEmergencyTap;

  const CustomBottomNavBar({Key? key, this.onEmergencyTap}) : super(key: key);

  void _handleNavigation(BuildContext context, String routeName) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute == routeName) return; // Already on this page

    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Navigation Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.person_rounded,
                  label: 'الملف الشخصي',
                  routeName: '/register',
                  isActive: currentRoute == '/register',
                ),
                const SizedBox(width: 100), // Spacer for center button
                _buildNavItem(
                  context: context,
                  icon: Icons.home_rounded,
                  label: 'الرئيسية',
                  routeName: '/roleSelection',
                  isActive: currentRoute == '/roleSelection',
                ),
              ],
            ),
          ),
          // Emergency Button
          Positioned(
            top: -35,
            child: GestureDetector(
              onTap: onEmergencyTap,
              child: Image.asset(
                'assets/images/Button.png',
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.red[600]!, Colors.red[400]!],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 35,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String routeName,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () => _handleNavigation(context, routeName),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF4A8BB3) : Colors.grey[400],
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? const Color(0xFF4A8BB3) : Colors.grey[400],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
