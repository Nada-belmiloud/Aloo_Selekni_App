// lib/ui/screens/all_volunteers_screen.dart
// Shows ALL volunteers (no filter)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/volunteers_cubit.dart';
import '../../logic/states/voluteers_state.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/volunteer_card.dart';

class AllVolunteersScreen extends StatefulWidget {
  const AllVolunteersScreen({Key? key}) : super(key: key);

  @override
  State<AllVolunteersScreen> createState() => _AllVolunteersScreenState();
}

class _AllVolunteersScreenState extends State<AllVolunteersScreen> {
  @override
  void initState() {
    super.initState();
    // Load ALL volunteers (no filter)
    context.read<VolunteersCubit>().loadAllVolunteers();
  }

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 250.0;
    const double whiteContainerTop = 250.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Header image section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/volunteer back.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF5B9FCA),
                            const Color(0xFF5B9FCA).withOpacity(0.7),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 5,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward,
                  color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Title
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Text(
                'قائمة جميع المسعفين',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Volunteers List with BlocBuilder
          Positioned(
            top: whiteContainerTop + 20,
            left: 20,
            right: 20,
            bottom: 10,
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
                        const Icon(Icons.error_outline,
                            size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'حدث خطأ',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => context
                              .read<VolunteersCubit>()
                              .loadAllVolunteers(),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.status == VolunteersStatus.empty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline,
                            size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'لا يوجد متطوعين',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<VolunteersCubit>().loadAllVolunteers(),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: state.volunteers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final volunteer = state.volunteers[index];
                      return VolunteerCard(
                        imagePath:
                            volunteer.imagePath ?? 'assets/images/profile.png',
                        name: volunteer.name,
                        location: volunteer.wilaya ??
                            volunteer.location ??
                            'غير محدد',
                        onCall: () => _makePhoneCall(volunteer.phone),
                      );
                    },
                  ),
                );
              },
            ),
          )
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
