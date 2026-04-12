import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/directions_model.dart';
import '../../../../core/exceptions/app_exception.dart';

abstract class DirectionsRepository {
  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
  });
}

@LazySingleton(as: DirectionsRepository)
class DirectionsRepositoryImpl implements DirectionsRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
  static const String _apiKey = 'AIzaSyCKGwrw9jYguoScBgyAUPMsTyxcASjlDGY';

  DirectionsRepositoryImpl(this._dio);

  @override
  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
          'mode': 'driving',
          'language': 'pl',
        },
      );

      if (response.data['status'] == 'OK') {
        final data = response.data['routes'][0];
        
        final bounds = data['bounds'];
        final northeast = bounds['northeast'];
        final southwest = bounds['southwest'];
        
        final legs = data['legs'][0];
        
        return DirectionsModel(
          boundsSw: LatLng(southwest['lat'] as double, southwest['lng'] as double),
          boundsNe: LatLng(northeast['lat'] as double, northeast['lng'] as double),
          polylinePoints: PolylinePoints.decodePolyline(data['overview_polyline']['points'] as String)
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
          totalDistance: legs['distance']['text'] as String,
          totalDuration: legs['duration']['text'] as String,
        );
      }
      return null;
    } catch (e) {
      throw const AppException('failed-to-fetch-directions');
    }
  }
}
