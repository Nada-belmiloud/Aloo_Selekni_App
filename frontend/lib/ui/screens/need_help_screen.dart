// lib/screens/need_help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import '../../logic/cubit/need_help_cubit.dart';
import '../../data/repositories/geolocation_repository.dart';
import 'volunteers_list_screen.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../../data/models/volunteer.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpScreen extends StatelessWidget {
  final Volunteer volunteer; // <-- required logged-in volunteer

  const NeedHelpScreen({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NeedHelpCubit(
        geolocationRepository: GeolocationRepository(),
      )..loadSavedWilayaIfAny(),
      child: NeedHelpView(volunteer: volunteer),
    );
  }
}

class NeedHelpView extends StatefulWidget {
  final Volunteer volunteer; // <-- passed from parent

  const NeedHelpView({Key? key, required this.volunteer}) : super(key: key);

  @override
  State<NeedHelpView> createState() => _NeedHelpViewState();
}

class _NeedHelpViewState extends State<NeedHelpView> {
  String? _selectedWilaya;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final cubit = context.read<NeedHelpCubit>();
    final repo = cubit.geolocationRepository;

    void _onWilayaChanged(String? newVal) {
      if (newVal == null) return;
      setState(() => _selectedWilaya = newVal);
      cubit.saveSelectedWilaya(newVal);
    }

    void _clearWilaya() {
      setState(() => _selectedWilaya = null);
      cubit.clearSavedWilaya();
    }

    return Scaffold(
      body: BlocConsumer<NeedHelpCubit, NeedHelpState>(
        listener: (context, state) {
          if (state.wilaya != null && state.wilaya!.isNotEmpty) {
            if (_selectedWilaya == null) {
              setState(() => _selectedWilaya = state.wilaya);
            }
          }

          // Snackbars for different statuses
          if (state.status == NeedHelpStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${loc.snackLocationActivated} ${state.wilaya}",
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == NeedHelpStatus.permissionDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.snackPermissionDenied,
                    textDirection: TextDirection.rtl),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == NeedHelpStatus.disabledService) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.snackServiceDisabled,
                    textDirection: TextDirection.rtl),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == NeedHelpStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${loc.snackError} ${state.errorMessage}",
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == NeedHelpStatus.selectWilaya) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.snackManualChoice,
                    textDirection: TextDirection.rtl),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        builder: (context, state) {
          final locationEnabled = state.status == NeedHelpStatus.success;
          final wilaya = state.wilaya;
          final position = state.position;

          final allWilayas = repo.getAllWilayaArabicList();
          if (_selectedWilaya == null && wilaya != null && wilaya.isNotEmpty) {
            _selectedWilaya = wilaya;
          }

          return Stack(
            children: [
              // MAP BACKGROUND
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/map.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: locationEnabled
                    ? _buildMapWithLocation()
                    : _buildMapPlaceholder(context),
              ),

              // TOP SELECTOR
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${loc.wilaya}:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: DropdownButtonFormField<String>(
                            value: (_selectedWilaya != null &&
                                    allWilayas.contains(_selectedWilaya))
                                ? _selectedWilaya
                                : null,
                            hint: Text(loc.selectWilaya),
                            items: allWilayas
                                .map((w) => DropdownMenuItem(
                                      value: w,
                                      child: Text(w,
                                          textDirection: TextDirection.rtl),
                                    ))
                                .toList(),
                            onChanged: _onWilayaChanged,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: loc.clearSelection,
                          onPressed:
                              _selectedWilaya == null ? null : _clearWilaya,
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // VOLUNTEERS CARD
              if (locationEnabled && (_selectedWilaya ?? wilaya) != null)
                Positioned(
                  top: 130,
                  left: 20,
                  right: 20,
                  child: _volunteerCard(context, _selectedWilaya ?? wilaya!),
                ),

              // LOCATION PERMISSION CARD
              if (!locationEnabled)
                Center(
                  child: _buildLocationPermissionCard(context, loc, state),
                ),

              // LOCATION MARKER
              if (locationEnabled)
                Center(
                  child: _locationMarker(position, _selectedWilaya ?? wilaya),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentVolunteer: widget.volunteer,
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
    );
  }

  // ---------------- VOLUNTEER CARD ----------------
  Widget _volunteerCard(BuildContext context, String wilaya) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    loc.availableVolunteers,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wilaya,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF5B9FCA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.medical_services,
                    color: Color(0xFF5B9FCA), size: 30),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NearestVolunteersScreen(
                      wilaya: wilaya,
                      volunteer:
                          widget.volunteer, // <-- pass logged-in volunteer
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B9FCA),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                loc.viewNearbyVolunteers,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LOCATION PLACEHOLDER MAP ----------------
  Widget _buildMapPlaceholder(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 15),
          Text(
            loc.map,
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // ---------------- LOCATION PERMISSION CARD ----------------
  Widget _buildLocationPermissionCard(
      BuildContext context, AppLocalizations loc, NeedHelpState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, size: 60, color: const Color(0xFF5B9FCA)),
          const SizedBox(height: 20),
          Text(
            loc.locationEnableTitle,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            loc.locationEnableSubtitle,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  context.read<NeedHelpCubit>().requestLocationAndWilaya(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B9FCA),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: state.status == NeedHelpStatus.loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      loc.activateLocation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(loc.selectWilaya,
                        textDirection: TextDirection.rtl)),
              );
            },
            child: Text(loc.manualWilayaChoice),
          ),
        ],
      ),
    );
  }

  // ---------------- RESPONDER MARKERS ----------------
  Widget _buildMapWithLocation() {
    return Stack(
      children: [
        Positioned(top: 200, right: 100, child: _buildResponderMarker()),
        Positioned(top: 350, left: 80, child: _buildResponderMarker()),
        Positioned(bottom: 250, right: 150, child: _buildResponderMarker()),
      ],
    );
  }

  Widget _buildResponderMarker() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)
          ]),
      child: const Icon(Icons.medical_services, color: Colors.red, size: 30),
    );
  }

  // ---------------- LOCATION MARKER CARD ----------------
  Widget _locationMarker(Position? position, String? wilaya) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on, size: 50, color: const Color(0xFF5B9FCA)),
        if (position != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
              ],
            ),
            child: Column(
              children: [
                Text(
                  wilaya ?? "",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B9FCA)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}",
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
