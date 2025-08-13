// To parse this JSON data, do
//
//     final seasonsDbResponde = seasonsDbRespondeFromJson(jsonString);

class SeasonsDbResponde {
  final String id;
  final DateTime airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int seasonsDbRespondeId;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonsDbResponde({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonsDbRespondeId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonsDbResponde.fromJson(Map<String, dynamic> json) =>
      SeasonsDbResponde(
        id: json["_id"] ?? "",
        airDate: json["air_date"] != null
            ? DateTime.tryParse(json["air_date"]) ?? DateTime(1900)
            : DateTime(1900),
        episodes: json["episodes"] != null
            ? List<Episode>.from(
                json["episodes"].map((x) => Episode.fromJson(x)),
              )
            : [],
        name: json["name"] ?? '',
        overview: json["overview"] ?? "No overview found",
        seasonsDbRespondeId: json["id"] ?? 0,
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "air_date":
        "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    "name": name,
    "overview": overview,
    "id": seasonsDbRespondeId,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "vote_average": voteAverage,
  };
}

class Episode {
  final DateTime airDate;
  final int episodeNumber;
  final String episodeType;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String stillPath;
  final double voteAverage;
  final int voteCount;
  final List<Crew> crew;
  final List<Crew> guestStars;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    airDate: json["air_date"] != null
        ? DateTime.tryParse(json["air_date"]) ?? DateTime(1900)
        : DateTime(1900),
    episodeNumber: json["episode_number"] ?? 0,
    episodeType: json["episode_type"] ?? '',
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    overview: json["overview"] ?? '',
    productionCode: json["production_code"] ?? '',
    runtime: json["runtime"] ?? 0,
    seasonNumber: json["season_number"] ?? 0,
    showId: json["show_id"] ?? 0,
    stillPath: json["still_path"] ?? '',
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
    crew: json["crew"] != null
        ? List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x)))
        : [],
    guestStars: json["guest_stars"] != null
        ? List<Crew>.from(json["guest_stars"].map((x) => Crew.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "air_date":
        "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "episode_type": episodeType,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
  };
}

class Crew {
  final String? job;
  final Department? department;
  final String creditId;
  final bool adult;
  final int gender;
  final int id;
  final Department knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final int? order;

  Crew({
    this.job,
    this.department,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.character,
    this.order,
  });
  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    job: json["job"],
    department: json["department"] != null
        ? departmentValues.map[json["department"]]
        : null,
    creditId: json["credit_id"] ?? '',
    adult: json["adult"] ?? false,
    gender: json["gender"] ?? 0,
    id: json["id"] ?? 0,
    knownForDepartment:
        departmentValues.map[json["known_for_department"]] ??
        Department.CREW, // valor por defecto
    name: json["name"] ?? '',
    originalName: json["original_name"] ?? '',
    popularity: (json["popularity"] ?? 0).toDouble(),
    profilePath: json["profile_path"],
    character: json["character"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "job": job,
    "department": departmentValues.reverse[department],
    "credit_id": creditId,
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": departmentValues.reverse[knownForDepartment],
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "character": character,
    "order": order,
  };
}

enum Department {
  ACTING,
  ART,
  CREATOR,
  CREW,
  DIRECTING,
  EDITING,
  PRODUCTION,
  VISUAL_EFFECTS,
  WRITING,
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Creator": Department.CREATOR,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Production": Department.PRODUCTION,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
