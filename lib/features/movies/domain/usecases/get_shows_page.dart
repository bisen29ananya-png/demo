import 'package:demo/features/movies/domain/entities/show.dart';
import 'package:demo/features/movies/domain/repositories/movies_repository.dart';

class GetShowsPageUseCase {
  GetShowsPageUseCase({required this.repository});

  final MoviesRepository repository;

  Future<List<Show>> call({required int page}) {
    return repository.getShowsPage(page: page);
  }
}
