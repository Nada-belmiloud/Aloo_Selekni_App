import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';
import 'ui/screens/emergency_button_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/role_selection_screen.dart';
import 'ui/screens/register_screen.dart';
import 'logic/cubit/volunteers_cubit.dart';
import 'logic/cubit/volunteer_registration_cubit.dart';
import 'data/repositories/volunteers_repository.dart';
import 'data/services/database_helper.dart';
import 'data/models/volunteer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  await DatabaseHelper.instance.database;

  final volunteersRepository = VolunteersRepository();
  final prefs = await SharedPreferences.getInstance();
  final savedVolunteerId = prefs.getString('currentVolunteerId');

  // Load saved volunteer from DB if exists
  Volunteer? currentVolunteer;
  if (savedVolunteerId != null) {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'volunteers',
      where: 'id = ?',
      whereArgs: [savedVolunteerId],
    );
    if (result.isNotEmpty) {
      currentVolunteer = Volunteer.fromMap(result.first);
    }
  }

  // Fallback guest volunteer if none exists
  currentVolunteer ??= Volunteer(
    id: '0',
    name: 'Guest',
    phone: '',
    email: '',
    availability: false,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VolunteersCubit(volunteersRepository: volunteersRepository),
        ),
        BlocProvider(
          create: (_) => VolunteerRegistrationCubit(volunteersRepository: volunteersRepository),
        ),
      ],
      child: EmergencyApp(currentVolunteer: currentVolunteer),
    ),
  );
}

class EmergencyApp extends StatefulWidget {
  final Volunteer currentVolunteer;

  const EmergencyApp({Key? key, required this.currentVolunteer}) : super(key: key);

  @override
  State<EmergencyApp> createState() => _EmergencyAppState();

  // Access state from context if needed
  static _EmergencyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_EmergencyAppState>();
}

class _EmergencyAppState extends State<EmergencyApp> {
  Locale _locale = const Locale('ar'); // default locale

  Locale get locale => _locale;

  // Method to update locale dynamically
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency App',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4A8BB3),
        useMaterial3: true,
      ),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: EmergencyButtonScreen(currentVolunteer: widget.currentVolunteer),
      routes: {
        '/roleSelection': (context) => RoleSelectionScreen(volunteer: widget.currentVolunteer),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => ProfilePage(volunteer: widget.currentVolunteer),
      },
    );
  }
}
