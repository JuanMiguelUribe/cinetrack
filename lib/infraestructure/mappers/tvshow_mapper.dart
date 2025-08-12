import 'package:movieflex/domain/entities/seasons.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/infraestructure/models/movieDb/seasons_response.dart';
import 'package:movieflex/infraestructure/models/movieDb/tvshow_details_response.dart'
    hide Season;

import '../../domain/entities/tv_shows.dart';
import '../models/movieDb/tvshowdb_response.dart';

class TvshowMapper {
  static TvShow tvshowDBtoEntity(TvShowTvShowsDB tvshowdb) {
    return TvShow(
      id: tvshowdb.id,
      backdropPath:
          (tvshowdb.backdropPath != "" && tvshowdb.backdropPath != null)
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.backdropPath}"
          : "https://www.shutterstock.com/shutterstock/videos/1100631657/thumb/4.jpg?ip=x480",
      firstAirDate: tvshowdb.firstAirDate,
      genreIds: tvshowdb.genreIds,
      name: tvshowdb.name,

      originalName: tvshowdb.originalName,
      overview: tvshowdb.overview ?? "No overview available",
      popularity: tvshowdb.popularity,
      posterPath: (tvshowdb.posterPath != "" && tvshowdb.posterPath != null)
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.posterPath}"
          : "https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",
      voteAverage: tvshowdb.voteAverage,
      voteCount: tvshowdb.voteCount,
    );
  }

  static TvShowDetails tvshowDetailsToEntity(TvShowsDetails tvshowdb) {
    return TvShowDetails(
      adult: tvshowdb.adult,
      backdropPath:
          (tvshowdb.backdropPath != "" && tvshowdb.backdropPath != null)
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.backdropPath}"
          : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
      id: tvshowdb.id,
      originalLanguage: tvshowdb.originalLanguage,
      originalName: tvshowdb.originalName,
      overview: tvshowdb.overview,
      genres: tvshowdb.genres.map((e) => e.name).toList(),
      popularity: tvshowdb.popularity,
      posterPath: (tvshowdb.posterPath != "" && tvshowdb.posterPath != null)
          ? "https://image.tmdb.org/t/p/w500${tvshowdb.posterPath}"
          : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
      firstAirDate: tvshowdb.firstAirDate,
      name: tvshowdb.name,
      voteAverage: tvshowdb.voteAverage,
      voteCount: tvshowdb.voteCount,
      inProduction: tvshowdb.inProduction,
      numberOfSeasons: tvshowdb.numberOfSeasons,
      numberOfEpisodes: null,

      status: tvshowdb.status,
      type: tvshowdb.type,
      createdBy: tvshowdb.createdBy.map((e) => e.name).toList(),
      episodeRunTime: tvshowdb.episodeRunTime.map((e) => e as int).toList(),
      languages: tvshowdb.languages.map((e) => e).toList(),
      productionCompanies: tvshowdb.productionCompanies
          .map((e) => e.name)
          .toList(),
      productionCountries: tvshowdb.productionCountries
          .map((e) => e.name)
          .toList(),
      spokenLanguages: tvshowdb.spokenLanguages.map((e) => e.name).toList(),
      tagline: tvshowdb.tagline,
      lastAirDate: tvshowdb.lastAirDate,
    );
  }

  static Season seasonsDbToEntity(SeasonsDbResponde seasondb) {
    return Season(
      id: seasondb.id,
      name: seasondb.name,
      overview: seasondb.overview,
      seasonNumber: seasondb.seasonNumber,
      voteAverage: seasondb.voteAverage,
      posterPath: (seasondb.posterPath != "" && seasondb.posterPath != null)
          ? "https://image.tmdb.org/t/p/w500${seasondb.posterPath}"
          : "https://cdn.displate.com/artwork/270x380/2023-02-03/6b806b90ed460362ce845aec44991468_ee90576e764e6e2dc6be65372d967710.jpg",
      airDate: seasondb.airDate,
      episodes: seasondb.episodes
          .map(
            (ep) => EpisodeEntity(
              id: ep.id,
              name: ep.name,
              overview: ep.overview,
              episodeNumber: ep.episodeNumber,
              seasonNumber: ep.seasonNumber,
              airDate: ep.airDate,
              stillPath: ep.stillPath,
              voteAverage: ep.voteAverage,
            ),
          )
          .toList(),
    );
  }
}
