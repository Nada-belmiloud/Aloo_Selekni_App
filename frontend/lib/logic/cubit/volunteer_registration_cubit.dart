import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/volunteer.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../states/volunteer_registration_state.dart';

class VolunteerRegistrationCubit extends Cubit<VolunteerRegistrationState> {
  final VolunteersRepository volunteersRepository;
  final _uuid = const Uuid();

  VolunteerRegistrationCubit({
    required this.volunteersRepository,
  }) : super(VolunteerRegistrationState.initial());

  /// Register a new volunteer
  Future<void> registerVolunteer({
    required String name,
    required String phone,
    required String email,
    required String password, // ✅ ADDED
    required String address,
    required String wilaya,
    required String gender,
    String? certificatePath,
  }) async {
    emit(state.copyWith(status: RegistrationStatus.loading));

    try {
      // ---------------- VALIDATION ----------------
      if (name.isEmpty ||
          phone.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          address.isEmpty) {
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

      if (password.length < 6) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          errorMessage: 'كلمة المرور قصيرة جداً',
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

      // ---------------- CHECK PHONE ----------------
      final exists = await checkPhoneExists(phone);
      if (exists) {
        emit(state.copyWith(
          status: RegistrationStatus.error,
          errorMessage: 'رقم الهاتف مستخدم مسبقاً',
        ));
        return;
      }

      // ---------------- CREATE VOLUNTEER ----------------
      final volunteerId = _uuid.v4();

      final volunteer = Volunteer(
        id: volunteerId,
        name: name,
        phone: phone,
        email: email,
        wilaya: wilaya,
        location: address,
        commune: null,
        skills: const ['إسعافات أولية'],
        availability: true,
        imagePath: 'assets/images/profile.png',
        createdAt: DateTime.now(),
        // ⚠️ Password is NOT stored here unless your model supports it
      );

      // ---------------- SAVE ----------------
      await volunteersRepository.insertVolunteer(volunteer);

      emit(state.copyWith(
        status: RegistrationStatus.success,
        successMessage: 'تم التسجيل بنجاح! مرحباً بك في فريق المتطوعين',
        registeredVolunteer: volunteer,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegistrationStatus.error,
        errorMessage: 'حدث خطأ أثناء التسجيل: ${e.toString()}',
      ));
    }
  }

  /// Reset state
  void reset() {
    emit(VolunteerRegistrationState.initial());
  }

  /// Check if phone number already exists
  Future<bool> checkPhoneExists(String phone) async {
    try {
      final volunteers = await volunteersRepository.getAllVolunteers();
      return volunteers.any((v) => v.phone == phone);
    } catch (_) {
      return false;
    }
  }
}
