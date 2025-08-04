import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';

abstract class TvShowsDBRepository {
  Future<List<TvShow>> getTvShowsAiring({int page = 1});
  Future<List<TvShow>> getTvShowsOnTheAir({int page = 1});
  Future<List<TvShow>> getTvShowsPopular({int page = 1});
  Future<List<TvShow>> getTvShowsTopRated({int page = 1});

  Future<TvShowDetails> getTvShowById(String id);
  Future<List<TvShow>> searchtvshow(String query);
  Future<List<TvShow>> getRecomendationsTvShowById(
    String tvshowId, {
    int page = 1,
  });
}
