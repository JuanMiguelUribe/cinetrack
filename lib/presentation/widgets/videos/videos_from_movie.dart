import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosFromMovie extends ConsumerWidget {
  final int movieId;

  const VideosFromMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, _) =>
          const Center(child: Text('No se pudo cargar películas similares')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<VideoMovie> videos;

  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    final trailerVideos = videos
        .where((video) => video.type == 'Trailer')
        .toList();

    //* Nada que mostrar
    if (trailerVideos.isEmpty) {
      return const SizedBox(child: Text("Not Video Founded"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Aunque tengo varios videos, sólo quiero mostrar el primero
        _YouTubeVideoPlayer(
          youtubeId: trailerVideos.first.youtubeKey,
          name: trailerVideos.first.name,
          type: trailerVideos.first.type,
        ),
        // Text(trailerVideos.first.type),

        //* Si se desean mostrar todos los videos
        // ...videos.map(
        //   (video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)
        // ).toList()
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
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
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
        autoPlay: true,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [YoutubePlayer(controller: _controller)],
    );
  }
}
