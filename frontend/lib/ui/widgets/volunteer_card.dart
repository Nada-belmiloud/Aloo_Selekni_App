import 'package:flutter/material.dart';

class VolunteerCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final VoidCallback onCall;

  const VolunteerCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.location,
    required this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onCall,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.red[400],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B9FCA),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF5B9FCA),
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
