import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'video_queue.dart';

class VideoSyncService {
  static Future<void> syncQueuedVideos() async {
    final queue = await VideoQueue.readQueue();
    final client = Supabase.instance.client;

    for (final video in queue) {
      final file = File(video['filePath']!);
      final userId = video['userId']!;
      final fileName = file.uri.pathSegments.last;

      try {
        await client.storage.from('videos').upload(
          '$userId/$fileName',
          file,
          fileOptions: FileOptions(upsert: true),
        );
      } catch (e) {
        print('Upload failed for $fileName: $e');
        return; // Stop syncing if an error occurs
      }
    }

    await VideoQueue.clearQueue();
  }
}
