import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/prediction_model.dart';
import '../../../../core/exceptions/app_exception.dart';

abstract class MapsRepository {
  Future<List<PredictionModel>> getPredictions(String input, String sessionToken);
  Future<Map<String, String>> getPlaceDetails(String placeId);
  Future<Map<String, double>?> geocodeAddress(String address);
}

@LazySingleton(as: MapsRepository)
class MapsRepositoryImpl implements MapsRepository {
  final Dio _dio;
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  // Note: Using the provided general key
  static const String _apiKey = 'AIzaSyCKGwrw9jYguoScBgyAUPMsTyxcASjlDGY';

  MapsRepositoryImpl(this._dio);

  @override
  Future<List<PredictionModel>> getPredictions(String input, String sessionToken) async {
    if (input.isEmpty) return [];
    
    try {
      final response = await _dio.get(
        '$_baseUrl/autocomplete/json',
        queryParameters: {
          'input': input,
          'key': _apiKey,
          'sessiontoken': sessionToken,
          'types': 'address',
          'language': 'pl',
          'components': 'country:pl', // Restrict to Poland as requested/implied
        },
      );

      if (response.data['status'] == 'OK') {
        final predictions = (response.data['predictions'] as List)
            .map((json) => PredictionModel.fromJson(json))
            .toList();
        return predictions;
      }
      return [];
    } catch (e) {
      throw const AppException('failed-to-fetch-predictions');
    }
  }

  @override
  Future<Map<String, String>> getPlaceDetails(String placeId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/details/json',
        queryParameters: {
          'place_id': placeId,
          'key': _apiKey,
          'fields': 'address_components,geometry',
        },
      );

      if (response.data['status'] == 'OK') {
        final result = response.data['result'];
        final components = result['address_components'] as List;
        
        String street = '';
        String streetNumber = '';
        String city = '';
        String zipCode = '';
        
        for (var component in components) {
          final types = component['types'] as List;
          if (types.contains('route')) street = component['long_name'];
          if (types.contains('street_number')) streetNumber = component['long_name'];
          if (types.contains('locality')) city = component['long_name'];
          if (types.contains('postal_code')) zipCode = component['long_name'];
        }

        return {
          'street': streetNumber.isNotEmpty ? '$street $streetNumber' : street,
          'city': city,
          'zipCode': zipCode,
          'latitude': result['geometry']['location']['lat'].toString(),
          'longitude': result['geometry']['location']['lng'].toString(),
        };
      }
      throw const AppException('failed-to-fetch-details');
    } catch (e) {
      throw const AppException('failed-to-fetch-details');
    }
  }

  @override
  Future<Map<String, double>?> geocodeAddress(String address) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'address': address,
          'key': _apiKey,
        },
      );

      if (response.data['status'] == 'OK' && (response.data['results'] as List).isNotEmpty) {
        final location = response.data['results'][0]['geometry']['location'];
        return {
          'lat': location['lat'] as double,
          'lng': location['lng'] as double,
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
