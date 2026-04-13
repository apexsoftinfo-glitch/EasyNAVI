import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myapp/features/addresses/data/models/address_model.dart';
import 'package:myapp/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:myapp/features/addresses/domain/repositories/maps_repository.dart';
import 'package:myapp/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:rxdart/rxdart.dart';

class MockAddressesRepository extends Mock implements AddressesRepository {}
class MockMapsRepository extends Mock implements MapsRepository {}

class AddressModelFake extends Fake implements AddressModel {}

void main() {
  late MockAddressesRepository mockAddressesRepository;
  late MockMapsRepository mockMapsRepository;
  late BehaviorSubject<List<AddressModel>> addressesController;

  setUpAll(() {
    registerFallbackValue(AddressModelFake());
  });

  final testAddress = AddressModel(
    id: '1',
    userId: 'user1',
    name: 'Home',
    street: 'Main St',
    city: 'Warsaw',
    zipCode: '00-001',
    createdAt: DateTime(2023),
  );

  setUp(() {
    mockAddressesRepository = MockAddressesRepository();
    mockMapsRepository = MockMapsRepository();
    addressesController = BehaviorSubject<List<AddressModel>>.seeded([]);

    when(() => mockAddressesRepository.observeAddresses()).thenAnswer((_) => addressesController.stream);
  });

  tearDown(() {
    addressesController.close();
  });

  group('AddressesCubit', () {
    blocTest<AddressesCubit, AddressesState>(
      'emits Loaded when repository pushes addresses (Loading is skipped due to sync emit in constructor)',
      build: () => AddressesCubit(mockAddressesRepository, mockMapsRepository),
      expect: () => [
        const AddressesState.loaded([]),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'setSearchQuery updates state',
      build: () => AddressesCubit(mockAddressesRepository, mockMapsRepository),
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.setSearchQuery('test');
      },
      expect: () => [
        const AddressesState.loaded([]),
        isA<Loaded>().having((s) => s.searchQuery, 'searchQuery', 'test'),
      ],
    );

    blocTest<AddressesCubit, AddressesState>(
      'deleteAddress calls repository but does not emit new state (handled by stream)',
      build: () => AddressesCubit(mockAddressesRepository, mockMapsRepository),
      wait: const Duration(milliseconds: 100),
      act: (cubit) async {
        when(() => mockAddressesRepository.deleteAddress('1')).thenAnswer((_) async {});
        await cubit.deleteAddress('1');
      },
      verify: (_) {
        verify(() => mockAddressesRepository.deleteAddress('1')).called(1);
      },
    );

    blocTest<AddressesCubit, AddressesState>(
      'resolveCoordinates fetches coords and updates repository',
      build: () => AddressesCubit(mockAddressesRepository, mockMapsRepository),
      wait: const Duration(milliseconds: 100),
      act: (cubit) async {
        final addressWithoutCoords = testAddress.copyWith(latitude: null, longitude: null);
        when(() => mockMapsRepository.geocodeAddress(any())).thenAnswer((_) async => {'lat': 52.0, 'lng': 21.0});
        when(() => mockAddressesRepository.updateAddress(any())).thenAnswer((_) async {});
        
        final result = await cubit.resolveCoordinates(addressWithoutCoords);
        
        expect(result?.latitude, 52.0);
        expect(result?.longitude, 21.0);
      },
      verify: (_) {
        verify(() => mockMapsRepository.geocodeAddress(any())).called(1);
        verify(() => mockAddressesRepository.updateAddress(any())).called(1);
      },
    );
  });
}
