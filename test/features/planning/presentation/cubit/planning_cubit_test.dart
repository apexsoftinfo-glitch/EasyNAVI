import 'package:bloc_test/bloc_test.dart';
import 'package:easynavi/features/addresses/data/models/address_model.dart';
import 'package:easynavi/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:easynavi/features/planning/presentation/cubit/planning_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressesRepository extends Mock implements AddressesRepository {}

void main() {
  late PlanningCubit planningCubit;
  late MockAddressesRepository addressesRepository;

  final tAddresses = [
    AddressModel(id: '1', userId: 'u1', name: 'A', street: 'S1', city: 'C1', zipCode: '1'),
    AddressModel(id: '2', userId: 'u1', name: 'B', street: 'S2', city: 'C2', zipCode: '2'),
  ];

  setUp(() {
    addressesRepository = MockAddressesRepository();
    when(() => addressesRepository.observeAddresses()).thenAnswer((_) => Stream.value(tAddresses));
    planningCubit = PlanningCubit(addressesRepository);
  });

  group('PlanningCubit', () {
    test('initial state is loaded with addresses from repo after delay', () async {
      await Future.delayed(Duration.zero);
      expect(planningCubit.state, isA<Loaded>().having((s) => s.allAddresses, 'allAddresses', tAddresses));
    });

    blocTest<PlanningCubit, PlanningState>(
      'toggleSelection adds/removes address from selection',
      build: () => planningCubit,
      seed: () => Loaded(allAddresses: tAddresses),
      act: (cubit) {
        cubit.toggleSelection(tAddresses[0]);
        cubit.toggleSelection(tAddresses[0]);
      },
      expect: () => [
        isA<Loaded>().having((s) => s.selectedAddressIds, 'selectedAddressIds', ['1']),
        isA<Loaded>().having((s) => s.selectedAddressIds, 'selectedAddressIds', []),
      ],
    );

    blocTest<PlanningCubit, PlanningState>(
      'planRoute (sequence) sorts by selection order',
      build: () => planningCubit,
      seed: () => Loaded(allAddresses: tAddresses, selectedAddressIds: ['2', '1']),
      act: (cubit) => cubit.planRoute(PlanningMode.sequence),
      expect: () => [
        isA<Loaded>().having((s) => s.plannedAddresses.map((a) => a.id), 'plannedAddresses', ['2', '1']),
      ],
    );
  });
}
