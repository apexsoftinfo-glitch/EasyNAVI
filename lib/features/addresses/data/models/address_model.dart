import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
abstract class AddressModel with _$AddressModel {
  const factory AddressModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    required String street,
    required String city,
    @JsonKey(name: 'zip_code') required String zipCode,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
