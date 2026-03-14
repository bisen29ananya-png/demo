import 'package:demo/features/movies/domain/entities/show.dart';
import 'package:demo/features/movies/domain/repositories/movies_repository.dart';

class GetShowDetailsUseCase {
  GetShowDetailsUseCase({required this.repository});

  final MoviesRepository repository;

  Future<Show> call(int id) => repository.getShowById(id);
}
