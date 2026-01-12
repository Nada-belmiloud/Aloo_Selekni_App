import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../screens/settings.dart';
import '../../data/models/volunteer.dart';

class SettingsIcon extends StatelessWidget {
  final Volunteer volunteer; // <-- required

  const SettingsIcon({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings, size: 28, color: Colors.black),
      tooltip: AppLocalizations.of(context)!.settingsTooltip,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SettingsPage(volunteer: volunteer),
          ),
        );
      },
    );
  }
}

