import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConst {
  static const String envFile = 'lib/core/const/.env';
  static String supabaseUrl = dotenv.env['supabase_url'] ?? 'Not Found';
  static String supabaseKey = dotenv.env['supabase_key'] ?? 'Not Found';
  static String googleClientId = dotenv.env['google_client_id'] ?? 'Not Found';
  static String googleClientSecret =
      dotenv.env['google_client_secret'] ?? 'Not Found';
  static String redirectedUrl = dotenv.env['redirected_url'] ?? 'Not Found';
}
