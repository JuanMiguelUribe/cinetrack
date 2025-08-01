import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart';

extension MovieDetailsMapper on MovieDetails {
  Movie fromMovieDetailsToMovieEntity() {
    return Movie(
      id: id,

      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      releaseDate: releaseDate,
      genreIds: genres, // si son objetos
      adult: adult ?? false,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      video: video ?? false,
    );
  }
}
