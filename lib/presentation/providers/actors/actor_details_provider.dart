import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/presentation/providers/providers.dart';

final actorDetailsProvider = FutureProvider.family<PersonDetailsEntity, String>(
  (ref, actorId) async {
    final repository = ref.watch(actorsRepositoryProvider);
    return await repository.getActorById(actorId);
  },
);
