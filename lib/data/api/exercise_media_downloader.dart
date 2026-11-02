import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../config/api_config.dart';

class ExerciseMediaDownloader {
  ExerciseMediaDownloader({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                headers: {
                  if (ApiConfig.hostHeader.isNotEmpty)
                    'Host': ApiConfig.hostHeader,
                },
              ),
            );

  final Dio _dio;

  Future<String?> download({
    required String exerciseId,
    required String url,
    required String fileName,
  }) async {
    if (url.isEmpty) return null;

    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'exercises', exerciseId));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final target = File(p.join(dir.path, fileName));
    final resolvedUrl = ApiConfig.rewriteLocalUrl(url);
    await _dio.download(resolvedUrl, target.path);
    return target.path;
  }

  Future<void> deleteExerciseDir(String exerciseId) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'exercises', exerciseId));
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}
