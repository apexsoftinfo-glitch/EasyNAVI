import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:easynavi/app/appearance/data/repositories/app_appearance_repository.dart';
import 'package:easynavi/app/appearance/models/car_icon_model.dart';
import 'package:easynavi/app/appearance/presentation/cubit/app_appearance_cubit.dart';
import 'package:easynavi/app/locale/models/app_locale_option_model.dart';
import 'package:rxdart/rxdart.dart';

class MockAppAppearanceRepository extends Mock implements AppAppearanceRepository {}

void main() {
  late MockAppAppearanceRepository mockRepository;
  late BehaviorSubject<AppLocaleOptionModel> localeController;
  late BehaviorSubject<double> brightnessController;
  late BehaviorSubject<CarIconType> carIconController;

  setUp(() {
    mockRepository = MockAppAppearanceRepository();
    localeController = BehaviorSubject<AppLocaleOptionModel>.seeded(AppLocaleOptionModel.system);
    brightnessController = BehaviorSubject<double>.seeded(0.5);
    carIconController = BehaviorSubject<CarIconType>.seeded(CarIconType.classic);

    when(() => mockRepository.currentLocale).thenReturn(AppLocaleOptionModel.system);
    when(() => mockRepository.currentBrightness).thenReturn(0.5);
    when(() => mockRepository.currentCarIcon).thenReturn(CarIconType.classic);
    
    when(() => mockRepository.localeStream).thenAnswer((_) => localeController.stream);
    when(() => mockRepository.brightnessStream).thenAnswer((_) => brightnessController.stream);
    when(() => mockRepository.carIconStream).thenAnswer((_) => carIconController.stream);
    
    when(() => mockRepository.init()).thenAnswer((_) async {});
  });

  tearDown(() {
    localeController.close();
    brightnessController.close();
    carIconController.close();
  });

  group('AppAppearanceCubit', () {
    test('initial state is correct based on repository', () {
      final cubit = AppAppearanceCubit(mockRepository);
      expect(cubit.state, const AppAppearanceState(
        selectedLocale: AppLocaleOptionModel.system,
        brightness: 0.5,
        carIcon: CarIconType.classic,
      ));
      cubit.close();
    });

    blocTest<AppAppearanceCubit, AppAppearanceState>(
      'setBrightness calls repository',
      build: () => AppAppearanceCubit(mockRepository),
      act: (cubit) async {
        when(() => mockRepository.setBrightness(0.8)).thenAnswer((_) async {});
        await cubit.setBrightness(0.8);
      },
      verify: (_) {
        verify(() => mockRepository.setBrightness(0.8)).called(1);
      },
    );

    blocTest<AppAppearanceCubit, AppAppearanceState>(
      'setCarIcon calls repository',
      build: () => AppAppearanceCubit(mockRepository),
      act: (cubit) async {
        when(() => mockRepository.setCarIcon(CarIconType.truck)).thenAnswer((_) async {});
        await cubit.setCarIcon(CarIconType.truck);
      },
      verify: (_) {
        verify(() => mockRepository.setCarIcon(CarIconType.truck)).called(1);
      },
    );

    blocTest<AppAppearanceCubit, AppAppearanceState>(
      'emits updated state when repository stream pushes new values',
      build: () => AppAppearanceCubit(mockRepository),
      wait: const Duration(milliseconds: 100),
      act: (_) {
        // We push different values to trigger state changes
        brightnessController.add(0.9);
        carIconController.add(CarIconType.sport);
      },
      // Skip the initial emission that happens during wait phase
      skip: 1,
      expect: () => [
        const AppAppearanceState(
          selectedLocale: AppLocaleOptionModel.system,
          brightness: 0.9,
          carIcon: CarIconType.classic,
        ),
        const AppAppearanceState(
          selectedLocale: AppLocaleOptionModel.system,
          brightness: 0.9,
          carIcon: CarIconType.sport,
        ),
      ],
    );
  });
}
