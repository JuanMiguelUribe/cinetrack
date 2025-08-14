class CreditsActorDbResponse {
  final List<CastCredit> cast;
  final List<CastCredit> crew;
  final int id;

  CreditsActorDbResponse({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory CreditsActorDbResponse.fromJson(Map<String, dynamic> json) =>
      CreditsActorDbResponse(
        cast: List<CastCredit>.from(
          json["cast"].map((x) => CastCredit.fromJson(x)),
        ),
        crew: List<CastCredit>.from(
          json["crew"].map((x) => CastCredit.fromJson(x)),
        ),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    "id": id,
  };
}

class CastCredit {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final OriginalLanguage originalLanguage;
  final String? originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final int voteCount;
  final String? character;
  final String creditId;
  final int? order;
  final MediaType mediaType;
  final List<OriginCountry>? originCountry;
  final String? originalName;
  final DateTime? firstAirDate;
  final String? name;
  final int? episodeCount;
  final DateTime? firstCreditAirDate;
  final String? department;
  final String? job;

  CastCredit({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.character,
    required this.creditId,
    this.order,
    required this.mediaType,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.name,
    this.episodeCount,
    this.firstCreditAirDate,
    this.department,
    this.job,
  });

  factory CastCredit.fromJson(Map<String, dynamic> json) => CastCredit(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] as String?,
    genreIds:
        (json["genre_ids"] as List<dynamic>?)?.map((x) => x as int).toList() ??
        [],
    id: json["id"] ?? 0,
    originalLanguage:
        originalLanguageValues.map[json["original_language"]] ??
        OriginalLanguage.en, // Valor por defecto si no existe
    originalTitle: json["original_title"] ?? '',
    overview: json["overview"] ?? '',
    popularity: json["popularity"] ?? 0,
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] ?? '',
    title: json["title"] ?? '',
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] is num)
        ? (json["vote_average"] as num).toDouble()
        : 0.0,
    voteCount: json["vote_count"] ?? 0,
    character: json["character"] ?? '',
    creditId: json["credit_id"] ?? '',
    order: json["order"] ?? 0,
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.movie,
    originCountry:
        (json["origin_country"] as List<dynamic>?)
            ?.map((x) => originCountryValues.map[x] ?? OriginCountry.us)
            .toList() ??
        [],
    originalName: json["original_name"] ?? '',
    firstAirDate: json["first_air_date"] != null && json["first_air_date"] != ''
        ? DateTime.tryParse(json["first_air_date"])
        : null,
    name: json["name"] ?? '',
    episodeCount: json["episode_count"] ?? 0,
    firstCreditAirDate:
        json["first_credit_air_date"] != null &&
            json["first_credit_air_date"] != ''
        ? DateTime.tryParse(json["first_credit_air_date"])
        : null,
    department: json["department"] ?? '',
    job: json["job"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "media_type": mediaTypeValues.reverse[mediaType],
    "origin_country": originCountry == null
        ? []
        : List<dynamic>.from(
            originCountry!.map((x) => originCountryValues.reverse[x]),
          ),
    "original_name": originalName,
    "first_air_date": firstAirDate != null
        ? "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}"
        : null,
    "name": name,
    "episode_count": episodeCount,
    "first_credit_air_date": firstCreditAirDate != null
        ? "${firstCreditAirDate!.year.toString().padLeft(4, '0')}-${firstCreditAirDate!.month.toString().padLeft(2, '0')}-${firstCreditAirDate!.day.toString().padLeft(2, '0')}"
        : null,
    "department": department,
    "job": job,
  };
}

enum MediaType { movie, tv }

final mediaTypeValues = EnumValues({
  "movie": MediaType.movie,
  "tv": MediaType.tv,
});

enum OriginCountry { us }

final originCountryValues = EnumValues({"US": OriginCountry.us});

enum OriginalLanguage { en }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.en});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
