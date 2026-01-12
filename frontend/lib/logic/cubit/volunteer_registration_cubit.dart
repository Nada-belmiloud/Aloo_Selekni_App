import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/volunteer.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../states/volunteer_registration_state.dart';

class VolunteerRegistrationCubit extends Cubit<VolunteerRegistrationState> {
  final VolunteersRepository volunteersRepository;

  VolunteerRegistrationCubit({required this.volunteersRepository})
      : super(VolunteerRegistrationState.initial());

  Future<void> registerVolunteer({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String wilaya,
    required String gender,
    required File certificateFile, 
    required String password,
  }) async {
    emit(state.copyWith(status: RegistrationStatus.loading));

    try {
      // 1. Create a Volunteer object
      final String volunteerId = DateTime.now().millisecondsSinceEpoch.toString();

      final newVolunteer = Volunteer(
        id: volunteerId,
        name: name,
        phone: phone,
        email: email,
        location: address,
        wilaya: wilaya,
        availability: true,
        createdAt: DateTime.now(),
      );

      // 2. Call the repository (Uploads to Firestore & Saves to SQLite)
      await volunteersRepository.registerVolunteerWithCertificate(
        volunteer: newVolunteer,
        certificateFile: certificateFile,
      );

      // ✅ FIXED: You must pass 'registeredVolunteer: newVolunteer' 
      // otherwise the UI listener won't see the data to navigate!
      emit(state.copyWith(
        status: RegistrationStatus.success,
        registeredVolunteer: newVolunteer, 
      ));
      
    } catch (e) {
      emit(state.copyWith(
        status: RegistrationStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}