import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myapp/app/session/data/repositories/session_repository.dart';
import 'package:myapp/app/session/models/session_status_model.dart';
import 'package:myapp/app/session/models/user_session_model.dart';
import 'package:myapp/app/session/presentation/cubit/session_cubit.dart';
import 'package:rxdart/rxdart.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  late MockSessionRepository mockRepository;
  late BehaviorSubject<SessionStatusModel> sessionController;

  setUp(() {
    mockRepository = MockSessionRepository();
    sessionController = BehaviorSubject<SessionStatusModel>.seeded(const SessionStatusModel.loading());
    when(() => mockRepository.sessionStream).thenAnswer((_) => sessionController.stream);
  });

  tearDown(() {
    sessionController.close();
  });

  group('SessionCubit', () {
    test('initial state is correct', () {
      final cubit = SessionCubit(mockRepository);
      expect(cubit.state, const SessionState.initial());
      cubit.close();
    });

    blocTest<SessionCubit, SessionState>(
      'emits unauthenticated when stream pushes unauthenticated status',
      build: () => SessionCubit(mockRepository),
      skip: 1,
      act: (_) => sessionController.add(const SessionStatusModel.unauthenticated()),
      expect: () => [
        const SessionState.unauthenticated(),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'emits authenticated when stream pushes authenticated status',
      build: () => SessionCubit(mockRepository),
      skip: 1,
      act: (_) => sessionController.add(const SessionStatusModel.authenticated(
        session: UserSessionModel(
          userId: 'user-123',
          email: 'test@example.com',
          isAnonymous: false,
          isPro: true,
          sharedUser: null,
        ),
      )),
      expect: () => [
        const SessionState.authenticated(
          session: UserSessionModel(
            userId: 'user-123',
            email: 'test@example.com',
            isAnonymous: false,
            isPro: true,
            sharedUser: null,
          ),
        ),
      ],
    );

    blocTest<SessionCubit, SessionState>(
      'refresh calls repository refresh',
      build: () => SessionCubit(mockRepository),
      act: (cubit) async {
        when(() => mockRepository.refresh()).thenAnswer((_) async {});
        await cubit.refresh();
      },
      verify: (_) {
        verify(() => mockRepository.refresh()).called(1);
      },
    );
  });
}
