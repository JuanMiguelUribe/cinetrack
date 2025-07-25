class TvShowDetails {
  final int id;
  final String name;
  final bool adult;
  final String? originalName;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime firstAirDate;
  final DateTime? lastAirDate;
  final double? popularity;
  final bool? inProduction;
  final String originalLanguage;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final String? homepage;
  final String? tagline;
  final String status;
  final String type;

  TvShowDetails({
    this.popularity,
    required this.adult,
    this.originalName,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.firstAirDate,
    this.lastAirDate,
    this.inProduction,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.homepage,
    this.tagline,
    required this.status,
    required this.type,
  });
}
