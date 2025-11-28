import 'package:flutter/material.dart';

class VolunteersListScreen extends StatefulWidget {
  final String? wilaya;

  const VolunteersListScreen({Key? key, this.wilaya}) : super(key: key);

  @override
  State<VolunteersListScreen> createState() => _VolunteersListScreenState();
}

class _VolunteersListScreenState extends State<VolunteersListScreen> {
  final List<Map<String, dynamic>> volunteers = List.generate(
    20,
    (index) => {
      'name': 'اسم المتطوع',
      'location': 'الجزائر',
      'phone': '00987654321',
      'image': 'assets/images/profile.png',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B9FCA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Blue header with title, photo, and back arrow on RIGHT for Arabic UI
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
                    textDirection: TextDirection.rtl, // Arabic layout
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back arrow on the right side
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 16, 16, 16),
                        ), // arrow points right
                        onPressed: () => Navigator.pop(context),
                      ),

                      // Expanded centered title
                      const Expanded(
                        child: Center(
                          child: Text(
                            'اختر اقرب مسعف',
                            style: TextStyle(
                              color: Color.fromARGB(255, 21, 20, 20),
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

                  // Photo under the title — replace with your actual photo asset
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
                    // Scrollable volunteer cards list only
                    Expanded(
                      child: ListView.separated(
                        itemCount: volunteers.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            _buildVolunteerCard(volunteers[index]),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Fixed "ارشادات الامان" Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Your safety instructions navigation
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ), // arrow_forward logical for Arabic
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

                    const SizedBox(height: 25),

                    // Emergency Button
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Button.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'راك في خطر؟ محتاج نجدة؟',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 12, 12, 12),
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolunteerCard(Map<String, dynamic> volunteer) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _makePhoneCall(volunteer['phone']),
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
                  volunteer['name'],
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
                      volunteer['location'],
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
                const SizedBox(height: 5),
                Text(
                  volunteer['phone'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.asset(
                  volunteer['image'],
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
          ),
        ],
      ),
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
