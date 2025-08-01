import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavoriteMovie(Movie movie);
  Future<void> toggleFavoriteTvShow(TvShow tvShow);

  Future<bool> isMovieFavorite(int movieId);
  Future<bool> isTvShowFavorite(int tvShowId);

  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0});
  Future<List<TvShow>> loadFavoriteTvShows({int limit = 10, offset = 0});
}
