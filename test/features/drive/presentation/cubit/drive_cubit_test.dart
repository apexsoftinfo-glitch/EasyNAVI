import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easynavi/core/services/location_service.dart';
import 'package:easynavi/core/services/voice_navigation_service.dart';
import 'package:easynavi/core/services/device_service.dart';
import 'package:easynavi/features/drive/data/models/directions_model.dart';
import 'package:easynavi/features/drive/domain/repositories/directions_repository.dart';
import 'package:easynavi/features/drive/presentation/cubit/drive_cubit.dart';

class MockDirectionsRepository extends Mock implements DirectionsRepository {}
class MockNavigationVoiceService extends Mock implements NavigationVoiceService {}
class MockLocationService extends Mock implements LocationService {}
class MockDeviceService extends Mock implements DeviceService {}

class LatLngFake extends Fake implements LatLng {}

void main() {
  late MockDirectionsRepository mockRepository;
  late MockNavigationVoiceService mockVoiceService;
  late MockLocationService mockLocationService;
  late MockDeviceService mockDeviceService;
  late StreamController<Position> positionStreamController;

  registerFallbackValue(LatLngFake());

  final testOrigin = const LatLng(52.0, 21.0);
  final testDestination = const LatLng(52.1, 21.1);
  
  final testDirections = DirectionsModel(
    boundsSw: testOrigin,
    boundsNe: testDestination,
    polylinePoints: [testOrigin, testDestination],
    totalDistance: '10 km',
    totalDuration: '15 min',
    totalDistanceValue: 10000,
    totalDurationValue: 900,
    steps: [
      RouteStepModel(
        startLocation: testOrigin,
        instruction: 'Jedź prosto',
        distance: '5 km',
        maneuver: 'straight',
      ),
      RouteStepModel(
        startLocation: testDestination,
        instruction: 'Cel osiągnięty',
        distance: '0m',
        maneuver: 'arrival',
      ),
    ],
  );

  Position createPosition({double lat = 52.0, double lng = 21.0, double speed = 0.0, double accuracy = 10.0}) {
    return Position(
      latitude: lat,
      longitude: lng,
      timestamp: DateTime.now(),
      accuracy: accuracy,
      altitude: 0,
      heading: 0,
      speed: speed,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  setUp(() {
    mockRepository = MockDirectionsRepository();
    mockVoiceService = MockNavigationVoiceService();
    mockLocationService = MockLocationService();
    mockDeviceService = MockDeviceService();
    positionStreamController = StreamController<Position>();

    when(() => mockVoiceService.speak(any())).thenAnswer((_) async {});
    when(() => mockVoiceService.stop()).thenAnswer((_) async {});
    when(() => mockDeviceService.enableWakelock()).thenAnswer((_) async {});
    when(() => mockDeviceService.disableWakelock()).thenAnswer((_) async {});
  });

  tearDown(() {
    positionStreamController.close();
  });

  group('DriveCubit', () {
    blocTest<DriveCubit, DriveState>(
      'initDrive emits loading then loaded on success',
      build: () {
        when(() => mockLocationService.isLocationServiceEnabled()).thenAnswer((_) async => true);
        when(() => mockLocationService.checkPermission()).thenAnswer((_) async => LocationPermission.always);
        when(() => mockLocationService.getCurrentPosition()).thenAnswer((_) async => createPosition());
        when(() => mockRepository.getDirections(origin: any(named: 'origin'), destination: any(named: 'destination')))
            .thenAnswer((_) async => testDirections);
        return DriveCubit(mockRepository, mockVoiceService, mockLocationService, mockDeviceService);
      },
      act: (cubit) => cubit.initDrive(destination: testDestination),
      expect: () => [
        const DriveState.loading(),
        DriveState.loaded(
          origin: testOrigin,
          destination: testDestination,
          directions: testDirections,
        ),
      ],
    );

    blocTest<DriveCubit, DriveState>(
      'startNavigation updates state and speaks first instruction',
      build: () {
        when(() => mockLocationService.getPositionStream(locationSettings: any(named: 'locationSettings')))
            .thenAnswer((_) => positionStreamController.stream);
        return DriveCubit(mockRepository, mockVoiceService, mockLocationService, mockDeviceService);
      },
      seed: () => DriveState.loaded(
        origin: testOrigin,
        destination: testDestination,
        directions: testDirections,
      ),
      act: (cubit) => cubit.startNavigation(),
      expect: () => [
        isA<Loaded>().having((s) => s.isNavigating, 'isNavigating', true),
      ],
      verify: (_) {
        verify(() => mockVoiceService.speak('Jedź prosto')).called(1);
        verify(() => mockDeviceService.enableWakelock()).called(1);
      },
    );

    blocTest<DriveCubit, DriveState>(
      'onPositionChanged updates current details and checks speed limit',
      build: () {
        when(() => mockLocationService.getPositionStream(locationSettings: any(named: 'locationSettings')))
            .thenAnswer((_) => positionStreamController.stream);
        when(() => mockRepository.getSpeedLimit(any())).thenAnswer((_) async => 50);
        when(() => mockRepository.getNearbyRadars(any())).thenAnswer((_) async => []);
        return DriveCubit(mockRepository, mockVoiceService, mockLocationService, mockDeviceService);
      },
      seed: () => DriveState.loaded(
        origin: testOrigin,
        destination: testDestination,
        directions: testDirections,
        isNavigating: true,
      ),
      act: (cubit) async {
        cubit.startNavigation();
        // Simulate movement
        positionStreamController.add(createPosition(lat: 52.001, lng: 21.001, speed: 15.0)); // 15 m/s = 54 km/h
        await Future.delayed(Duration.zero);
      },
      skip: 1, // skip navigation start state
      expect: () => [
        isA<Loaded>().having((s) => s.currentSpeed.round(), 'speed', 54),
        isA<Loaded>().having((s) => s.currentSpeedLimit, 'speedLimit', 50),
      ],
    );
   group('DriveCubit - Error cases', () {
      blocTest<DriveCubit, DriveState>(
        'initDrive emits error when location services are disabled',
        build: () {
          when(() => mockLocationService.isLocationServiceEnabled()).thenAnswer((_) async => false);
          return DriveCubit(mockRepository, mockVoiceService, mockLocationService, mockDeviceService);
        },
        act: (cubit) => cubit.initDrive(destination: testDestination),
        expect: () => [
          const DriveState.loading(),
          const DriveState.error('location-services-disabled'),
        ],
      );
    });
  });
}
