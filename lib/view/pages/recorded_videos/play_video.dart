import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoFlicker extends StatefulWidget {
  const PlayVideoFlicker({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<PlayVideoFlicker> createState() => _PlayVideoFlickerState();
}

class _PlayVideoFlickerState extends State<PlayVideoFlicker> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
 videoPlayerController: VideoPlayerController.networkUrl(
   Uri.parse(
widget.videoUrl,
// 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
   ),
 ),
 autoPlay: false,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 body: PopScope(
   canPop: true,
   onPopInvoked: (didPop) {
if (flickManager.flickControlManager!.isFullscreen) {
  flickManager.flickControlManager!.exitFullscreen();
}
   },
   child: FlickVideoPlayer(
flickManager: flickManager,
// preferredDeviceOrientation: const [
//   DeviceOrientation.landscapeLeft,
//   DeviceOrientation.landscapeRight,
//   DeviceOrientation.portraitUp,
// ],
// preferredDeviceOrientationFullscreen: const [
//   DeviceOrientation.landscapeLeft,
//   DeviceOrientation.landscapeRight,
//   DeviceOrientation.portraitUp,
// ],

flickVideoWithControls: const FlickVideoWithControls(
  controls: FlickPortraitControls(),
  videoFit: BoxFit.fitWidth,
),
flickVideoWithControlsFullscreen: const FlickVideoWithControls(
  controls: FlickLandscapeControls(),
  // videoFit: BoxFit.fitHeight,
),
   ),
),
);
}
}