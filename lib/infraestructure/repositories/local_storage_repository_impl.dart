import 'package:movieflex/domain/datasources/local_storage_datasource.dart';
import 'package:movieflex/domain/entities/movie.dart';

import 'package:movieflex/domain/entities/tv_shows.dart';

import '../../domain/respositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<bool> isTvShowFavorite(int tvShowId) {
    return datasource.isTvShowFavorite(tvShowId);
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0}) {
    return datasource.loadFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<List<TvShow>> loadFavoriteTvShows({int limit = 10, offset = 0}) {
    return datasource.loadFavoriteTvShows(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) {
    return datasource.toggleFavoriteMovie(movie);
  }

  @override
  Future<void> toggleFavoriteTvShow(TvShow tvShow) {
    return datasource.toggleFavoriteTvShow(tvShow);
  }
}
