// lib/logic/states/volunteers_state.dart
import 'package:equatable/equatable.dart';
import '../../data/models/volunteer.dart';

enum VolunteersStatus {
  initial,
  loading,
  success,
  error,
  empty,
}

class VolunteersState extends Equatable {
  final VolunteersStatus status;
  final List<Volunteer> volunteers;
  final String? errorMessage;
  final String? filterWilaya;
  final bool showOnlyAvailable;

  const VolunteersState({
    required this.status,
    this.volunteers = const [],
    this.errorMessage,
    this.filterWilaya,
    this.showOnlyAvailable = false,
  });

  factory VolunteersState.initial() => const VolunteersState(
        status: VolunteersStatus.initial,
      );

  VolunteersState copyWith({
    VolunteersStatus? status,
    List<Volunteer>? volunteers,
    String? errorMessage,
    String? filterWilaya,
    bool? showOnlyAvailable,
  }) {
    return VolunteersState(
      status: status ?? this.status,
      volunteers: volunteers ?? this.volunteers,
      errorMessage: errorMessage ?? this.errorMessage,
      filterWilaya: filterWilaya ?? this.filterWilaya,
      showOnlyAvailable: showOnlyAvailable ?? this.showOnlyAvailable,
    );
  }

  @override
  List<Object?> get props => [
        status,
        volunteers,
        errorMessage,
        filterWilaya,
        showOnlyAvailable,
      ];
}