class MovieDetails {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? tagline; // ⛔️ puede venir nulo o vacío
  final bool? adult;
  final String? backdropPath; // ⛔️ puede venir nulo
  final String? posterPath; // ⛔️ puede venir nulo
  final DateTime? releaseDate; // ⛔️ puede venir nulo
  final int? runtime; // ⛔️ puede venir nulo
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final String originalLanguage;
  final List<String> originCountry;
  final List<String> genres;
  final String? homepage; // ⛔️ puede venir nulo o vacío
  final int budget;
  final int revenue;
  final bool? video;
  final String status;
  final String? imdbId; // ⛔️ puede venir nulo o vacío

  // Relaciones
  final CollectionInfo? belongsToCollection; // ⛔️ puede venir nulo
  final List<String> productionCompanies;
  final List<String> productionCountries;
  final List<String> spokenLanguages;

  MovieDetails({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.tagline,
    this.adult,
    required this.backdropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.originalLanguage,
    required this.originCountry,
    required this.genres,
    required this.homepage,
    required this.budget,
    required this.revenue,
    required this.video,
    required this.status,
    required this.imdbId,
    required this.belongsToCollection,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    String? belongsToCollectionName,
    String? belongsToCollectionPoster,
  });
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});
}

class CollectionInfo {
  final int id;
  final String name;
  final String? posterPath; // ⛔️ puede venir nulo
  final String? backdropPath; // ⛔️ puede venir nulo

  CollectionInfo({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath; // ⛔️ puede venir nulo
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });
}

class ProductionCountry {
  final String isoCode;
  final String name;

  ProductionCountry({required this.isoCode, required this.name});
}

class SpokenLanguage {
  final String englishName;
  final String isoCode;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });
}
