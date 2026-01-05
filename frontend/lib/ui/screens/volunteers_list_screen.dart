import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/volunteers_cubit.dart';
import '../../logic/states/voluteers_state.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/volunteer_card.dart';
import 'safety_instruction_screen.dart';
import '../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/volunteer.dart';


class NearestVolunteersScreen extends StatefulWidget {
  final String wilaya;
  final Volunteer volunteer; // <-- add volunteer

  const NearestVolunteersScreen({
    Key? key,
    required this.wilaya,
    required this.volunteer, // <-- required
  }) : super(key: key);

  @override
  State<NearestVolunteersScreen> createState() =>
      _NearestVolunteersScreenState();
}

class _NearestVolunteersScreenState extends State<NearestVolunteersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VolunteersCubit>().loadVolunteersByWilaya(widget.wilaya);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF5B9FCA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          SafeArea(
            child: Container(
              color: const Color(0xFF5B9FCA),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            loc.nearestVolunteersTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/mos3if.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White Container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Wilaya & Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${loc.selectedWilaya} ${widget.wilaya}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        BlocBuilder<VolunteersCubit, VolunteersState>(
                          builder: (context, state) {
                            return Text(
                              loc.volunteersCount(state.volunteers.length),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Volunteers List
                    Expanded(
                      child: BlocBuilder<VolunteersCubit, VolunteersState>(
                        builder: (context, state) {
                          if (state.status == VolunteersStatus.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (state.status == VolunteersStatus.error) {
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    loc.errorFetchingVolunteers,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => context
                                        .read<VolunteersCubit>()
                                        .loadVolunteersByWilaya(widget.wilaya),
                                    child: Text(loc.retry),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state.status == VolunteersStatus.empty) {
                            return Center(
                              child: Text(
                                loc.noVolunteers,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () => context
                                .read<VolunteersCubit>()
                                .loadVolunteersByWilaya(widget.wilaya),
                            child: ListView.builder(
                              itemCount: state.volunteers.length,
                              itemBuilder: (context, index) {
                                final volunteerItem = state.volunteers[index];
                                return VolunteerCard(
                                  imagePath: 'assets/images/user.png',
                                  name: volunteerItem.name,
                                  location: volunteerItem.wilaya ?? '',
                                  phone: volunteerItem.phone,
                                  onCall: () =>
                                      makePhoneCall(volunteerItem.phone),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Safety button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SafetyInstructionsScreen(
                                  volunteer: widget.volunteer),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        label: Text(
                          loc.safetyInstructions,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B9FCA),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavBar(currentVolunteer: widget.volunteer, onEmergencyTap: () async {
        final Uri phoneUri = Uri.parse('tel:14');
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.cannotOpenPhoneApp),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }),
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
