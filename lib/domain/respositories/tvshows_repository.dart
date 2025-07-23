import 'package:cinetrack/domain/entities/tv_shows.dart';

abstract class TvShowsDBRepository {
  Future<List<TvShow>> getTvShowsAiring({int page = 1});
  Future<List<TvShow>> getTvShowsOnTheAir({int page = 1});
  Future<List<TvShow>> getTvShowsPopular({int page = 1});
  Future<List<TvShow>> getTvShowsTopRated({int page = 1});
}
