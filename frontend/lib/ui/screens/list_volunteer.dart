import 'package:flutter/material.dart';
import '../widgets/volunteer_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../../l10n/app_localizations.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../../data/models/volunteer.dart';

class VolunteerListScreen extends StatelessWidget {
  final Volunteer volunteer; // <-- add this
  final String? wilaya;
  final VolunteersRepository _repository = VolunteersRepository();

  VolunteerListScreen({Key? key, required this.volunteer, this.wilaya}) : super(key: key);

  Future<List<Volunteer>> _fetchVolunteers() async {
    List<Volunteer> allVolunteers = await _repository.getAllVolunteers();
    if (wilaya != null && wilaya!.isNotEmpty) {
      allVolunteers = allVolunteers.where((v) => v.wilaya == wilaya).toList();
    }
    return allVolunteers;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    const double headerHeight = 250.0;
    const double whiteContainerTop = 250.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Header image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/volunteer back.jpg', fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 71, 72, 73).withOpacity(0.5),
                        const Color.fromARGB(255, 17, 17, 18).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Title
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: Text(
              localizations.volunteerListTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Volunteer list
          Positioned(
            top: whiteContainerTop + 20,
            left: 20,
            right: 20,
            bottom: 10,
            child: FutureBuilder<List<Volunteer>>(
              future: _fetchVolunteers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(localizations.errorFetchingVolunteers),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(localizations.noVolunteersFound),
                  );
                }

                final volunteers = snapshot.data!;

                return ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: volunteers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final volunteerItem = volunteers[index];
                    return VolunteerCard(
                                  imagePath: 'assets/images/user.png',
                                  name: volunteerItem.name,
                                  location: volunteerItem.wilaya ?? '',
                                  phone: volunteerItem.phone,
                                  onCall: () =>
                                      makePhoneCall(volunteerItem.phone),
                                );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentVolunteer: volunteer, // <-- use the passed volunteer
        onEmergencyTap: () async {
          final Uri phoneUri = Uri.parse('tel:14');
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(localizations.cannotOpenPhoneApp),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Cannot launch $phoneNumber');
    }
  }
}
