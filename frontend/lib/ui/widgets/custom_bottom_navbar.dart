import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/volunteer_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import '../../ui/screens/profile_screen.dart';
import '../../ui/screens/register_screen.dart';
import '../../ui/screens/role_selection_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex; // 0 = profile, 1 = home
  final Volunteer? currentVolunteer;
  final VoidCallback onEmergencyTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onEmergencyTap,
    this.currentVolunteer,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      height: 80,
      clipBehavior: Clip.none, // allow overflow
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
        clipBehavior: Clip.none, // crucial for emergency button
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(
                  context,
                  icon: Icons.person,
                  label: loc.profile,
                  isActive: selectedIndex == 0,
                  onTap: () async {
                    final Volunteer? current = await getCurrentVolunteer();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => current == null
                            ? const RegisterScreen()
                            : ProfilePage(volunteer: current),
                      ),
                    );
                  },
                ),
                _navItem(
                  context,
                  icon: Icons.home,
                  label: loc.home,
                  isActive: selectedIndex == 1,
                  onTap: () async {
                    final Volunteer? current =
                        currentVolunteer ?? await getCurrentVolunteer();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => current == null
                            ? const RegisterScreen()
                            : RoleSelectionScreen(volunteer: current),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Emergency button in the middle above navbar
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onEmergencyTap,
                child: Image.asset(
                  'assets/images/Button.png',
                  width: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? const Color(0xFF4A8BB3) : Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ],
      ),
    );
  }
}
