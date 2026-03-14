import 'package:demo/features/movies/domain/entities/show.dart';

class ShowModel {
  const ShowModel({
    required this.id,
    required this.name,
    required this.genres,
    required this.rating,
    required this.premiered,
    required this.summary,
    required this.imageMedium,
    required this.imageOriginal,
  });

  final int id;
  final String name;
  final List<String> genres;
  final double? rating;
  final DateTime? premiered;
  final String? summary;
  final String? imageMedium;
  final String? imageOriginal;

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'];
    final imageJson = json['image'];

    final premieredStr = json['premiered'] as String?;

    return ShowModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String?) ?? '',
      genres:
          (json['genres'] as List?)?.whereType<String>().toList() ?? const [],
      rating: (ratingJson is Map<String, dynamic>)
          ? (ratingJson['average'] as num?)?.toDouble()
          : null,
      premiered: premieredStr == null || premieredStr.isEmpty
          ? null
          : DateTime.tryParse(premieredStr),
      summary: json['summary'] as String?,
      imageMedium: (imageJson is Map<String, dynamic>)
          ? imageJson['medium'] as String?
          : null,
      imageOriginal: (imageJson is Map<String, dynamic>)
          ? imageJson['original'] as String?
          : null,
    );
  }

  Show toEntity() {
    return Show(
      id: id,
      name: name,
      genres: genres,
      rating: rating,
      premiered: premiered,
      summary: summary,
      imageMedium: imageMedium,
      imageOriginal: imageOriginal,
    );
  }
}
