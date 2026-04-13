import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_icon_model.freezed.dart';

@freezed
abstract class CarIconModel with _$CarIconModel {
  const factory CarIconModel({
    required String id,
    required String name,
    required String assetPath,
  }) = _CarIconModel;
}

enum CarIconType {
  classic,
  sport,
  suv,
  truck,
  sedan
}

extension CarIconTypeX on CarIconType {
  String get name {
    return switch (this) {
      CarIconType.classic => 'Klasyczny (Kropka)',
      CarIconType.sport => 'Sportowy',
      CarIconType.suv => 'SUV',
      CarIconType.truck => 'Ciężarówka',
      CarIconType.sedan => 'Sedan',
    };
  }

  String get assetPath {
    final base = 'assets/images/cars';
    return switch (this) {
      CarIconType.classic => 'classic', // Special case handling in UI
      CarIconType.sport => '$base/car_sport.png',
      CarIconType.suv => '$base/car_suv.png',
      CarIconType.truck => '$base/car_truck.png',
      CarIconType.sedan => '$base/car_sedan.png',
    };
  }
}
