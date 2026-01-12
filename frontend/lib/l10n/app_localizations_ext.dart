import 'app_localizations.dart';

extension AppLocalizationsExt on AppLocalizations {
  String wilayaName(String key) {
    switch (key.toLowerCase()) {
      case 'algiers':
        return wilaya_algiers;
      case 'oran':
        return wilaya_oran;
      case 'constantine':
        return wilaya_constantine;
      case 'annaba':
        return wilaya_annaba;
      case 'batna':
        return wilaya_batna;
      case 'setif':
        return wilaya_setif;
      case 'sidi bel abbes':
        return wilaya_sidi_bel_abbes;
      case 'bejaia':
        return wilaya_bejaia;
      // Add other wilayas here
      default:
        return key; // fallback if key not found
    }
  }
}
