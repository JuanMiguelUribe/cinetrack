import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/movies/video_movie_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerCarousel extends ConsumerStatefulWidget {
  final int movieId;
  final MediaType type;
  const TrailerCarousel({super.key, required this.movieId, required this.type});

  @override
  ConsumerState<TrailerCarousel> createState() => _TrailerCarouselState();
}

class _TrailerCarouselState extends ConsumerState<TrailerCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  void _nextPage(int total) {
    if (_currentPage < total - 1 && _currentPage < 19) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncVideos = ref.watch(
      videosProvider((id: widget.movieId, type: widget.type)),
    );
    final colors = Theme.of(context).colorScheme;

    return asyncVideos.when(
      data: (videos) {
        // final trailers = videos.where((v) => v.type == 'Trailer').toList();
        final limitedVideos = videos.take(20).toList();

        if (videos.isEmpty) {
          return _ResultIfVIdeosAreEmpty();
        }

        //*If por si solo hay un video, no mostar los botones
        if (videos.length <= 1) {
          return _WidgetForOnlyOneVideo(videos: videos);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                AppLocalizations.of(context)!.relatedVideos,
                textAlign: TextAlign.center,
                style: AppTextStyles.titlesForDetailScreen(context),
              ),
            ),
            SizedBox(height: 5),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.57,
                  // width: 2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: limitedVideos.length,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemBuilder: (context, index) {
                      final video = limitedVideos[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: _YouTubeVideoPlayer(
                                  youtubeId: video.youtubeKey,
                                  name: video.name,
                                  type: video.type,
                                ),
                              ),
                            ),
                            Text(
                              video.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.videoNameTitle(context),
                            ),
                            Text(
                              video.type,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.videoTypeTitle(context),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                //*Botón izquierdo
                _currentPage != 0
                    ? Positioned(
                        left: 0,
                        top: MediaQuery.of(context).size.width * 0.18,

                        child: IconButton(
                          onPressed: _previousPage,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: colors.primary,
                          // style: IconButton.styleFrom(
                          //   backgroundColor: Colors.black.withOpacity(0.5),
                          //   shape: const CircleBorder(),
                          // ),
                        ),
                      )
                    : SizedBox(),

                //* Botón derecho
                _currentPage != videos.length - 1
                    ? Positioned(
                        right: 0,
                        top: MediaQuery.of(context).size.width * 0.18,
                        child: IconButton(
                          onPressed: () => _nextPage(videos.length),
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          color: colors.primary,
                          // style: IconButton.styleFrom(
                          //   backgroundColor: Colors.black.withOpacity(0.5),
                          //   shape: const CircleBorder(),
                          // ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),

            Center(
              child: Text(
                '${_currentPage + 1}/${limitedVideos.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error cargando trailers')),
    );
  }
}

class _WidgetForOnlyOneVideo extends StatelessWidget {
  final List<VideoMovie> videos;
  const _WidgetForOnlyOneVideo({required this.videos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.relatedVideos,
            textAlign: TextAlign.center,
            style: AppTextStyles.titlesForDetailScreen(context),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _YouTubeVideoPlayer(
                  youtubeId: videos.first.youtubeKey,
                  name: videos.first.name,
                  type: videos.first.type,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultIfVIdeosAreEmpty extends StatelessWidget {
  const _ResultIfVIdeosAreEmpty();

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.relatedVideos,
            textAlign: TextAlign.center,
            style: AppTextStyles.titlesForDetailScreen(context),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 226, 226).withAlpha(10),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: Text(AppLocalizations.of(context)!.resultsSearch),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;
  final String type;

  const _YouTubeVideoPlayer({
    required this.youtubeId,
    required this.name,
    required this.type,
  });

  @override
  _YouTubeVideoPlayerState createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }
}
