import 'package:demo/features/movies/domain/entities/show.dart';

abstract class MoviesRepository {
  Future<List<Show>> getShowsPage({required int page});

  Future<Show> getShowById(int id);
}
