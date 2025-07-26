import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

final actorsByTvShowProvider =
    StateNotifierProvider<ActorByTvShowNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorsRepository = ref.watch(actorsRepositoryProvider);
      return ActorByTvShowNotifier(getActors: actorsRepository.getActorsByShow);
    });

/*
{

  "505642": "<Actor>[]",
  "505642": "<Actor>[]",
  "505642": "<Actor>[]",
  "505642": "<Actor>[]",

 */

typedef GetActorsCallBack = Future<List<Actor>> Function(String tvshowid);

class ActorByTvShowNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;
  ActorByTvShowNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String tvshowID) async {
    if (state[tvshowID] != null) return;
    final List<Actor> actors = await getActors(tvshowID);
    state = {...state, tvshowID: actors};
  }
}
