import 'dart:io';
import 'package:al_insan_app_front/services/session.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VideoSyncService {
  static final SupabaseClient supabase = Supabase.instance.client;

  static Future<void> syncAllSessionsIfOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) return;

    final sessions = await DonationSessionManager.getAllSessions();
    final String userId = await getCurrentUserId(); // You must define this

    for (final session in sessions) {
      final File video = File(session.videoPath);
      final File json = File(session.jsonPath);
      final String sessionId = session.sessionId;

      try {
        // Upload video
        final videoStoragePath = 'sessions/$userId/$sessionId.mp4';
        await supabase.storage
            .from('your_bucket')
            .upload(videoStoragePath, video);

        // Upload JSON
        final jsonStoragePath = 'sessions/$userId/$sessionId.json';
        await supabase.storage
            .from('your_bucket')
            .upload(jsonStoragePath, json);

        final String videoUrl = supabase.storage
            .from('your_bucket')
            .getPublicUrl(videoStoragePath);

        final String jsonUrl = supabase.storage
            .from('your_bucket')
            .getPublicUrl(jsonStoragePath);

        // Insert session record into database
        await supabase.from('donation_sessions').insert({
          'user_id': userId,
          'video_url': videoUrl,
          'json_url': jsonUrl,
          'created_at': DateTime.now().toIso8601String(),
        });

        // Optionally delete local files after successful upload
        await DonationSessionManager.deleteSession(sessionId);
      } catch (e) {
        print('Upload failed for session $sessionId: $e');
      }
    }
  }

  static Future<String> getCurrentUserId() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user.id;
  }
}
