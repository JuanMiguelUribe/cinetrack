import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/infraestructure/models/movieDb/actors_details_response.dart';
import 'package:movieflex/infraestructure/models/movieDb/actorstv_response.dart';
import 'package:movieflex/infraestructure/models/movieDb/credits_actor_response.dart';
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

  static PersonDetailsEntity actorDetailToEntity(
    ActorDbResponse actor,
  ) => PersonDetailsEntity(
    id: actor.id,
    name: actor.name,
    alsoKnownAs: actor.alsoKnownAs,
    biography: actor.biography,
    birthday: actor.birthday,
    deathday: actor.deathday,
    gender: actor.gender,
    homepage: actor.homepage,
    imdbId: actor.imdbId,
    knownForDepartment: actor.knownForDepartment,
    placeOfBirth: actor.placeOfBirth,
    popularity: actor.popularity,
    profilePath: actor.profilePath != null
        ? "https://image.tmdb.org/t/p/w500${actor.profilePath}"
        : "https://assets.mycast.io/actor_images/actor-a-unknown-voice-actor-745520_small.jpg?1682266765",
  );

  static ActorCredit actorCreditToEntity(CastCredit credit) => ActorCredit(
    id: credit.id,
    mediaType: credit.mediaType,
    title: credit.title!,
    voteAverage: credit.voteAverage,
    popularity: credit.popularity,
    posterUrl: (credit.posterPath != null && credit.posterPath!.isNotEmpty)
        ? "https://image.tmdb.org/t/p/w500${credit.posterPath}"
        : "https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",
  );
}
