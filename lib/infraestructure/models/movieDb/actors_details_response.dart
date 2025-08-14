// To parse this JSON data, do
//
//     final actorDbResponse = actorDbResponseFromJson(jsonString);

class ActorDbResponse {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final DateTime? birthday;
  final DateTime? deathday;
  final int gender;
  final dynamic homepage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String? profilePath;

  ActorDbResponse({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    this.profilePath,
  });

  factory ActorDbResponse.fromJson(Map<String, dynamic> json) =>
      ActorDbResponse(
        adult: json["adult"] ?? false,
        alsoKnownAs: (json["also_known_as"] != null)
            ? List<String>.from(json["also_known_as"].map((x) => x.toString()))
            : [],
        biography: json["biography"] ?? '',
        birthday:
            (json["birthday"] != null && json["birthday"].toString().isNotEmpty)
            ? DateTime.parse(json["birthday"].toString())
            : DateTime(1900, 1, 1),
        deathday:
            (json["deathday"] != null && json["deathday"].toString().isNotEmpty)
            ? DateTime.parse(json["deathday"].toString())
            : null,
        gender: json["gender"] ?? 0,
        homepage: json["homepage"] ?? '',
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"] ?? '',
        knownForDepartment: json["known_for_department"] ?? '',
        name: json["name"] ?? '',
        placeOfBirth: json["place_of_birth"] ?? '',
        popularity: (json["popularity"] is num)
            ? (json["popularity"] as num).toDouble()
            : 0.0,
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
    "biography": biography,
    "birthday":
        "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "deathday": deathday,
    "gender": gender,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "known_for_department": knownForDepartment,
    "name": name,
    "place_of_birth": placeOfBirth,
    "popularity": popularity,
    "profile_path": profilePath,
  };
}
