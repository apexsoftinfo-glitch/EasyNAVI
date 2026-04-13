import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/directions_model.dart';
import '../../../../core/exceptions/app_exception.dart';

abstract class DirectionsRepository {
  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
    String language = 'en',
  });
  Future<int?> getSpeedLimit(LatLng position);
  Future<List<LatLng>> getNearbyRadars(LatLng position);
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
    String language = 'en',
  }) async {
    try {
      debugPrint('[DirectionsRepository] Calculating route: ${origin.latitude},${origin.longitude} -> ${destination.latitude},${destination.longitude}');
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
          'mode': 'driving',
          'language': language,
        },
      );

      debugPrint('[DirectionsRepository] Status: ${response.data['status']}');

      if (response.data['status'] == 'OK') {
        final data = response.data['routes'][0];
        
        final bounds = data['bounds'];
        final northeast = bounds['northeast'];
        final southwest = bounds['southwest'];
        
        final legs = data['legs'][0];
        final stepsData = legs['steps'] as List;
        
        final steps = stepsData.map((step) {
          final startLocation = step['start_location'];
          return RouteStepModel(
            startLocation: LatLng(startLocation['lat'] as double, startLocation['lng'] as double),
            instruction: (step['html_instructions'] as String).replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
            distance: step['distance']['text'] as String,
            maneuver: (step['maneuver'] as String?) ?? '',
          );
        }).toList();

        return DirectionsModel(
          boundsSw: LatLng(southwest['lat'] as double, southwest['lng'] as double),
          boundsNe: LatLng(northeast['lat'] as double, northeast['lng'] as double),
          polylinePoints: PolylinePoints.decodePolyline(data['overview_polyline']['points'] as String)
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
          totalDistance: legs['distance']['text'] as String,
          totalDuration: legs['duration']['text'] as String,
          totalDistanceValue: legs['distance']['value'] as int,
          totalDurationValue: legs['duration']['value'] as int,
          steps: steps,
        );
      } else {
        debugPrint('[DirectionsRepository] Error message: ${response.data['error_message']}');
      }
      return null;
    } catch (e) {
      debugPrint('[DirectionsRepository] Exception: $e');
      throw const AppException('failed-to-fetch-directions');
    }
  }

  @override
  Future<int?> getSpeedLimit(LatLng position) async {
    try {
      final query = '[out:json];way(around:30,${position.latitude},${position.longitude})["maxspeed"];out;';
      final response = await _dio.get(
        'https://overpass-api.de/api/interpreter',
        queryParameters: {'data': query},
      );

      if (response.data != null && response.data['elements'] != null) {
        final elements = response.data['elements'] as List;
        if (elements.isNotEmpty) {
          final tags = elements[0]['tags'];
          if (tags != null && tags['maxspeed'] != null) {
            final maxSpeedStr = tags['maxspeed'] as String;
            // Handle values like "50", "90", or "120 km/h"
            final speed = int.tryParse(maxSpeedStr.replaceAll(RegExp(r'[^0-9]'), ''));
            return speed;
          }
        }
      }
      return null;
    } catch (e) {
      debugPrint('[DirectionsRepository] Speed Limit error: $e');
      return null;
    }
  }

  @override
  Future<List<LatLng>> getNearbyRadars(LatLng position) async {
    try {
      final query = '[out:json];node(around:1000,${position.latitude},${position.longitude})["highway"="speed_camera"];out;';
      final response = await _dio.get(
        'https://overpass-api.de/api/interpreter',
        queryParameters: {'data': query},
      );

      if (response.data != null && response.data['elements'] != null) {
        final elements = response.data['elements'] as List;
        return elements.map((e) => LatLng(e['lat'] as double, e['lon'] as double)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('[DirectionsRepository] Radars error: $e');
      return [];
    }
  }
}
