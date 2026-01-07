import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/bottom_navbar_wrapper.dart'; 
import '../../l10n/app_localizations.dart';
import '../../data/models/volunteer.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'language_page.dart';

class SettingsPage extends StatelessWidget {
  final Volunteer volunteer;

  const SettingsPage({
    Key? key,
    required this.volunteer,
  }) : super(key: key);

  static const List<Map<String, dynamic>> options = [
    {'key': 'changeLanguage', 'icon': Icons.language},
    {'key': 'followUs', 'icon': Icons.people},
    {'key': 'faq', 'icon': Icons.help_outline},
    {'key': 'contactUs', 'icon': Icons.contact_mail},
    {'key': 'rateApp', 'icon': Icons.star_rate},
  ];

  String _getLocalizedString(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;

    switch (key) {
      case 'changeLanguage':
        return loc.changeLanguage;
      case 'followUs':
        return loc.followUs;
      case 'faq':
        return loc.faq;
      case 'contactUs':
        return loc.contactUs;
      case 'rateApp':
        return loc.rateApp;
      default:
        return key;
    }
  }

  Future<void> _handleOptionTap(BuildContext context, String key) async {
    Uri? url;

    switch (key) {
      case 'changeLanguage':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LanguagePage(volunteer: volunteer),
          ),
        );
        return; // Exit early after navigation

      case 'followUs':
        // Try Instagram app first, fallback to web
        url = Uri.parse('instagram://user?username=alloselekniteam');
        if (!await canLaunchUrl(url)) {
          url = Uri.parse('https://www.instagram.com/alloselekniteam/');
        }
        break;

      case 'faq':
        url = Uri.parse('https://www.yourwebsite.com/faq');
        break;

      case 'contactUs':
        url = Uri(
          scheme: 'mailto',
          path: 'support@yourapp.com',
          query: 'subject=Support Request',
        );
        break;

      case 'rateApp':
        url = Uri.parse(
            'https://play.google.com/store/apps/details?id=com.yourapp');
        break;

      default:
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
            ),
          );
        }
        return;
    }

    // Launch the URL if it's set
    if (url != null) {
      try {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open the link.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error opening link: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: options.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final option = options[index];

            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => _handleOptionTap(context, option['key']),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      option['icon'],
                      color: const Color(0xFF5B9FCA),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _getLocalizedString(context, option['key']),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
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
