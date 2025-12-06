// lib/screens/need_help_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/need_help_cubit.dart';
import '../../data/repositories/geolocation_repository.dart';
import 'volunteers_list_screen.dart';
import '../widgets/custom_bottom_navbar.dart';

class NeedHelpScreen extends StatelessWidget {
  const NeedHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NeedHelpCubit(geolocationRepository: GeolocationRepository())..loadSavedWilayaIfAny(),
      child: const NeedHelpView(),
    );
  }
}

class NeedHelpView extends StatefulWidget {
  const NeedHelpView({Key? key}) : super(key: key);

  @override
  State<NeedHelpView> createState() => _NeedHelpViewState();
}

class _NeedHelpViewState extends State<NeedHelpView> {
  String? _selectedWilaya;

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                _selectedWilaya = state.wilaya;
              });
            }
          }

          if (state.status == NeedHelpStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تفعيل الموقع ✓\nالولاية: ${state.wilaya}', textDirection: TextDirection.rtl), backgroundColor: Colors.green),
            );
          } else if (state.status == NeedHelpStatus.permissionDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم رفض صلاحية الموقع', textDirection: TextDirection.rtl), backgroundColor: Colors.red),
            );
          } else if (state.status == NeedHelpStatus.disabledService) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى تفعيل خدمات الموقع على جهازك', textDirection: TextDirection.rtl), backgroundColor: Colors.red),
            );
          } else if (state.status == NeedHelpStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: ${state.errorMessage}', textDirection: TextDirection.rtl), backgroundColor: Colors.red),
            );
          } else if (state.status == NeedHelpStatus.selectWilaya) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تعذر تحديد الولاية آلياً — اختر الولاية يدوياً', textDirection: TextDirection.rtl), backgroundColor: Colors.orange),
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
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/map.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Color(0xFFE8E8E8),
                ),
                child: locationEnabled ? _buildMapWithLocation() : _buildMapPlaceholder(),
              ),

              // Persistent top selector
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text('الولاية:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]), textDirection: TextDirection.rtl),
                        ),
                        Expanded(
  flex: 8,
  child: DropdownButtonFormField<String>(
    value: (_selectedWilaya != null && allWilayas.contains(_selectedWilaya))
        ? _selectedWilaya
        : null,
    hint: const Text('اختر الولاية'),
    items: allWilayas
        .map((w) => DropdownMenuItem(
              value: w,
              child: Text(w, textDirection: TextDirection.rtl),
            ))
        .toList(),
    onChanged: (newVal) {
      if (newVal != null) {
        // Save selected wilaya in Arabic
        setState(() => _selectedWilaya = newVal);
        cubit.saveSelectedWilaya(newVal);
      }
    },
    decoration: const InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(),
    ),
  ),
),

                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: 'مسح الاختيار',
                          onPressed: _selectedWilaya == null ? null : _clearWilaya,
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Volunteer Card when enabled (uses selected or geocoded wilaya)
              if (locationEnabled && (_selectedWilaya ?? wilaya) != null)
                Positioned(
                  top: 130,
                  left: 20,
                  right: 20,
                  child: _volunteerCard(context, _selectedWilaya ?? wilaya!),
                ),

              // Center permission card when not enabled
              if (!locationEnabled)
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0,5))]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, size: 60, color: const Color(0xFF5B9FCA)),
                        const SizedBox(height: 20),
                        const Text('اسمح بالوصول إلى موقعك', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), textDirection: TextDirection.rtl, textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        const Text('نحتاج إلى موقعك لإيجاد أقرب مسعف لك', style: TextStyle(fontSize: 15, color: Colors.grey), textDirection: TextDirection.rtl, textAlign: TextAlign.center),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => context.read<NeedHelpCubit>().requestLocationAndWilaya(),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5B9FCA), padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: state.status == NeedHelpStatus.loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('تفعيل الموقع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختر الولاية من الأعلى', textDirection: TextDirection.rtl)));
                          },
                          child: const Text('اختيار الولاية يدوياً'),
                        ),
                      ],
                    ),
                  ),
                ),

              // Center location marker when enabled
              if (locationEnabled)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, size: 50, color: const Color(0xFF5B9FCA)),
                      if (position != null)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)]),
                          child: Column(
                            children: [
                              Text(_selectedWilaya ?? wilaya ?? 'غير محدد', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5B9FCA)), textAlign: TextAlign.center),
                              Padding(padding: const EdgeInsets.only(top: 5), child: Text('Lat: ${position!.latitude.toStringAsFixed(4)}, Lng: ${position!.longitude.toStringAsFixed(4)}', style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _volunteerCard(BuildContext context, String wilaya) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0,3))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('المسعفين المتاحين', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), textDirection: TextDirection.rtl),
                  const SizedBox(height: 4),
                  Text(wilaya, style: TextStyle(fontSize: 14, color: Colors.grey[600]), textDirection: TextDirection.rtl),
                ],
              ),
              const SizedBox(width: 12),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF5B9FCA).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.medical_services, color: Color(0xFF5B9FCA), size: 30)),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NearestVolunteersScreen(wilaya: wilaya)));
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5B9FCA), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('عرض المسعفين القريبين', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.map_outlined, size: 80, color: Colors.grey[400]), const SizedBox(height: 15), Text('الخريطة', style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500))]),
    );
  }

  Widget _buildMapWithLocation() {
    return Stack(children: [Positioned(top: 200, right: 100, child: _buildResponderMarker()), Positioned(top: 350, left: 80, child: _buildResponderMarker()), Positioned(bottom: 250, right: 150, child: _buildResponderMarker())]);
  }

  Widget _buildResponderMarker() {
    return Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)]), child: const Icon(Icons.medical_services, color: Colors.red, size: 30));
  }
}
