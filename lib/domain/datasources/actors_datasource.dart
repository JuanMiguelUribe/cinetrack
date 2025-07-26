import 'package:cinetrack/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovie(String movieId);
  Future<List<Actor>> getActorsByShow(String tvshowId);
}
