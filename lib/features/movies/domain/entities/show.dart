import 'package:equatable/equatable.dart';

class Show extends Equatable {
  const Show({
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

  @override
  List<Object?> get props => [
    id,
    name,
    genres,
    rating,
    premiered,
    summary,
    imageMedium,
    imageOriginal,
  ];
}
