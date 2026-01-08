import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import 'edit_profile.dart';
import 'settings.dart';
import 'terms_conditions.dart';
import 'login_screen.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/bottom_navbar_wrapper.dart';
import '../../data/volunteer_utils.dart';
import '../../data/repositories/volunteers_repository.dart';

class ProfilePage extends StatefulWidget {
  final Volunteer volunteer;
  const ProfilePage({Key? key, required this.volunteer}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAcceptable = false;
  Volunteer? _volunteer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVolunteer();
  }

  // Load current volunteer from local storage or Firebase
  Future<void> _loadVolunteer() async {
    final v = await getCurrentVolunteer();
    if (mounted) {
      setState(() {
        _volunteer = v ?? widget.volunteer; // fallback if null
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _volunteer == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildAccountSection(context),
              const SizedBox(height: 30),
              _buildMoreSection(context),
              const SizedBox(height: 30),
              if (!isAcceptable) _buildWarning(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0, // PROFILE
        currentVolunteer: _volunteer!,
        onEmergencyTap: () async {
          final Uri phoneUri = Uri.parse('tel:14');
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF4A8BB3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsPage(volunteer: _volunteer!),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: const Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!
                .welcomeMessage(_volunteer!.name),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ================= ACCOUNT =================
  Widget _buildAccountSection(BuildContext context) {
    return _card(
      Column(
        children: [
          _menuItem(
            icon: Icons.credit_card,
            title: AppLocalizations.of(context)!.accountSettings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileEditPage(volunteer: _volunteer!),
                ),
              );
            },
          ),
          const Divider(height: 1),
          _menuItem(
            icon: Icons.notifications_outlined,
            title: AppLocalizations.of(context)!.status,
            subtitle:
                _volunteer!.availability ? "Available" : "Not Available",
            subtitleColor:
                _volunteer!.availability ? Colors.green : Colors.red,
            onTap: _changeStatus,
          ),
        ],
      ),
    );
  }

  // ================= CHANGE STATUS =================
  Future<void> _changeStatus() async {
    final selected = await showDialog<bool>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(AppLocalizations.of(context)!.status),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Available"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Not Available"),
          ),
        ],
      ),
    );

    if (selected == null) return;

    // update in Firebase
    final repo = VolunteersRepository();
    await repo.updateVolunteerStatus(_volunteer!.id, selected);

    // create updated Volunteer object using copyWith
    final updatedVolunteer = _volunteer!.copyWith(availability: selected);

    // save locally for next visit
    await saveCurrentVolunteer(updatedVolunteer);

    setState(() {
      _volunteer = updatedVolunteer;
    });
  }

  // ================= MORE =================
  Widget _buildMoreSection(BuildContext context) {
    return _card(
      Column(
        children: [
          _menuItem(
            icon: Icons.lock_outline,
            title: AppLocalizations.of(context)!.privacyPolicy,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PrivacyPolicyPage(volunteer: _volunteer!),
                ),
              );
            },
          ),
          const Divider(height: 1),
          _menuItem(
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.logout,
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  // ================= HELPERS =================
  Widget _card(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? subtitleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle:
          subtitle != null ? Text(subtitle, style: TextStyle(color: subtitleColor)) : null,
      onTap: onTap,
    );
  }

  Widget _buildWarning(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        AppLocalizations.of(context)!.verificationMessage,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red[400]),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.logout),
        content: Text(AppLocalizations.of(context)!.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.logout,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
