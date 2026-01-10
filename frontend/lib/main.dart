import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// Services and Data
import 'data/services/firebase_sync_service.dart';
import 'data/services/database_helper.dart';
import 'data/repositories/volunteers_repository.dart';
import 'data/models/volunteer.dart';
import 'firebase_options.dart';
import 'data/services/notification.dart';

// Logic
import 'logic/cubit/volunteers_cubit.dart';
import 'logic/cubit/volunteer_registration_cubit.dart';

// UI
import 'l10n/app_localizations.dart';
import 'ui/screens/emergency_button_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/role_selection_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/firebase_test_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  Initialize local database
  await DatabaseHelper.instance.database;

  //  Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //  Setup Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Perform Initial Global Sync
  try {
    print(' Initializing Global Sync...');
    await FirebaseSyncService.instance.syncOnStartup();
    await FirebaseSyncService.instance.pullVolunteersFromCloud();
    print(' Global startup sync completed');
  } catch (e) {
    print(' Startup sync failed: $e');
  }

  //  Setup Repositories and User Sessions
  final volunteersRepository = VolunteersRepository();
  final prefs = await SharedPreferences.getInstance();
  final savedVolunteerId = prefs.getString('currentVolunteerId');

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

  // Fallback guest volunteer
  currentVolunteer ??= Volunteer(
    id: '0',
    name: 'Guest',
    phone: '',
    email: '',
    availability: false,
  );

  //  Run App
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              VolunteersCubit(volunteersRepository: volunteersRepository)
                ..loadAllVolunteers(),
        ),
        BlocProvider(
          create: (_) =>
              VolunteerRegistrationCubit(volunteersRepository: volunteersRepository),
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

  static _EmergencyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_EmergencyAppState>();
}

class _EmergencyAppState extends State<EmergencyApp> {
  Locale _locale = const Locale('ar'); // Default to Arabic

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();

    // Setup FCM notifications
    NotificationService.setupFCM(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allo Selekni',
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
        '/roleSelection': (context) =>
            RoleSelectionScreen(volunteer: widget.currentVolunteer),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) =>
            ProfilePage(volunteer: widget.currentVolunteer),
        '/firebaseTest': (context) => const FirebaseTestScreen(),
      },
    );
  }
}
