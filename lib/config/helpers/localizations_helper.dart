import 'package:movieflex/l10n/app_localizations.dart';

extension LocalizationHelper on AppLocalizations {
  String getTranslation(String key) {
    final map = {
      "genre_action": genreAction,
      "genre_adventure": genreAdventure,
      "genre_animation": genreAnimation,
      "genre_comedy": genreComedy,
      "genre_crime": genreCrime,
      "genre_documentary": genreDocumentary,
      "genre_drama": genreDrama,
      "genre_family": genreFamily,
      "genre_fantasy": genreFantasy,
      "genre_history": genreHistory,
      "genre_horror": genreHorror,
      "genre_music": genreMusic,
      "genre_mystery": genreMystery,
      "genre_romance": genreRomance,
      "genre_scifi": genreScienceFiction,
      "genre_tv_movie": genreTvMovie,
      "genre_thriller": genreThriller,
      "genre_war": genreWar,
      "genre_western": genreWestern,
    };

    return map[key] ?? key;
  }
}
