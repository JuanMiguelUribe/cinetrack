// ENTITY
class Season {
  final String id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;
  final DateTime? airDate;
  final List<EpisodeEntity?> episodes;

  Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    required this.airDate,
    this.episodes = const [],
  });
}

class EpisodeEntity {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final int seasonNumber;
  final DateTime? airDate;
  final String? stillPath;
  final double voteAverage;

  EpisodeEntity({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.airDate,
    required this.stillPath,
    required this.voteAverage,
  });
}
