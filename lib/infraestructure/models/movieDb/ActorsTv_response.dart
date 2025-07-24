class ActorsTvResponse {
  final List<CastTv> cast;
  final List<CastTv> crew;
  final int id;

  ActorsTvResponse({required this.cast, required this.crew, required this.id});

  factory ActorsTvResponse.fromJson(Map<String, dynamic> json) =>
      ActorsTvResponse(
        cast: List<CastTv>.from(json["cast"].map((x) => CastTv.fromJson(x))),
        crew: List<CastTv>.from(json["crew"].map((x) => CastTv.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    "id": id,
  };
}

class CastTv {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  CastTv({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory CastTv.fromJson(Map<String, dynamic> json) => CastTv(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"],
    job: json["job"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": department,
    "job": job,
  };
}
