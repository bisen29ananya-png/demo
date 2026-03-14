import 'package:dio/dio.dart';

import 'package:demo/features/movies/data/models/show_model.dart';

class MoviesRemoteDataSource {
  MoviesRemoteDataSource({required this.dio});

  final Dio dio;

  Future<List<ShowModel>> getShowsPage({required int page}) async {
    final response = await dio.get<dynamic>(
      '/shows',
      queryParameters: {'page': page},
    );

    final data = response.data;
    if (data is! List) {
      throw StateError('Unexpected response type: ${data.runtimeType}');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ShowModel.fromJson)
        .toList(growable: false);
  }

  Future<ShowModel> getShowById(int id) async {
    final response = await dio.get<dynamic>('/shows/$id');
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw StateError('Unexpected response type: ${data.runtimeType}');
    }
    return ShowModel.fromJson(data);
  }
}
