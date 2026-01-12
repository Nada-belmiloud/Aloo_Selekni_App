import 'package:flutter/material.dart';

class VolunteerCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final String phone;
  final VoidCallback? onCall;

  const VolunteerCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.location,
    required this.phone,
    this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Call Button
          IconButton(
            icon: const Icon(Icons.call, color: Colors.green, size: 30),
            onPressed: onCall, // <-- callback passed from screen
          ),

          const SizedBox(width: 12),

          // Name + Wilaya
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Color(0xFF5B9FCA)),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        location,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 30, color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
