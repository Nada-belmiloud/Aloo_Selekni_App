// lib/logic/cubit/volunteers_cubit.dart
import 'package:bloc/bloc.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../states/voluteers_state.dart';

class VolunteersCubit extends Cubit<VolunteersState> {
  final VolunteersRepository volunteersRepository;

  VolunteersCubit({required this.volunteersRepository})
      : super(VolunteersState.initial());

  /// Load all volunteers
  Future<void> loadAllVolunteers() async {
    emit(state.copyWith(status: VolunteersStatus.loading));

    try {
      final volunteers = await volunteersRepository.getAllVolunteers();
      
      if (volunteers.isEmpty) {
        emit(state.copyWith(
          status: VolunteersStatus.empty,
          volunteers: [],
        ));
      } else {
        emit(state.copyWith(
          status: VolunteersStatus.success,
          volunteers: volunteers,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VolunteersStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Load volunteers by wilaya (Arabic name)
  Future<void> loadVolunteersByWilaya(String wilaya) async {
    emit(state.copyWith(
      status: VolunteersStatus.loading,
      filterWilaya: wilaya,
    ));

    try {
      final volunteers = state.showOnlyAvailable
          ? await volunteersRepository.getAvailableVolunteersByWilaya(wilaya)
          : await volunteersRepository.getVolunteersByWilaya(wilaya);

      if (volunteers.isEmpty) {
        emit(state.copyWith(
          status: VolunteersStatus.empty,
          volunteers: [],
        ));
      } else {
        emit(state.copyWith(
          status: VolunteersStatus.success,
          volunteers: volunteers,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VolunteersStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Toggle availability filter
  Future<void> toggleAvailabilityFilter() async {
    final newShowOnlyAvailable = !state.showOnlyAvailable;
    emit(state.copyWith(showOnlyAvailable: newShowOnlyAvailable));

    // Reload with new filter
    if (state.filterWilaya != null && state.filterWilaya!.isNotEmpty) {
      await loadVolunteersByWilaya(state.filterWilaya!);
    } else {
      await loadAllVolunteers();
    }
  }

  /// Search volunteers by name
  Future<void> searchVolunteers(String name) async {
    if (name.isEmpty) {
      // If search is cleared, reload based on current filter
      if (state.filterWilaya != null && state.filterWilaya!.isNotEmpty) {
        await loadVolunteersByWilaya(state.filterWilaya!);
      } else {
        await loadAllVolunteers();
      }
      return;
    }

    emit(state.copyWith(status: VolunteersStatus.loading));

    try {
      final volunteers = await volunteersRepository.searchVolunteersByName(name);
      
      if (volunteers.isEmpty) {
        emit(state.copyWith(
          status: VolunteersStatus.empty,
          volunteers: [],
        ));
      } else {
        emit(state.copyWith(
          status: VolunteersStatus.success,
          volunteers: volunteers,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VolunteersStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Clear all filters and reload all volunteers
  Future<void> clearFilters() async {
    emit(state.copyWith(
      filterWilaya: null,
      showOnlyAvailable: false,
    ));
    await loadAllVolunteers();
  }

  /// Refresh volunteers (reload current view)
  Future<void> refresh() async {
    if (state.filterWilaya != null && state.filterWilaya!.isNotEmpty) {
      await loadVolunteersByWilaya(state.filterWilaya!);
    } else {
      await loadAllVolunteers();
    }
  }
}