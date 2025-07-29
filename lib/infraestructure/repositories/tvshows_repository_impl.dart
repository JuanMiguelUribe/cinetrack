import 'package:movieflex/domain/datasources/tvshows_datasources.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/domain/respositories/tvshows_repository.dart';

class TvshowsDbRepositoryImpl extends TvShowsDBRepository {
  final TvShowsDBDatasource datasource;

  TvshowsDbRepositoryImpl(this.datasource);
  @override
  Future<List<TvShow>> getTvShowsAiring({int page = 1}) {
    return datasource.getTvShowsAiring(page: page);
  }

  @override
  Future<List<TvShow>> getTvShowsOnTheAir({int page = 1}) {
    return datasource.getTvShowsOnTheAir(page: page);
  }

  @override
  Future<List<TvShow>> getTvShowsPopular({int page = 1}) {
    return datasource.getTvShowsPopular(page: page);
  }

  @override
  Future<List<TvShow>> getTvShowsTopRated({int page = 1}) {
    return datasource.getTvShowsTopRated(page: page);
  }

  @override
  Future<TvShowDetails> getTvShowById(String id) {
    return datasource.getTvShowById(id);
  }

  @override
  Future<List<TvShow>> searchtvshow(String query) {
    return datasource.searchtvshow(query);
  }
}
