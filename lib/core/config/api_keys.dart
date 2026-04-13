/// API keys injected via --dart-define-from-file=config/api-keys.json.
///
/// Copy config/api-keys.template.json → config/api-keys.json and fill in values.
/// VS Code launch.json already passes --dart-define-from-file.
/// For CLI: flutter run --dart-define-from-file=config/api-keys.json
class ApiKeys {
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://laapoqdayvmszqcijyob.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_HMcf9Q70d3YJI8_jnloO_Q_Mc0UaRFO',
  );
}
