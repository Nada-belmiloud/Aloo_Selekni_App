import 'package:flutter/material.dart';
import '../screens/safety_detail_screen.dart';
import '../../data/models/volunteer.dart'; // import your Volunteer model

class AccidentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;
  final String accidentKey;
  final Volunteer volunteer; // add volunteer here
  final VoidCallback? onTap;

  const AccidentCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.imagePath,
    required this.accidentKey,
    required this.volunteer, // required
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SafetyDetailScreen(
                  volunteer: volunteer, // pass it here
                  accidentKey: accidentKey,
                  title: title,
                  icon: icon,
                  imagePath: imagePath,
                ),
              ),
            );
          },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFE57373),
                          const Color(0xFFE57373).withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white.withOpacity(0.7),
                        size: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            icon,
                            color: Colors.white,
                            size: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
