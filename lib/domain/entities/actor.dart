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
