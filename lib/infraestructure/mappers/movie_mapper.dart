import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/infraestructure/models/movieDb/movie_details.dart'
    hide Genre, ProductionCompany, ProductionCountry, SpokenLanguage;
import 'package:movieflex/infraestructure/models/movieDb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != "" && moviedb.backdropPath != null)
        ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}"
        : "https://www.shutterstock.com/shutterstock/videos/1100631657/thumb/4.jpg?ip=x480",
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != null && moviedb.posterPath != "")
        ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}"
        : "https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",

    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );

  static MovieDetails movieDetailsToEntity(
    MovieDetailsResponse moviedb,
  ) => MovieDetails(
    id: moviedb.id,
    title: moviedb.title,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview ?? '',
    tagline: moviedb.tagline ?? '',
    adult: moviedb.adult ?? false,
    video: moviedb.video ?? false,
    budget: moviedb.budget,
    revenue: moviedb.revenue,
    popularity: moviedb.popularity,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
    runtime: moviedb.runtime ?? 0,
    releaseDate: moviedb.releaseDate,
    originalLanguage: moviedb.originalLanguage,

    // Backdrop con fallback
    backdropPath: (moviedb.backdropPath?.isNotEmpty ?? false)
        ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",

    // Poster con fallback
    posterPath: (moviedb.posterPath?.isNotEmpty ?? false)
        ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}"
        : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",

    // Homepage opcional
    homepage: moviedb.homepage ?? '',
    genres: moviedb.genres.map((e) => e.toString()).toList(),

    productionCompanies: List<String>.from(moviedb.productionCompanies),

    productionCountries: List<String>.from(moviedb.productionCountries),
    spokenLanguages: List<String>.from(moviedb.spokenLanguages),

    // Países de origen
    originCountry: moviedb.originCountry,

    // Colección a la que pertenece (si aplica)
    belongsToCollectionName: moviedb.belongsToCollection?.name,
    belongsToCollectionPoster:
        (moviedb.belongsToCollection?.posterPath?.isNotEmpty ?? false)
        ? "https://image.tmdb.org/t/p/w500${moviedb.belongsToCollection!.posterPath}"
        : null,

    belongsToCollection: null,
    status: '',
    imdbId: moviedb.imdbId,
  );
}
