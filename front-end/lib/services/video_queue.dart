import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class VideoQueue {
  static Future<File> _getQueueFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/video_queue.json');
  }

  static Future<void> addToQueue(String filePath, String userId) async {
    final file = await _getQueueFile();
    List<Map<String, String>> queue = [];

    if (await file.exists()) {
      final content = await file.readAsString();
      queue = List<Map<String, String>>.from(json.decode(content));
    }

    queue.add({'filePath': filePath, 'userId': userId});
    await file.writeAsString(json.encode(queue));
  }

  static Future<List<Map<String, String>>> readQueue() async {
    final file = await _getQueueFile();
    if (!await file.exists()) return [];

    final content = await file.readAsString();
    return List<Map<String, String>>.from(json.decode(content));
  }

  static Future<void> clearQueue() async {
    final file = await _getQueueFile();
    if (await file.exists()) {
      await file.writeAsString('[]');
    }
  }
}
