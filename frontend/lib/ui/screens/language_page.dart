import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../../main.dart';
import '../../data/models/volunteer.dart';
import '../widgets/bottom_navbar_wrapper.dart';

class LanguagePage extends StatefulWidget {
  final Volunteer volunteer;

  const LanguagePage({Key? key, required this.volunteer}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = '';

  final List<Map<String, String>> languages = [
    {'name': 'English (US)', 'code': 'en'},
    {'name': 'العربية (دارجة)', 'code': 'ar'},
    {'name': 'French (France)', 'code': 'fr'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = EmergencyApp.of(context);

      // get current locale
      final currentLocaleCode = appState?.locale.languageCode ?? 'en';

      // find matching language
      final matched = languages.firstWhere(
        (lang) => lang['code'] == currentLocaleCode,
        orElse: () => languages[0],
      );

      setState(() {
        selectedLanguage = matched['name']!;
      });
    });
  }

  Future<void> _makeEmergencyCall(BuildContext context) async {
    final Uri phoneUri = Uri.parse('tel:14');
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
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
            content: Text('${AppLocalizations.of(context)!.errorOccurred} $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          localizations.changeLanguage,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = selectedLanguage == language['name'];

                return ListTile(
                  title: Text(language['name']!),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : const Icon(Icons.circle_outlined),
                  onTap: () {
                    setState(() {
                      selectedLanguage = language['name']!;
                    });

                    final appState = EmergencyApp.of(context);
                    if (appState != null) {
                      appState.setLocale(Locale(language['code']!));
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavBarWrapper(
        selectedIndex: 0, // change per page
        volunteer:
            widget.volunteer, // can be null if page doesn't have a volunteer
      ),
    );
  }
}
