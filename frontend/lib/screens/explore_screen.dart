import 'package:flutter/material.dart';
import 'list_volunteer.dart';
import 'prevention_method_screen.dart';
import 'safety_instruction_screen.dart'; 
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/explore_card.dart';
// Add this import

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  // Helper method to build the interactive explore cards
  
  

  @override
  Widget build(BuildContext context) {
    // **Matching dimensions from RoleSelectionScreen**
    const double headerHeight = 170.0; // The height of the cards overlay section
    const double whiteContainerTop = 300.0; // The top position of the white background container
    
    return Scaffold(
      // Set Scaffold background to the light color
      backgroundColor: const Color(0xFFF5F5F5), 
      
      // Remove AppBar entirely to start content from the absolute top
      appBar: null, 
      
      body: Stack(
        children: [
          // 1. IMAGE HEADER SECTION with Gradient Overlay
          Positioned(
            top: 0, // Start from the absolute top edge
            left: 0,
            right: 0,
            // Height is set to cover the area above the white container
            height: whiteContainerTop, 
            child: Stack( 
              fit: StackFit.expand,
              children: [
                // Actual Image
                Image.asset(
                  // **USING THE SAME IMAGE PATH FOR CONSISTENCY**
                  'assets/images/explore back.jpg', 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to solid gradient container if the image is missing
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
                
                // Gradient Overlay 
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // Darker gradient at the top (50% opacity)
                        const Color.fromARGB(255, 71, 72, 73).withOpacity(0.5), 
                        // Fully transparent at the bottom to blend
                        const Color.fromARGB(255, 17, 17, 18).withOpacity(0.0), 
                      ],
                    ),
                  ),
                ),
                 
              ],
            ),
          ),
          
          // 2. Back Button (Manually positioned)
        

          
          // 3. Title (Manually positioned below the Status Bar area)
          Positioned(
            // Positioned lower than the back button for visual separation
            top: MediaQuery.of(context).padding.top + 60, 
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 10.0), 
              child: Text(
                'استكشاف',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for contrast
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // 4. White container (Starting at whiteContainerTop)
          Positioned(
            top:  320, // Starts the white background
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
            ),
          ),
          
          // 5. Cards overlaying the section (Starting at headerHeight)
          Positioned(
            top: 230, // Cards start here, matching RoleSelectionScreen's cards position
            left: 20,
            right: 20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Prevention Methods Card
                  ExploreCard(
                    title: 'طرق الوقاية',
                    imagePath: 'assets/images/explore.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PreventionMethodsScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  // Safety Instructions Card
                  ExploreCard(
                    title: 'ارشادات امنية',
                    imagePath: 'assets/images/ambulance.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SafetyInstructionsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Hospitals List Card
                   ExploreCard(
                    title: 'قائمة المسعفين',
                    imagePath: 'assets/images/mos3if.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VolunteerListScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 5),
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