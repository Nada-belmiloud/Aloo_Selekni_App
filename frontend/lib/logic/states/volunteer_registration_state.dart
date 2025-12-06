// lib/logic/state/volunteer_registration_state.dart
import 'package:equatable/equatable.dart';

enum RegistrationStatus {
  initial,
  loading,
  success,
  error,
}

class VolunteerRegistrationState extends Equatable {
  final RegistrationStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String? volunteerId;

  const VolunteerRegistrationState({
    required this.status,
    this.errorMessage,
    this.successMessage,
    this.volunteerId,
  });

  factory VolunteerRegistrationState.initial() => const VolunteerRegistrationState(
        status: RegistrationStatus.initial,
      );

  VolunteerRegistrationState copyWith({
    RegistrationStatus? status,
    String? errorMessage,
    String? successMessage,
    String? volunteerId,
  }) {
    return VolunteerRegistrationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      volunteerId: volunteerId,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, volunteerId];
}