import 'package:cinetrack/domain/entities/movie.dart';
import 'package:cinetrack/infraestructure/models/movieDb/movie_details.dart';
import 'package:cinetrack/infraestructure/models/movieDb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != "" && moviedb.backdropPath != null)
        ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != null && moviedb.posterPath != "")
        ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",

    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != "")
        ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
    genreIds: moviedb.genres.map((e) => e.name).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != "")
        ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}
