import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  static const int _maxTempFileAgeHours = 24;

  Future<void> cleanOnStartup() async {
    await _cleanTempDirectory();
  }

  Future<int> getTotalCacheSize() async {
    int total = 0;
    final tempDir = await getTemporaryDirectory();
    if (await tempDir.exists()) {
      await for (final entity in tempDir.list(recursive: true)) {
        if (entity is File) {
          total += await entity.length();
        }
      }
    }
    return total;
  }

  Future<void> clearTempCache() async {
    await _cleanTempDirectory();
  }

  Future<void> clearAllCache() async {
    final tempDir = await getTemporaryDirectory();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
      await tempDir.create();
    }
  }

  Future<void> _cleanTempDirectory() async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (!await tempDir.exists()) return;

      final cutoff = DateTime.now().subtract(
        const Duration(hours: _maxTempFileAgeHours),
      );

      await for (final entity in tempDir.list()) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoff)) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      debugPrint('[CacheManager] Error cleaning temp dir: $e');
    }
  }
}
