import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'volunteers_list_screen.dart';
import '../widgets/custom_bottom_navbar.dart';



class NeedHelpScreen extends StatefulWidget {
  const NeedHelpScreen({Key? key}) : super(key: key);

  @override
  State<NeedHelpScreen> createState() => _NeedHelpScreenState();
}

class _NeedHelpScreenState extends State<NeedHelpScreen> {
  bool locationEnabled = false;
  Position? currentPosition;
  String? wilaya;

  // Map to convert English/French wilaya names to Arabic (lowercase keys for case-insensitive lookup)
  final Map<String, String> wilayaArabicNames = {
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
    'm\'sila': 'المسيلة',
    'msila': 'المسيلة',
    'chlef': 'الشلف',
    'laghouat': 'الأغواط',
    'adrar': 'أدرار',
    'tamanghasset': 'تمنراست',
    'tamanrasset': 'تمنراست',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (map)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.jpg'),
                fit: BoxFit.cover,
              ),
              color: Color(0xFFE8E8E8),
            ),
            child: locationEnabled
                ? _buildMapWithLocation()
                : _buildMapPlaceholder(),
          ),

          // Top location bar with back button
          // Custom header at the top




          // Volunteer Card - Shows at TOP when location is enabled
          if (locationEnabled && wilaya != null)
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
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
                            const Text(
                              'المسعفين المتاحين',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              wilaya!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
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
                          child: const Icon(
                            Icons.medical_services,
                            color: Color(0xFF5B9FCA),
                            size: 30,
                          ),
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
                              builder: (context) => VolunteersListScreen(wilaya: wilaya),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B9FCA),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'عرض المسعفين القريبين',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Center location button with card
          if (!locationEnabled)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 60,
                      color: const Color(0xFF5B9FCA),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'اسمح بالوصول إلى موقعك',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'نحتاج إلى موقعك لإيجاد أقرب مسعف لك',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _requestLocationPermission,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B9FCA),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'تفعيل الموقع',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Location marker in center when enabled
          if (locationEnabled)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 50,
                    color: const Color(0xFF5B9FCA),
                  ),
                  if (wilaya != null)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            wilaya!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5B9FCA),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (currentPosition != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Lat: ${currentPosition!.latitude.toStringAsFixed(4)}, Lng: ${currentPosition!.longitude.toStringAsFixed(4)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

          // Emergency button at bottom
        ]
      ),
       bottomNavigationBar: const CustomBottomNavBar(
        // optional: handle emergency button
        // onEmergencyTap: () { ... },
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 15),
          Text(
            'الخريطة',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

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
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.medical_services,
        color: Colors.red,
        size: 30,
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى تفعيل خدمات الموقع على جهازك'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم رفض صلاحية الموقع'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('صلاحية الموقع موقوفة نهائياً. يرجى تغيير الإعدادات.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentPosition = position;
      });

      await _getWilayaFromCoordinates(position);

      setState(() {
        locationEnabled = true;
      });

      _showLocationEnabledMessage();
      print('Current location: ${position.latitude}, ${position.longitude}');
      print('Wilaya: $wilaya');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Location error: $e');
    }
  }

  Future<void> _getWilayaFromCoordinates(Position position) async {
    try {
      debugPrint('Starting geocoding for: ${position.latitude}, ${position.longitude}');
      
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'ar',
      );
      
      debugPrint('Placemarks count: ${placemarks.length}');
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String? extractedWilaya = place.administrativeArea ??
            place.locality ??
            place.subAdministrativeArea;
        
        debugPrint('Raw extracted wilaya: "$extractedWilaya"');
        
        if (extractedWilaya != null) {
          extractedWilaya = extractedWilaya.trim();
          // Case-insensitive lookup
          String? arabicName = wilayaArabicNames[extractedWilaya.toLowerCase()];
          
          debugPrint('Mapped Arabic name: "$arabicName" (from key: "${extractedWilaya.toLowerCase()}")');
          
          setState(() {
            wilaya = arabicName ?? extractedWilaya;  // Use Arabic if available, else raw
          });
        } else {
          debugPrint('No wilaya extracted from placemark');
          setState(() {
            wilaya = 'غير محدد';
          });
        }
        
        debugPrint('=== Placemark Data ===');
        debugPrint('Administrative Area: ${place.administrativeArea}');
        debugPrint('Locality: ${place.locality}');
        debugPrint('Sub Administrative Area: ${place.subAdministrativeArea}');
        debugPrint('Final Arabic Wilaya: $wilaya');
      } else {
        debugPrint('No placemarks returned');
        setState(() {
          wilaya = 'غير محدد';
        });
      }
    } catch (e) {
      debugPrint('Geocoding error: $e');
      setState(() {
        wilaya = 'غير محدد';
      });
    }
  }

  void _showLocationEnabledMessage() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تفعيل الموقع بنجاح ✓\nالولاية: ${wilaya ?? "غير محدد"}',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}