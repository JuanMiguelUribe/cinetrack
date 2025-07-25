class TvShow {
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final String backdropPath;
  final double voteAverage;
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final double popularity;
  final int voteCount;
  final String? originalLanguage;
  final String? originalName;

  TvShow({
    required this.id,
    required this.name,
    this.overview,
    this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    this.firstAirDate,
    required this.genreIds,
    required this.popularity,
    required this.voteCount,
    this.originalLanguage,
    this.originalName,
  });
}
