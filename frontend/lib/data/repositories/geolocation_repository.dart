// lib/repositories/geolocation_repository.dart
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

const String _kSavedWilayaKey = 'saved_wilaya';

/// Map latin wilaya names to Arabic (keys lowercase).
const Map<String, String> wilayaArabicNames = {
  'algiers': 'الجزائر',
  'alger': 'الجزائر',
  'oran': 'وهران',
  'constantine': 'قسنطينة',
  'annaba': 'عنابة',
  'blida': 'البليدة',
  'batna': 'باتنة',
  'djelfa': 'الجلفة',
  'sétif': 'سطيف',
  'setif': 'سطيف',
  'sidi bel abbès': 'سيدي بلعباس',
  'sidi bel abbes': 'سيدي بلعباس',
  'biskra': 'بسكرة',
  'tébessa': 'تبسة',
  'tebessa': 'تبسة',
  'tiaret': 'تيارت',
  'béjaïa': 'بجاية',
  'bejaia': 'بجاية',
  'tlemcen': 'تلمسان',
  'ouargla': 'ورقلة',
  'skikda': 'سكيكدة',
  'mostaganem': 'مستغانم',
  'béchar': 'بشار',
  'bechar': 'بشار',
  'médéa': 'المدية',
  'medea': 'المدية',
  'saïda': 'سعيدة',
  'saida': 'سعيدة',
  'mascara': 'معسكر',
  'guelma': 'قالمة',
  'jijel': 'جيجل',
  'bordj bou arréridj': 'برج بوعريريج',
  'bordj bou arreridj': 'برج بوعريريج',
  'boumerdès': 'بومرداس',
  'boumerdes': 'بومرداس',
  'tizi ouzou': 'تيزي وزو',
  'bouira': 'البويرة',
  'el oued': 'الوادي',
  'khenchela': 'خنشلة',
  'souk ahras': 'سوق أهراس',
  'tipaza': 'تيبازة',
  'mila': 'ميلة',
  'aïn defla': 'عين الدفلى',
  'ain defla': 'عين الدفلى',
  'naâma': 'النعامة',
  'naama': 'النعامة',
  'aïn témouchent': 'عين تموشنت',
  'ain temouchent': 'عين تموشنت',
  'ghardaïa': 'غرداية',
  'ghardaia': 'غرداية',
  'relizane': 'غليزان',
  'tindouf': 'تندوف',
  'tissemsilt': 'تيسمسيلت',
  'el bayadh': 'البيض',
  'illizi': 'إليزي',
  'el tarf': 'الطارف',
  'oum el bouaghi': 'أم البواقي',
  "m'sila": 'المسيلة',
  'msila': 'المسيلة',
  'chlef': 'الشلف',
  'laghouat': 'الأغواط',
  'adrar': 'أدرار',
  'tamanghasset': 'تمنراست',
  'tamanrasset': 'تمنراست',
};

class GeolocationRepository {
  Future<bool> isServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  /// Quick internet check
  Future<bool> hasInternetConnection({Duration timeout = const Duration(seconds: 4)}) async {
    try {
      final result = await InternetAddress.lookup('example.com').timeout(timeout);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Return Arabic wilaya or null on failure/no mapping.
 Future<String?> getWilayaFromPosition(Position pos) async {
  try {
    final placemarks = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
      localeIdentifier: 'en',
    );
    if (placemarks.isEmpty) return null;

    final place = placemarks.first;
    final extracted = place.administrativeArea ?? place.locality ?? place.subAdministrativeArea;
    if (extracted == null) return null;

    // convert to Arabic
    final key = extracted
        .toLowerCase()
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[âäà]'), 'a')
        .replaceAll(RegExp(r'[îïí]'), 'i')
        .replaceAll(RegExp(r'[ôöò]'), 'o')
        .replaceAll(RegExp(r'[ûüù]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .trim();
    return wilayaArabicNames[key] ?? extracted;
  } catch (e) {
    return null;
  }
}

  // SharedPreferences storage
  Future<void> saveWilayaLocally(String wilaya) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSavedWilayaKey, wilaya);
  }

  Future<String?> getSavedWilaya() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kSavedWilayaKey);
  }

  Future<void> clearSavedWilaya() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSavedWilayaKey);
  }

  /// Return unique Arabic wilaya list (sorted).
  List<String> getAllWilayaArabicList() {
    final values = wilayaArabicNames.values.toSet().toList()..sort((a, b) => a.compareTo(b));
    return values;
  }
}
