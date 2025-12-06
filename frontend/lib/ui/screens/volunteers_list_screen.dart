// lib/ui/screens/nearest_volunteers_screen.dart
// Shows volunteers filtered by wilaya (Nearest volunteers)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/volunteers_cubit.dart';
import '../../logic/states/voluteers_state.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/volunteer_card.dart';

class NearestVolunteersScreen extends StatefulWidget {
  final String wilaya;

  const NearestVolunteersScreen({Key? key, required this.wilaya}) : super(key: key);

  @override
  State<NearestVolunteersScreen> createState() => _NearestVolunteersScreenState();
}

class _NearestVolunteersScreenState extends State<NearestVolunteersScreen> {
  @override
  void initState() {
    super.initState();
    // Load volunteers filtered by wilaya using Cubit
    context.read<VolunteersCubit>().loadVolunteersByWilaya(widget.wilaya);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B9FCA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Blue header with title, photo, and back arrow
          SafeArea(
            child: Container(
              color: const Color(0xFF5B9FCA),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  // Row with title centered, back arrow on right
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back arrow on the right side
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),

                      // Expanded centered title
                      const Expanded(
                        child: Center(
                          child: Text(
                            'اختر اقرب مسعف',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),

                      // Invisible box to balance space
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Photo under the title
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/mos3if.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.white24,
                            child: const Icon(
                              Icons.person,
                              size: 70,
                              color: Colors.white70,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White Expanded content area with rounded top corners
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // Header line showing selected wilaya
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الولاية: ${widget.wilaya}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          textDirection: TextDirection.rtl,
                        ),
                        BlocBuilder<VolunteersCubit, VolunteersState>(
                          builder: (context, state) {
                            return Text(
                              '${state.volunteers.length} متطوع',
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Scrollable volunteer cards list with BLoC
                    Expanded(
                      child: BlocBuilder<VolunteersCubit, VolunteersState>(
                        builder: (context, state) {
                          if (state.status == VolunteersStatus.loading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (state.status == VolunteersStatus.error) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'حدث خطأ أثناء جلب المتطوعين.',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => context
                                        .read<VolunteersCubit>()
                                        .loadVolunteersByWilaya(widget.wilaya),
                                    child: const Text('إعادة المحاولة'),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state.status == VolunteersStatus.empty) {
                            return const Center(
                              child: Text(
                                'لا يوجد متطوعون في هذه الولاية.',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () => context
                                .read<VolunteersCubit>()
                                .loadVolunteersByWilaya(widget.wilaya),
                            child: ListView.separated(
                              itemCount: state.volunteers.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final volunteer = state.volunteers[index];
                                return VolunteerCard(
                                  imagePath: volunteer.imagePath ?? 'assets/images/profile.png',
                                  name: volunteer.name,
                                  location: volunteer.wilaya ?? volunteer.location ?? 'غير محدد',
                                  onCall: () => _makePhoneCall(volunteer.phone),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Fixed "ارشادات الامان" Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: navigate to safety instructions
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'ارشادات الامان',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('اتصال بـ $phoneNumber'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}