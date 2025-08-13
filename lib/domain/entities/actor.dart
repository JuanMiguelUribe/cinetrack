class MovieCreditsEntity {
  final int id;
  final List<Actor> cast;
  final List<Actor> crew;

  MovieCreditsEntity({
    required this.id,
    required this.cast,
    required this.crew,
  });
}

class Actor {
  final int id;
  final String name;
  final String? profilePath;
  final String? character;
  final String? job;
  final String? department;
  final String? knownForDepartment;

  Actor({
    required this.id,
    required this.name,
    this.profilePath,
    this.character,
    this.job,
    this.department,
    this.knownForDepartment,
  });
}

class PersonDetailsEntity {
  final int id;
  final String name;
  final String? profilePath;
  final String? biography;
  final DateTime? birthday;
  final String? deathday;
  final int? gender; // 1 = mujer, 2 = hombre, 0/3 = otro
  final String? homepage;
  final String? imdbId;
  final String? knownForDepartment;
  final String? placeOfBirth;
  final double? popularity;
  final List<String> alsoKnownAs;

  PersonDetailsEntity({
    required this.id,
    required this.name,
    this.profilePath,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.imdbId,
    this.knownForDepartment,
    this.placeOfBirth,
    this.popularity,
    this.alsoKnownAs = const [],
  });
}
