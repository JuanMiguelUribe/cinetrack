// import 'package:flutter/material.dart';
// import 'package:movieflex/domain/entities/movie.dart';
// import 'package:movieflex/domain/entities/tv_shows.dart';
// import 'package:movieflex/presentation/providers/providers.dart';
// import 'package:movieflex/presentation/widgets/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// import '../../../l10n/app_localizations.dart';

// class SeriesView extends ConsumerStatefulWidget {
//   const SeriesView({super.key});

//   @override
//   SeriesViewState createState() => SeriesViewState();
// }

// class SeriesViewState extends ConsumerState<SeriesView> {
//   @override
//   void initState() {
//     super.initState();

//     // Cargar series después de un frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(airingTvShowProvider.notifier).loadNextPage();
//       ref.read(onTheAirTvShowProvider.notifier).loadNextPage();
//       ref.read(popularTvShowProvider.notifier).loadNextPage();
//       ref.read(topRatedTvShowProvider.notifier).loadNextPage();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = ref.watch(initialLoadingProvider);
//     if (isLoading) return const FullScreenLoader();
//     final slideShowTvshows = ref.watch(tvShowSlideshowProvider);
//     final airingTvShows = ref.watch(airingTvShowProvider);
//     final onTheAirTvShows = ref.watch(onTheAirTvShowProvider);
//     final popularTvShows = ref.watch(popularTvShowProvider);
//     final topRatedTvShows = ref.watch(topRatedTvShowProvider);
//     final tvItems = slideShowTvshows
//         .map(
//           (tv) => Movie(
//             id: tv.id,
//             title: tv.name,
//             posterPath: tv.posterPath!,
//             backdropPath: tv.backdropPath,
//             overview: tv.overview ?? "",
//             popularity: tv.voteAverage,
//             adult: false,
//             genreIds: tv.genreIds,
//             originalLanguage: tv.originalLanguage ?? "",
//             originalTitle: tv.originalLanguage ?? "",
//             video: false,
//             voteAverage: tv.voteAverage,
//             voteCount: tv.voteCount,
//           ),
//         )
//         .toList();

//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           floating: true,
//           snap: true,
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           elevation: 0,
//           flexibleSpace: Padding(
//             padding: const EdgeInsets.only(
//               top: kToolbarHeight * 0.1,
//             ), // opcional
//             child: CustomAppbar(),
//           ),
//           expandedHeight: 80,
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate((context, index) {
//             return Column(
//               children: [
//                 // CustomAppbar(),
//                 MoviesSlideshow(
//                   movies: tvItems,
//                   showTitle: true,
//                   aspectRatio: 12 / 7.5,
//                   viewportFraction: 0.80,
//                 ),
//                 buildSectionDivider(
//                   AppLocalizations.of(context)!.tvshows,
//                   context,
//                 ),
//                 //*Barra de busqueda
//                 SearchBarWidget(ref: ref),

//                 // const SizedBox(height: 150),
//                 _SeriesSectionSlides(
//                   airingTvShows: airingTvShows,
//                   ref: ref,
//                   onTheAirTvShows: onTheAirTvShows,
//                   popularTvShows: popularTvShows,
//                   topRatedTvShows: topRatedTvShows,
//                 ), // Espacio al final de la lista
//               ],
//             );
//           }, childCount: 1),
//         ),
//       ],
//     );
//   }
// }

// Widget buildSectionDivider(String title, BuildContext context) {
//   final colors = Theme.of(context).colorScheme;

//   return Padding(
//     padding: const EdgeInsets.only(top: 20),
//     child: Row(
//       children: [
//         const SizedBox(width: 10),
//         Expanded(
//           child: Divider(
//             color: colors.outlineVariant.withOpacity(0.8),
//             thickness: 1,
//             endIndent: 10,
//           ),
//         ),
//         Text(
//           title,
//           style: GoogleFonts.robotoFlex(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//             color: colors.onSurface.withAlpha(150),
//           ),
//         ),

//         Expanded(
//           child: Divider(
//             color: colors.outlineVariant.withOpacity(0.8),
//             thickness: 1,
//             indent: 10,
//           ),
//         ),
//         const SizedBox(width: 10),
//       ],
//     ),
//   );
// }

// class _SeriesSectionSlides extends StatelessWidget {
//   const _SeriesSectionSlides({
//     required this.airingTvShows,
//     required this.ref,
//     required this.onTheAirTvShows,
//     required this.popularTvShows,
//     required this.topRatedTvShows,
//   });

//   final List<TvShow> airingTvShows;
//   final WidgetRef ref;
//   final List<TvShow> onTheAirTvShows;
//   final List<TvShow> popularTvShows;
//   final List<TvShow> topRatedTvShows;

//   @override
//   Widget build(BuildContext context) {
//     // final colors = Theme.of(context).colorScheme;
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 0),
//       child: Column(
//         children: [
//           TvShowHorizontalListView(
//             tvShows: airingTvShows,
//             title: AppLocalizations.of(context)!.airingToday,
//             subtitle: DateFormat('EEEE, d MMMM').format(DateTime.now()),
//             loadNextPage: () =>
//                 ref.read(airingTvShowProvider.notifier).loadNextPage(),
//           ),
//           TvShowHorizontalListView(
//             tvShows: onTheAirTvShows,
//             title: AppLocalizations.of(context)!.onTheAir,
//             subtitle: DateFormat.EEEE(
//               Localizations.localeOf(context).languageCode,
//             ).format(DateTime.now()),
//             loadNextPage: () =>
//                 ref.read(onTheAirTvShowProvider.notifier).loadNextPage(),
//           ),
//           TvShowHorizontalListView(
//             tvShows: popularTvShows,
//             title: AppLocalizations.of(context)!.popular,
//             subtitle: DateFormat(
//               'MMMM',
//               Localizations.localeOf(context).languageCode,
//             ).format(DateTime.now()),
//             loadNextPage: () =>
//                 ref.read(popularTvShowProvider.notifier).loadNextPage(),
//           ),
//           TvShowHorizontalListView(
//             tvShows: topRatedTvShows,
//             title: AppLocalizations.of(context)!.topRated,
//             subtitle: AppLocalizations.of(context)!.always,
//             loadNextPage: () =>
//                 ref.read(topRatedTvShowProvider.notifier).loadNextPage(),
//           ),
//           SizedBox(height: 100),
//         ],
//       ),
//     );
//   }
// }
