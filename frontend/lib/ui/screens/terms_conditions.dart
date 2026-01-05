import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            t.privacyTitle,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle(t.typesOfData),
              const SizedBox(height: 12),
              _buildSectionContent(t.typesOfDataDesc),
              const SizedBox(height: 30),
              _buildSectionTitle(t.howWeUse),
              const SizedBox(height: 12),
              _buildSectionContent(t.howWeUseDesc),
              const SizedBox(height: 30),
              _buildSectionTitle(t.disclosure),
              const SizedBox(height: 12),
              _buildSectionContent(t.disclosureDesc),
              const SizedBox(height: 60),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          onEmergencyTap: () async {
            // Make emergency call to 14
            final Uri phoneUri = Uri.parse('tel:14');
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.cannotOpenPhoneApp),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.8,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
