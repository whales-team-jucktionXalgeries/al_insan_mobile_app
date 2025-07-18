import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://rdcnbqevuwiwgdkdefco.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkY25icWV2dXdpd2dka2RlZmNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4MDAxMDIsImV4cCI6MjA2ODM3NjEwMn0.EuVPaoDx8jlCifij2fvKmkxYmWtpHF498WMtSLZY5DM',
    );
  }
}
