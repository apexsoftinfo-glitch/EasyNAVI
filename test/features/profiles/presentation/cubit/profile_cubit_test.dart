import 'package:bloc_test/bloc_test.dart';
import 'package:easynavi/features/auth/data/repositories/auth_repository.dart';
import 'package:easynavi/features/profiles/data/repositories/shared_user_repository.dart';
import 'package:easynavi/features/profiles/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MockSharedUserRepository extends Mock implements SharedUserRepository {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late ProfileCubit profileCubit;
  late MockSharedUserRepository sharedUserRepository;
  late MockAuthRepository authRepository;

  setUp(() {
    sharedUserRepository = MockSharedUserRepository();
    authRepository = MockAuthRepository();
    
    PackageInfo.setMockInitialValues(
      appName: 'EasyNAVI',
      packageName: 'com.example.easynavi',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  group('ProfileCubit', () {
    test('initial state has correct app version after load', () async {
      profileCubit = ProfileCubit(sharedUserRepository, authRepository);
      
      // Wait for _loadAppInfo (async) to complete and emit new state
      await Future.delayed(Duration.zero);
      
      expect(profileCubit.state.appVersion, '1.0.0+1');
    });

    blocTest<ProfileCubit, ProfileState>(
      'signOut emits loading and then success',
      build: () {
        when(() => authRepository.signOut()).thenAnswer((_) async {});
        return ProfileCubit(sharedUserRepository, authRepository);
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        isA<ProfileState>().having((s) => s.isSaving, 'isSaving', true),
        isA<ProfileState>().having((s) => s.appVersion, 'appVersion', '1.0.0+1'),
        isA<ProfileState>().having((s) => s.isSaving, 'isSaving', false),
      ],
    );
  });
}
