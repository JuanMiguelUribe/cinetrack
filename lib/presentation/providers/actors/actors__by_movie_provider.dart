import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorsRepository = ref.watch(actorsRepositoryProvider);
      return ActorByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
    });

/*
{

  "505642": "<Actor>[]",
  "505642": "<Actor>[]",
  "505642": "<Actor>[]",
  "505642": "<Actor>[]",

 */

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;
  ActorByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieID) async {
    if (state[movieID] != null) return;
    final List<Actor> actors = await getActors(movieID);
    state = {...state, movieID: actors};
  }
}
