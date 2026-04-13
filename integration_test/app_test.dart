import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easynavi/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on continue as guest and navigate to home',
        (tester) async {
      // Start the app
      app.main();
      
      // Wait for the app to initialize
      await tester.pumpAndSettle();

      // If already logged in (e.g. from previous run), sign out to test the flow
      try {
        final supabase = Supabase.instance.client;
        if (supabase.auth.currentSession != null) {
          await supabase.auth.signOut();
          await tester.pumpAndSettle();
        }
      } catch (_) {
        // Supabase might not be initialized yet or keys missing, ignore
      }

      // Verify we are on the Welcome Screen (Polish locale usually loads by default in this environment)
      // If it fails, check if 'Witaj' is visible.
      // We use find.text since we saw it in ARB.
      expect(find.text('Witaj'), findsOneWidget);
      
      // Tap on 'Kontynuuj jako gość'
      final guestButton = find.text('Kontynuuj jako gość');
      expect(guestButton, findsOneWidget);
      
      await tester.tap(guestButton);
      
      // Trigger a frame after tap and wait for navigation animation
      await tester.pumpAndSettle();

      // Verify we are on the Home Screen
      // HomeScreen has 'JEDZIEMY' button/label hardcoded in uppercase.
      expect(find.text('JEDZIEMY'), findsOneWidget);
      expect(find.text('ADRESY'), findsOneWidget);
      expect(find.text('USTAWIENIA'), findsOneWidget);
    });
  });
}
