import 'package:flutter/material.dart';
import 'need_help_screen.dart';
import 'register_screen.dart';
import 'explore_screen.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/explore_card.dart';


class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    const double headerHeight = 170.0;

    return Scaffold(
      
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: null,

      body: Stack(
        children: [
         
          Positioned(
            top: 0, 
            left: 0,
            right: 0,
            height: headerHeight +
                70, 
            child: Stack(
              fit: StackFit.expand,
              children: [
                
                Image.asset(
                
                  'assets/images/help (1).jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                  
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF4A8BB3),
                            const Color(0xFF4A8BB3).withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Header Image Missing',
                          style: TextStyle(color: Colors.white),
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
                        // End in full transparency to blend smoothly with the white container
                        const Color.fromARGB(255, 17, 17, 18).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          
          Positioned(
            top: MediaQuery.of(context).padding.top + 40,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'واش راك حاب تدير؟',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
            ),
          ),

          Positioned(
            top: 210,
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Need Help Card
                  
                  ExploreCard(
                    title:'اختر اقرب مسعف',
                    imagePath: 'assets/images/ambulance.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NeedHelpScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  // Volunteer Card
                  
                  ExploreCard(
                    title:'حاب نتطوع  !',
                    imagePath: 'assets/images/volunteer.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // Explore Card
                 
                  ExploreCard(
                    title:'استكشاف',
                    imagePath: 'assets/images/explore.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExploreScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Emergency Button with Image
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        // optional: handle emergency button
        // onEmergencyTap: () { ... },
      ),
    );
  }
}
