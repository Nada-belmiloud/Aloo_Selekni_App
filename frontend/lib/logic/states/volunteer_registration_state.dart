// lib/logic/states/volunteer_registration_state.dart
import 'package:equatable/equatable.dart';
import '../../data/models/volunteer.dart';

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
  final Volunteer? registeredVolunteer; // <-- store volunteer

  const VolunteerRegistrationState({
    required this.status,
    this.errorMessage,
    this.successMessage,
    this.volunteerId,
    this.registeredVolunteer, // <-- add here
  });

  factory VolunteerRegistrationState.initial() {
    return const VolunteerRegistrationState(status: RegistrationStatus.initial);
  }

  VolunteerRegistrationState copyWith({
    RegistrationStatus? status,
    String? errorMessage,
    String? successMessage,
    String? volunteerId,
    Volunteer? registeredVolunteer, // <-- add here
  }) {
    return VolunteerRegistrationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      volunteerId: volunteerId ?? this.volunteerId,
      registeredVolunteer: registeredVolunteer ?? this.registeredVolunteer, // <-- add here
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        successMessage,
        volunteerId,
        registeredVolunteer, // <-- include in props
      ];
}