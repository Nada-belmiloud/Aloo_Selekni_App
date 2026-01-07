// lib/logic/cubit/volunteers_cubit.dart
import 'package:bloc/bloc.dart';
import '../../data/models/volunteer.dart';
import '../../data/repositories/volunteers_repository.dart';
import '../../data/services/firebase_sync_service.dart';
import '../states/voluteers_state.dart';

class VolunteersCubit extends Cubit<VolunteersState> {
  final VolunteersRepository volunteersRepository;

  VolunteersCubit({required this.volunteersRepository})
      : super(VolunteersState.initial());

  // ================= 1. MAIN LOAD (LOCAL) =================

  /// Fetches from SQLite and updates UI quickly
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
        errorMessage: 'Failed to load volunteers: ${e.toString()}',
      ));
    }
  }

  // ================= 2. PROFILE LOAD (CLOUD) =================

  /// ✅ CRITICAL FIX: Use this to get the certificate image after a restart.
  /// This pulls the data from Firestore so the Base64 string isn't null.
  Future<void> loadFullProfile(String id) async {
    try {
      final fullVolunteer = await volunteersRepository.getFullVolunteerFromCloud(id);
      
      if (fullVolunteer != null) {
        // Replace the "basic" volunteer in our list with the "full" one
        final updatedList = state.volunteers.map((v) {
          return v.id == id ? fullVolunteer : v;
        }).toList();

        emit(state.copyWith(
          volunteers: updatedList,
          status: VolunteersStatus.success,
        ));
      }
    } catch (e) {
      print("Error loading full profile: $e");
    }
  }

  // ================= 3. SYNC & REFRESH =================

  Future<void> refresh() async {
    if (state.volunteers.isEmpty) {
      emit(state.copyWith(status: VolunteersStatus.loading));
    }

    try {
      // 📥 Pull from Firestore to SQLite
      await FirebaseSyncService.instance.pullVolunteersFromCloud();

      // 📤 Sync local changes (Make sure toFirestoreMap uses the 'if' checks we added!)
      await FirebaseSyncService.instance.syncOnStartup();

      // 📑 Reload UI
      if (state.filterWilaya != null && state.filterWilaya!.isNotEmpty) {
        await loadVolunteersByWilaya(state.filterWilaya!);
      } else {
        await loadAllVolunteers();
      }
    } catch (e) {
      emit(state.copyWith(
        status: VolunteersStatus.error,
        errorMessage: 'Sync failed: ${e.toString()}',
      ));
    }
  }

  // ================= 4. FILTERS & SEARCH =================

  Future<void> loadVolunteersByWilaya(String wilaya) async {
    emit(state.copyWith(
      status: VolunteersStatus.loading,
      filterWilaya: wilaya,
    ));

    try {
      final volunteers = state.showOnlyAvailable
          ? await volunteersRepository.getAvailableVolunteersByWilaya(wilaya)
          : await volunteersRepository.getVolunteersByWilaya(wilaya);

      emit(state.copyWith(
        status: volunteers.isEmpty ? VolunteersStatus.empty : VolunteersStatus.success,
        volunteers: volunteers,
      ));
    } catch (e) {
      emit(state.copyWith(status: VolunteersStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> toggleAvailabilityFilter() async {
    final newShowOnlyAvailable = !state.showOnlyAvailable;
    emit(state.copyWith(showOnlyAvailable: newShowOnlyAvailable));

    if (state.filterWilaya != null && state.filterWilaya!.isNotEmpty) {
      await loadVolunteersByWilaya(state.filterWilaya!);
    } else {
      await loadAllVolunteers();
    }
  }

  Future<void> searchVolunteers(String name) async {
    if (name.isEmpty) {
      await loadAllVolunteers();
      return;
    }

    emit(state.copyWith(status: VolunteersStatus.loading));

    try {
      final volunteers = await volunteersRepository.searchVolunteersByName(name);
      
      emit(state.copyWith(
        status: volunteers.isEmpty ? VolunteersStatus.empty : VolunteersStatus.success,
        volunteers: volunteers,
      ));
    } catch (e) {
      emit(state.copyWith(status: VolunteersStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> clearFilters() async {
    emit(state.copyWith(
      filterWilaya: null,
      showOnlyAvailable: false,
    ));
    await loadAllVolunteers();
  }
}