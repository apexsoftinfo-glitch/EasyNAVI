// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettingsModel _$UserSettingsModelFromJson(Map<String, dynamic> json) =>
    _UserSettingsModel(
      locale: json['locale'] as String,
      brightness: (json['brightness'] as num).toDouble(),
      carIconIndex: (json['carIconIndex'] as num).toInt(),
      speechRate: (json['speechRate'] as num).toDouble(),
      speechPitch: (json['speechPitch'] as num).toDouble(),
    );

Map<String, dynamic> _$UserSettingsModelToJson(_UserSettingsModel instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'brightness': instance.brightness,
      'carIconIndex': instance.carIconIndex,
      'speechRate': instance.speechRate,
      'speechPitch': instance.speechPitch,
    };
