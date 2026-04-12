// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PredictionModel _$PredictionModelFromJson(Map<String, dynamic> json) =>
    _PredictionModel(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );

Map<String, dynamic> _$PredictionModelToJson(_PredictionModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
    };
