import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../../shared/error_messages.dart';
import '../../data/repositories/shared_user_repository.dart';

import '../../../auth/data/repositories/auth_repository.dart';

part 'profile_cubit.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial({
    @Default(false) bool isSaving,
    String? errorKey,
    String? successKey,
    String? appVersion,
  }) = ProfileStateData;
}

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._sharedUserRepository, this._authRepository)
    : super(const ProfileState.initial()) {
    _loadAppInfo();
  }

  final SharedUserRepository _sharedUserRepository;
  final AuthRepository _authRepository;

  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      emit(state.copyWith(appVersion: '${packageInfo.version}+${packageInfo.buildNumber}'));
    } catch (e) {
      debugPrint('❌ [ProfileCubit] _loadAppInfo error: $e');
    }
  }

  Future<void> saveFirstName({
    required String userId,
    required String firstName,
  }) async {
    if (state.isSaving) return;

    emit(state.copyWith(isSaving: true, errorKey: null, successKey: null));

    try {
      await _sharedUserRepository.updateFirstName(
        userId: userId,
        firstName: firstName,
      );
      emit(state.copyWith(isSaving: false, successKey: 'profile_saved'));
    } catch (error) {
      debugPrint('❌ [ProfileCubit] saveFirstName error: $error');
      emit(state.copyWith(isSaving: false, errorKey: mapErrorToKey(error)));
    }
  }

  Future<void> signOut() async {
    if (state.isSaving) return;
    emit(state.copyWith(isSaving: true, errorKey: null, successKey: null));
    try {
      await _authRepository.signOut();
      emit(state.copyWith(isSaving: false));
    } catch (error) {
      debugPrint('❌ [ProfileCubit] signOut error: $error');
      emit(state.copyWith(isSaving: false, errorKey: mapErrorToKey(error)));
    }
  }

  Future<void> deleteAccount() async {
    if (state.isSaving) return;
    emit(state.copyWith(isSaving: true, errorKey: null, successKey: null));
    try {
      await _authRepository.deleteAccount();
      emit(state.copyWith(isSaving: false, successKey: 'account_deleted'));
    } catch (error) {
      debugPrint('❌ [ProfileCubit] deleteAccount error: $error');
      emit(state.copyWith(isSaving: false, errorKey: mapErrorToKey(error)));
    }
  }

  void clearFeedback() {
    if (state.errorKey == null && state.successKey == null) return;
    emit(state.copyWith(errorKey: null, successKey: null));
  }
}
