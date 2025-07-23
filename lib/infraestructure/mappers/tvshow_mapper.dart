import '../../domain/entities/tv_shows.dart';
import '../models/movieDb/tvshowdb_response.dart';

class TvshowMapper {
  static TvShow tvshowDBtoEntity(TvShowTvShowsDB tvshowdb) {
    return TvShow(
      id: tvshowdb.id,
      backdropPath: (tvshowdb.backdropPath != "")
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.backdropPath}"
          : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
      firstAirDate: tvshowdb.firstAirDate,
      genreIds: tvshowdb.genreIds,
      name: tvshowdb.name,

      originalName: tvshowdb.originalName,
      overview: tvshowdb.overview ?? "No overview available",
      popularity: tvshowdb.popularity,
      posterPath: (tvshowdb.posterPath != "")
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.posterPath}"
          : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
      voteAverage: tvshowdb.voteAverage,
      voteCount: tvshowdb.voteCount,
    );
  }
}
