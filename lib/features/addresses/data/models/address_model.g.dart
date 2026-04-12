// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      zipCode: json['zip_code'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'street': instance.street,
      'city': instance.city,
      'zip_code': instance.zipCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_at': instance.createdAt?.toIso8601String(),
    };
