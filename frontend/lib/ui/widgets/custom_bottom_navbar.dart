import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import '../../ui/screens/profile_screen.dart';
import '../../ui/screens/register_screen.dart';
import '../../ui/screens/role_selection_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Volunteer? currentVolunteer;
  final VoidCallback onEmergencyTap;

  const CustomBottomNavBar({
    Key? key,
    this.currentVolunteer,
    required this.onEmergencyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ---------------- PROFILE ----------------
                _buildNavItem(
                  icon: Icons.person_rounded,
                  label: loc.profile,
                  onTap: () {
                    if (currentVolunteer != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfilePage(volunteer: currentVolunteer!),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    }
                  },
                ),

                // ---------------- HOME ----------------
                _buildNavItem(
                  icon: Icons.home_rounded,
                  label: loc.home,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => currentVolunteer != null
                            ? RoleSelectionScreen(
                                volunteer: currentVolunteer!,
                              )
                            : const RegisterScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ---------------- EMERGENCY BUTTON ----------------
          Positioned(
            top: -35,
            child: GestureDetector(
              onTap: onEmergencyTap,
              child: Image.asset(
                'assets/images/Button.png',
                width: 80,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF4A8BB3),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4A8BB3),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
