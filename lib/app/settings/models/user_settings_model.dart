import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings_model.freezed.dart';
part 'user_settings_model.g.dart';

@freezed
abstract class UserSettingsModel with _$UserSettingsModel {
  const factory UserSettingsModel({
    required String locale,
    required double brightness,
    required int carIconIndex,
    required double speechRate,
    required double speechPitch,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);
}
