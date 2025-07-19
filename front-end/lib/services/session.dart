import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DonationSessionManager {
  static Future<Directory> _getBaseDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final donationDir = Directory('${dir.path}/donation_sessions');
    if (!await donationDir.exists()) {
      await donationDir.create(recursive: true);
    }
    return donationDir;
  }

  static Future<Directory> createSession(String sessionId) async {
    final baseDir = await _getBaseDirectory();
    final sessionDir = Directory('${baseDir.path}/$sessionId');
    if (!await sessionDir.exists()) {
      await sessionDir.create();
    }
    return sessionDir;
  }

  static Future<void> saveSession(String sessionId, File videoFile, File jsonFile) async {
    final sessionDir = await createSession(sessionId);

    final videoDest = File(path.join(sessionDir.path, path.basename(videoFile.path)));
    final jsonDest = File(path.join(sessionDir.path, path.basename(jsonFile.path)));

    await videoFile.copy(videoDest.path);
    await jsonFile.copy(jsonDest.path);

    print("Saved session to ${sessionDir.path}");
  }

static Future<List<DonationSession>> getAllSessions() async {
  final rootDir = await getApplicationDocumentsDirectory();
  final sessionsDir = Directory('${rootDir.path}/sessions');

  if (!await sessionsDir.exists()) return [];

  final List<DonationSession> sessions = [];

  for (final entity in sessionsDir.listSync()) {
    if (entity is Directory) {
      final sessionId = path.basename(entity.path);
      String? videoPath;
      String? jsonPath;

      for (final file in entity.listSync()) {
        if (file is File) {
          if (file.path.endsWith('.mp4')) {
            videoPath = file.path;
          } else if (file.path.endsWith('.json')) {
            jsonPath = file.path;
          }
        }
      }

      if (videoPath != null && jsonPath != null) {
        sessions.add(DonationSession(
          sessionId: sessionId,
          videoPath: videoPath,
          jsonPath: jsonPath,
        ));
      }
    }
  }

  return sessions;
}


  /// Returns the directory where a session is stored, given its sessionId
static Future<Directory> _getSessionDirectory(String sessionId) async {
  final rootDir = await getApplicationDocumentsDirectory();
  final sessionsDir = Directory('${rootDir.path}/sessions/$sessionId');
  return sessionsDir;
}


  /// Delete a specific session directory by its ID.
  static Future<void> deleteSession(String sessionId) async {
    final sessionDir = await _getSessionDirectory(sessionId);
    if (await sessionDir.exists()) {
      await sessionDir.delete(recursive: true);
    }
  }
}

class DonationSession {
  String sessionId;
  String videoPath;
  String jsonPath;

  DonationSession({
    required this.sessionId,
    required this.videoPath,
    required this.jsonPath,
  });

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'videoPath': videoPath,
        'jsonPath': jsonPath,
      };

  static DonationSession fromJson(Map<String, dynamic> json) {
    return DonationSession(
      sessionId: json['sessionId'],
      videoPath: json['videoPath'],
      jsonPath: json['jsonPath'],
    );
  }
}
