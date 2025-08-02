import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MovieDex'**
  String get appTitle;

  /// No description provided for @watchNow.
  ///
  /// In en, this message translates to:
  /// **'Watch Now'**
  String get watchNow;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @nowPlaying.
  ///
  /// In en, this message translates to:
  /// **'Now Playing'**
  String get nowPlaying;

  /// No description provided for @coomingSoon.
  ///
  /// In en, this message translates to:
  /// **'Cooming Soon'**
  String get coomingSoon;

  /// No description provided for @airingToday.
  ///
  /// In en, this message translates to:
  /// **'Airing Today'**
  String get airingToday;

  /// No description provided for @onTheAir.
  ///
  /// In en, this message translates to:
  /// **'On The Air'**
  String get onTheAir;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @tvshows.
  ///
  /// In en, this message translates to:
  /// **'Tv Shows'**
  String get tvshows;

  /// No description provided for @always.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get always;

  /// No description provided for @homeNav.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNav;

  /// No description provided for @categoriasNav.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriasNav;

  /// No description provided for @favsNav.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favsNav;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @resultsSearch.
  ///
  /// In en, this message translates to:
  /// **'No results Found'**
  String get resultsSearch;

  /// No description provided for @unknownDate.
  ///
  /// In en, this message translates to:
  /// **'Unknown Date'**
  String get unknownDate;

  /// No description provided for @movieSearch.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get movieSearch;

  /// No description provided for @tvshowSearch.
  ///
  /// In en, this message translates to:
  /// **'Tv Show'**
  String get tvshowSearch;

  /// No description provided for @myFavoriteMovies.
  ///
  /// In en, this message translates to:
  /// **'Favorites Movies'**
  String get myFavoriteMovies;

  /// No description provided for @myFavoriteTvshows.
  ///
  /// In en, this message translates to:
  /// **'Favorites TV Shows'**
  String get myFavoriteTvshows;

  /// No description provided for @startTheSearch.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get startTheSearch;

  /// No description provided for @exploreMoreMovies.
  ///
  /// In en, this message translates to:
  /// **'Explore More Movies'**
  String get exploreMoreMovies;

  /// No description provided for @exploreMoreTvShows.
  ///
  /// In en, this message translates to:
  /// **'Explore More TV Shows'**
  String get exploreMoreTvShows;

  /// No description provided for @favoriteMovieNotAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'Start adding your favorite movies!'**
  String get favoriteMovieNotAddedMessage;

  /// No description provided for @favoriteTvShowNotAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'Add some TV shows to your favorites to see them here.'**
  String get favoriteTvShowNotAddedMessage;

  /// No description provided for @watchTrailer.
  ///
  /// In en, this message translates to:
  /// **'Watch Trailer'**
  String get watchTrailer;

  /// No description provided for @relatedVideos.
  ///
  /// In en, this message translates to:
  /// **'Related Videos'**
  String get relatedVideos;

  /// No description provided for @noTrailerFound.
  ///
  /// In en, this message translates to:
  /// **'No Trailer Found'**
  String get noTrailerFound;

  /// No description provided for @overviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTitle;

  /// No description provided for @ratingTitle.
  ///
  /// In en, this message translates to:
  /// **'TMDB Rating'**
  String get ratingTitle;

  /// No description provided for @details_title.
  ///
  /// In en, this message translates to:
  /// **'Original Title'**
  String get details_title;

  /// No description provided for @details_release.
  ///
  /// In en, this message translates to:
  /// **'Release'**
  String get details_release;

  /// No description provided for @details_language.
  ///
  /// In en, this message translates to:
  /// **'Original Language'**
  String get details_language;

  /// No description provided for @details_budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get details_budget;

  /// No description provided for @details_revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get details_revenue;

  /// No description provided for @details_runtime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get details_runtime;

  /// No description provided for @details_tagline.
  ///
  /// In en, this message translates to:
  /// **'Tagline'**
  String get details_tagline;

  /// No description provided for @details_homepage.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get details_homepage;

  /// No description provided for @details_production_companies.
  ///
  /// In en, this message translates to:
  /// **'Production Companies'**
  String get details_production_companies;

  /// No description provided for @details_production_countries.
  ///
  /// In en, this message translates to:
  /// **'Production Countries'**
  String get details_production_countries;

  /// No description provided for @details_spoken_languages.
  ///
  /// In en, this message translates to:
  /// **'Spoken Languages'**
  String get details_spoken_languages;

  /// No description provided for @details_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide Details'**
  String get details_hide;

  /// No description provided for @show_more_details.
  ///
  /// In en, this message translates to:
  /// **'View More Details'**
  String get show_more_details;

  /// No description provided for @first_air_episode.
  ///
  /// In en, this message translates to:
  /// **'First Episode Air Date'**
  String get first_air_episode;

  /// No description provided for @last_air_episode.
  ///
  /// In en, this message translates to:
  /// **'Last Episode Air Date'**
  String get last_air_episode;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @created_by.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get created_by;

  /// No description provided for @in_production.
  ///
  /// In en, this message translates to:
  /// **'In Production'**
  String get in_production;

  /// No description provided for @yes_response.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes_response;

  /// No description provided for @no_response.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no_response;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
