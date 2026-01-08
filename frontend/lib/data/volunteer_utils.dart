import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/volunteer.dart';

Future<Volunteer?> getCurrentVolunteer() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('currentVolunteerId');
  final name = prefs.getString('currentVolunteerName');
  final phone = prefs.getString('currentVolunteerPhone');
  final email = prefs.getString('currentVolunteerEmail');
  final availability = prefs.getBool('currentVolunteerAvailability');

  if (id == null ||
      name == null ||
      phone == null ||
      email == null ||
      availability == null) {
    return null; // Not logged in
  }

  return Volunteer(
    id: id,
    name: name,
    phone: phone,
    email: email,
    availability: availability,
  );
}


Future<void> saveCurrentVolunteer(Volunteer volunteer) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('currentVolunteerId', volunteer.id);
  await prefs.setString('currentVolunteerName', volunteer.name);
  await prefs.setString('currentVolunteerPhone', volunteer.phone);
  await prefs.setString('currentVolunteerEmail', volunteer.email);
  await prefs.setBool('currentVolunteerAvailability', volunteer.availability);
}
