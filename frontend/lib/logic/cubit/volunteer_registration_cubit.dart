// lib/logic/cubit/volunteer_registration_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/volunteer.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../states/volunteer_registration_state.dart';

class VolunteerRegistrationCubit extends Cubit<VolunteerRegistrationState> {
  final VolunteersRepository volunteersRepository;
  final _uuid = const Uuid();

  VolunteerRegistrationCubit({required this.volunteersRepository})
      : super(VolunteerRegistrationState.initial());

  /// Register a new volunteer
  Future<void> registerVolunteer({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String wilaya,
    required String gender,
    String? certificatePath,
  }) async {
    emit(state.copyWith(status: RegistrationStatus.loading));

    try {
      // Validate inputs
      if (name.isEmpty || phone.isEmpty || email.isEmpty || address.isEmpty) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          errorMessage: 'جميع الحقول مطلوبة',
        ));
        return;
      }

      if (!email.contains('@')) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          errorMessage: 'البريد الإلكتروني غير صحيح',
        ));
        return;
      }

      if (certificatePath == null || certificatePath.isEmpty) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          errorMessage: 'يجب تحميل شهادة الاعتماد',
        ));
        return;
      }

      // Generate unique ID
      final volunteerId = _uuid.v4();

      // Create volunteer object
      final volunteer = Volunteer(
        id: volunteerId,
        name: name,
        phone: phone,
        wilaya: wilaya,
        location: address,
        commune: null, // Can be added later if needed
        skills: ['إسعافات أولية'], // Default skill, can be expanded
        availability: true, // New volunteers are available by default
        imagePath: 'assets/images/profile.png', // Default image
        createdAt: DateTime.now(),
      );

      // Insert into database
      await volunteersRepository.insertVolunteer(volunteer);

      // Success
      emit(state.copyWith(
        status: RegistrationStatus.success,
        successMessage: 'تم التسجيل بنجاح! مرحباً بك في فريق المتطوعين',
        volunteerId: volunteerId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegistrationStatus.error,
        errorMessage: 'حدث خطأ أثناء التسجيل: ${e.toString()}',
      ));
    }
  }

  /// Reset state to initial
  void reset() {
    emit(VolunteerRegistrationState.initial());
  }

  /// Check if phone number already exists
  Future<bool> checkPhoneExists(String phone) async {
    try {
      final volunteers = await volunteersRepository.getAllVolunteers();
      return volunteers.any((v) => v.phone == phone);
    } catch (e) {
      return false;
    }
  }
}