import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';

extension TvShowDetailsMapper on TvShowDetails {
  TvShow fromTvShowDetailsToTvShowEntity() {
    return TvShow(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      backdropPath: (backdropPath != "" && backdropPath != null)
          ? "https://image.tmdb.org/t/p/w500$backdropPath"
          : "https://www.shutterstock.com/shutterstock/videos/1100631657/thumb/4.jpg?ip=x480",
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity ?? 0,
      firstAirDate: firstAirDate,
      genreIds: genres,
      originalLanguage: originalLanguage,
      originalName: originalName ?? "No Founded",
    );
  }
}
