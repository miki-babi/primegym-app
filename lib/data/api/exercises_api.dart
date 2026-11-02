import 'package:dio/dio.dart';

import '../../config/api_config.dart';
import 'exercise_api_models.dart';

class ExercisesApi {
  ExercisesApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConfig.baseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 60),
                headers: {
                  'Accept': 'application/json',
                  if (ApiConfig.hostHeader.isNotEmpty)
                    'Host': ApiConfig.hostHeader,
                },
              ),
            );

  final Dio _dio;

  Future<List<ExerciseDto>> fetchExercises({String? since}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/exercises',
      queryParameters: {
        if (since != null && since.isNotEmpty) 'since': since,
      },
    );
    return (response.data?['data'] as List<dynamic>? ?? [])
        .map((e) => ExerciseDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ExerciseDto> fetchExercise(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/exercises/$id',
    );
    return ExerciseDto.fromJson(
        response.data?['data'] as Map<String, dynamic>);
  }

  Future<List<TaxonomyItemDto>> fetchBodyParts() =>
      _fetchTaxonomy('/api/v1/body-parts');

  Future<List<TaxonomyItemDto>> fetchMuscles() =>
      _fetchTaxonomy('/api/v1/muscles');

  Future<List<TaxonomyItemDto>> fetchEquipments() =>
      _fetchTaxonomy('/api/v1/equipments');

  Future<List<TaxonomyItemDto>> _fetchTaxonomy(String path) async {
    final response = await _dio.get<Map<String, dynamic>>(path);
    return (response.data?['data'] as List<dynamic>? ?? [])
        .map((e) => TaxonomyItemDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
