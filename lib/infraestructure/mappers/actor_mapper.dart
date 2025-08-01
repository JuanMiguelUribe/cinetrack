import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/infraestructure/models/movieDb/ActorsTv_response.dart';
import 'package:movieflex/infraestructure/models/movieDb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
        ? "https://image.tmdb.org/t/p/w500${cast.profilePath}"
        : "https://assets.mycast.io/actor_images/actor-a-unknown-voice-actor-745520_small.jpg?1682266765",
    character: cast.character,
    job: cast.job,
    department: cast.department,
    knownForDepartment: cast.knownForDepartment,
  );

  static Actor actorsTvtoEntity(CastTv cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? "https://image.tmdb.org/t/p/w500${cast.profilePath}"
          : "https://assets.mycast.io/actor_images/actor-a-unknown-voice-actor-745520_small.jpg?1682266765",
      character: cast.character,
      job: cast.job,
      department: cast.department,
      knownForDepartment: cast.knownForDepartment,
    );
  }
}
