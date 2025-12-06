
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Screens
import 'ui/screens/loading_screen.dart';
import 'ui/screens/role_selection_screen.dart';
import 'ui/screens/register_screen.dart';

// Repositories
import 'data/repositories/volunteers_repository.dart';
import 'data/repositories/geolocation_repository.dart';

// Cubits
import 'logic/cubit/volunteers_cubit.dart';
import 'logic/cubit/need_help_cubit.dart';
import 'logic/cubit/volunteer_registration_cubit.dart';

void main() {
  runApp(const EmergencyApp());
}

class EmergencyApp extends StatelessWidget {
  const EmergencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap the entire app with Repository and BLoC providers
    return MultiRepositoryProvider(
      providers: [
        // Repositories - create once and share across the app
        RepositoryProvider(
          create: (_) => VolunteersRepository(),
        ),
        RepositoryProvider(
          create: (_) => GeolocationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Volunteers Cubit
          BlocProvider(
            create: (context) => VolunteersCubit(
              volunteersRepository: context.read<VolunteersRepository>(),
            ),
          ),
          // Need Help Cubit (your existing one)
          BlocProvider(
            create: (context) => NeedHelpCubit(
              geolocationRepository: context.read<GeolocationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => VolunteerRegistrationCubit(
              volunteersRepository: context.read<VolunteersRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Emergency App',
          theme: ThemeData(
            colorSchemeSeed: const Color(0xFF4A8BB3),
          ),
          // RTL support for Arabic
          locale: const Locale('ar', 'DZ'),
          home: const LoadingScreen(),
          debugShowCheckedModeBanner: false,
          initialRoute: '/roleSelection',
          routes: {
            '/roleSelection': (context) => const RoleSelectionScreen(),
            '/register': (context) => const RegisterScreen(),
          },
        ),
      ),
    );
  }
}