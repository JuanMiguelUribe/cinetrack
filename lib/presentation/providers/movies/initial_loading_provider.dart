import 'package:cinetrack/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  // Si alguno de los pasos está vacío, significa que aún no se ha cargado
  if (step1 || step2 || step3 || step4) {
    return true; // Aún estamos cargando
  }
  return false; // Terminamos de cargar
});
