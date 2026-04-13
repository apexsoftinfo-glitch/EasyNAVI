import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class LocationService {
  Future<bool> isLocationServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition();
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  });
}

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  @override
  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  @override
  Future<LocationPermission> requestPermission() => Geolocator.requestPermission();

  @override
  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();

  @override
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  }) => Geolocator.getPositionStream(locationSettings: locationSettings);
}
