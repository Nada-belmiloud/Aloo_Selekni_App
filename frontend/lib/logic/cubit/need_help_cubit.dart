import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/repositories/geolocation_repository.dart';

enum NeedHelpStatus {
  initial,
  loading,
  permissionDenied,
  disabledService,
  selectWilaya,
  success,
  error,
}

class NeedHelpState {
  final NeedHelpStatus status;
  final Position? position;
  final String? wilaya; // will always be Arabic if set
  final String? errorMessage;

  NeedHelpState({
    required this.status,
    this.position,
    this.wilaya,
    this.errorMessage,
  });

  NeedHelpState copyWith({
    NeedHelpStatus? status,
    Position? position,
    String? wilaya,
    String? errorMessage,
  }) {
    return NeedHelpState(
      status: status ?? this.status,
      position: position ?? this.position,
      wilaya: wilaya ?? this.wilaya,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory NeedHelpState.initial() => NeedHelpState(status: NeedHelpStatus.initial);
}

class NeedHelpCubit extends Cubit<NeedHelpState> {
  final GeolocationRepository geolocationRepository;

  NeedHelpCubit({required this.geolocationRepository})
      : super(NeedHelpState.initial());

  /// Convert any wilaya name to Arabic
String _toArabic(String wilaya) {
  final lower = wilaya.toLowerCase();
  // Find the first key that is contained in the extracted string
  final match = wilayaArabicNames.keys.firstWhere(
    (key) => lower.contains(key),
    orElse: () => '',
  );
  if (match.isNotEmpty) {
    return wilayaArabicNames[match]!; // return Arabic name
  }
  return wilaya; // fallback: return original if no match
}




  /// Request current location and save wilaya in Arabic
  Future<void> requestLocationAndWilaya() async {
    emit(state.copyWith(status: NeedHelpStatus.loading, errorMessage: null));

    try {
      // Check if location services are enabled
      final serviceEnabled = await geolocationRepository.isServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(status: NeedHelpStatus.disabledService));
        return;
      }

      // Check permissions
      LocationPermission permission = await geolocationRepository.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await geolocationRepository.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(status: NeedHelpStatus.permissionDenied));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(
            status: NeedHelpStatus.permissionDenied,
            errorMessage: 'deniedForever'));
        return;
      }

      // Get current GPS position
      final pos = await geolocationRepository.getCurrentPosition();

      // Get wilaya from position (Latin letters)
      final wilayaFromGeo = await geolocationRepository.getWilayaFromPosition(pos);
      if (wilayaFromGeo != null) {
        final arabicWilaya = _toArabic(wilayaFromGeo);

        // Save Arabic wilaya in SharedPreferences
        await geolocationRepository.saveWilayaLocally(arabicWilaya);

        // Emit state with Arabic wilaya
        emit(NeedHelpState(
          status: NeedHelpStatus.success,
          position: pos,
          wilaya: arabicWilaya,
        ));
        return;
      }

      // Fallback: get saved wilaya (already Arabic if saved properly)
      final saved = await geolocationRepository.getSavedWilaya();
      if (saved != null && saved.isNotEmpty) {
        emit(NeedHelpState(
          status: NeedHelpStatus.success,
          position: pos,
          wilaya: saved,
        ));
        return;
      }

      // Ask user to select manually
      emit(NeedHelpState(status: NeedHelpStatus.selectWilaya, position: pos));
    } catch (e) {
      final saved = await geolocationRepository.getSavedWilaya();
      if (saved != null && saved.isNotEmpty) {
        emit(NeedHelpState(
          status: NeedHelpStatus.success,
          position: state.position,
          wilaya: saved,
        ));
        return;
      }
      emit(state.copyWith(status: NeedHelpStatus.error, errorMessage: e.toString()));
    }
  }

  /// Save manually selected wilaya (always convert to Arabic)
  Future<void> saveSelectedWilaya(String wilaya) async {
    final arabicWilaya = _toArabic(wilaya);
    await geolocationRepository.saveWilayaLocally(arabicWilaya);
    emit(state.copyWith(wilaya: arabicWilaya, status: NeedHelpStatus.success));
  }

  /// Load saved wilaya from SharedPreferences
  Future<void> loadSavedWilayaIfAny() async {
    final saved = await geolocationRepository.getSavedWilaya();
    if (saved != null && saved.isNotEmpty) {
      emit(state.copyWith(wilaya: saved, status: NeedHelpStatus.success));
    }
  }

  /// Clear saved wilaya
  Future<void> clearSavedWilaya() async {
    await geolocationRepository.clearSavedWilaya();
    emit(NeedHelpState.initial());
  }
}
