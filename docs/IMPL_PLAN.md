# EasyNAVI Implementation Plan (MVP Audit & Completion)

## Status Update
The application has already implemented the core functional requirements of the MVP. However, the technical debt regarding tests and documentation needs to be addressed immediately.

### Done (Functional)
- [x] **Auth**: Integration with Supabase (Anonymous & Guest-to-Registered migration).
- [x] **Home**: Visual structure with quick access and stats.
- [x] **Addresses**: Full CRUD, Search, Map background, and Compact UI.
- [x] **Navigation (Drive)**: Real-time GPS tracking, Jitter filtering, Speedometer, Speed limits (OSM), and Radar alerts.
- [x] **Voice**: Professional Text-to-Speech integration with customizable settings (rate, pitch).
- [x] **Appearance**: Dark mode, Brightness control, and Vehicle Garage (custom markers).

### To-Do (Infrastructure & Quality) - CRITICAL
- [ ] **Documentation**: Create `docs/IMPL_PLAN.md` (This file).
- [ ] **Unit Tests**: Create `test/` directory and implement tests for ALL Cubits.
    - `AuthCubit`
    - `SessionCubit`
    - `AppAppearanceCubit`
    - `AppVoiceCubit`
    - `AddressesCubit`
    - `DriveCubit`
- [ ] **Integration Tests**: Remove `integration_test/counter_test_example.dart` and add real E2E tests for Address creation and Navigation launch.
- [ ] **L10n**: Ensure all strings are in ARB files (PL/EN).

## Implementation Roadmap

### Phase 1: Test Infrastructure (Immediate)
1. Delete `integration_test/counter_test_example.dart`.
2. Create `test/` directory structure matching `lib/`.
3. Set up `mocktail` and `bloc_test` dependencies.
4. Implement unit tests for `AppAppearanceCubit` as a baseline.

### Phase 2: Core Logic Testing
1. Implement comprehensive tests for `DriveCubit` (GPS filtering logic, speed calculations).
2. Implement tests for `AddressesCubit` (CRUD operations, filtering).
3. Implement tests for `Auth` & `Session` management.

### Phase 3: Integration & Polish
1. Create `integration_test/app_test.dart` covering:
    - Welcome flow (Guest login).
    - Adding an address.
    - Starting a navigation session.
2. Final audit of ARB files for localization completeness.

## Supabase Schema
All tables use `easynavi_` prefix and RLS is enabled:
- `easynavi_addresses`: `id`, `user_id`, `name`, `street`, `house_number`, `city`, `zip_code`, `latitude`, `longitude`.
- `shared_users`: (Shared table) `id`, `first_name`.

## Finish Criteria
Application is ready for production only when `flutter test` and `flutter test integration_test` pass with 100% success and no lint warnings.
