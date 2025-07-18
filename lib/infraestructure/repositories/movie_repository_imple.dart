import 'package:cinetrack/domain/datasources/movies_datasource.dart';
import 'package:cinetrack/domain/entities/movie.dart';
import 'package:cinetrack/domain/respositories/movies_repository.dart';

class MovieRepositoryImple extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImple(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return this.datasource.getNowPlaying(page: page);
  }
}
