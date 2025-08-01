class MovieDetailsResponse {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<String> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<String> productionCompanies;
  final List<String> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int? runtime;
  final List<String> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool? video;
  final double voteAverage;
  final int voteCount;

  MovieDetailsResponse({
    this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponse(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] != null
            ? BelongsToCollection.fromJson(json["belongs_to_collection"])
            : null,
        budget: json["budget"] ?? 0,
        genres: List<String>.from((json["genres"] ?? []).map((x) => x["name"])),

        homepage: json["homepage"] ?? "",
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"],
        originCountry: List<String>.from(
          (json["origin_country"] ?? []).map((x) => x),
        ),
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"],
        popularity: (json["popularity"] ?? 0).toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<String>.from(
          (json["production_companies"] ?? []).map((x) => x["name"]),
        ),
        productionCountries: List<String>.from(
          (json["production_countries"] ?? []).map((x) => x["name"]),
        ),
        releaseDate:
            DateTime.tryParse(json["release_date"] ?? '') ?? DateTime(1900),
        revenue: json["revenue"] ?? 0,
        runtime: json["runtime"],
        spokenLanguages: List<String>.from(
          (json["spoken_languages"] ?? []).map((x) => x["name"]),
        ),
        status: json["status"] ?? '',
        tagline: json["tagline"] ?? "No tagline Founded",
        title: json["title"] ?? '',
        video: json["video"] ?? false,
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection?.toJson(),
    "budget": budget,
    "genres": genres,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": productionCompanies,
    "production_countries": productionCountries,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime ?? 125,
    "spoken_languages": spokenLanguages,
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class BelongsToCollection {
  final int id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(
        id: json["id"] ?? 0,
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "backdrop_path": backdropPath,
  };
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String? originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] ?? 0,
        logoPath: json["logo_path"],
        name: json["name"] ?? '',
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"] ?? 0, name: json["name"] ?? '');

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCountry {
  final String iso3166_1;
  final String name;

  ProductionCountry({required this.iso3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso3166_1: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {"iso_3166_1": iso3166_1, "name": name};
}

class SpokenLanguage {
  final String englishName;
  final String iso639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"] ?? '',
    iso639_1: json["iso_639_1"] ?? '',
    name: json["name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso639_1,
    "name": name,
  };
}
