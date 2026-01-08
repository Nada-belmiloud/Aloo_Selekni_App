import 'package:flutter/material.dart';
import '../widgets/volunteer_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../../data/models/volunteer.dart';
import '../widgets/bottom_navbar_wrapper.dart';

class VolunteerListScreen extends StatefulWidget {
  final Volunteer volunteer;
  final String? wilaya;

  const VolunteerListScreen({Key? key, required this.volunteer, this.wilaya}) : super(key: key);

  @override
  State<VolunteerListScreen> createState() => _VolunteerListScreenState();
}

class _VolunteerListScreenState extends State<VolunteerListScreen> {
  final VolunteersRepository _repository = VolunteersRepository();
  late Future<List<Volunteer>> _futureVolunteers;

  @override
  void initState() {
    super.initState();
    _loadVolunteers();
  }

  void _loadVolunteers() {
    _futureVolunteers = _repository.getAllVolunteers().then((allVolunteers) {
      allVolunteers = allVolunteers.where((v) => v.availability).toList();
      if (widget.wilaya != null && widget.wilaya!.isNotEmpty) {
        allVolunteers = allVolunteers.where((v) => v.wilaya == widget.wilaya).toList();
      }
      return allVolunteers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: FutureBuilder<List<Volunteer>>(
        future: _futureVolunteers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading volunteers'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No available volunteers'));
          }

          final volunteers = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: volunteers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final v = volunteers[index];
              return VolunteerCard(
                imagePath: 'assets/images/user.png',
                name: v.name,
                location: v.wilaya ?? '',
                phone: v.phone,
                onCall: () => makePhoneCall(v.phone),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWrapper(
        selectedIndex: 0,
        volunteer: widget.volunteer,
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    }
  }
}