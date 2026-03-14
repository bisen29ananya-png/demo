import 'package:demo/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:demo/features/movies/domain/entities/show.dart';
import 'package:demo/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl({required this.remote});

  final MoviesRemoteDataSource remote;

  @override
  Future<List<Show>> getShowsPage({required int page}) async {
    final models = await remote.getShowsPage(page: page);
    return models.map((m) => m.toEntity()).toList(growable: false);
  }

  @override
  Future<Show> getShowById(int id) async {
    final model = await remote.getShowById(id);
    return model.toEntity();
  }
}
