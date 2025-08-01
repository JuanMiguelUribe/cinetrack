import 'package:isar/isar.dart';
import 'package:movieflex/domain/datasources/local_storage_datasource.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema, TvShowSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movieId)
        .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<bool> isTvShowFavorite(int tvShowId) async {
    final isar = await db;
    final TvShow? isFavoriteTvShow = await isar.tvShows
        .filter()
        .idEqualTo(tvShowId)
        .findFirst();

    return isFavoriteTvShow != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<List<TvShow>> loadFavoriteTvShows({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.tvShows.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst();

    if (favoriteMovie != null) {
      //Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }
    //Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<void> toggleFavoriteTvShow(TvShow tvShow) async {
    final isar = await db;

    final favoriteTvShow = await isar.tvShows
        .filter()
        .idEqualTo(tvShow.id)
        .findFirst();

    if (favoriteTvShow != null) {
      //Borrar
      isar.writeTxnSync(() => isar.tvShows.deleteSync(favoriteTvShow.isarId!));
      return;
    }
    //Insertar
    return isar.writeTxnSync(() => isar.tvShows.putSync(tvShow));
  }
}
