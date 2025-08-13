import 'package:movieflex/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
  Future<List<Actor>> getActorsByShow(String tvshowId);
  Future<PersonDetailsEntity> getActorById(String id);
}
