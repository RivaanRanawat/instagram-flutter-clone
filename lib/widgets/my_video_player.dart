import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String filepath;
  final bool initiallyMuted;
  final bool initiallyPlaying;
  final bool showButtonIcons;

  const VideoApp(
      {required this.filepath,
      this.initiallyMuted = true,
      this.initiallyPlaying = true,
      this.showButtonIcons = false,
      Key? key})
      : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late bool isMuted;
  late bool isPlaying;
  late bool isFullScreen;
  late bool iconVisible;

  @override
  void initState() {
    super.initState();
    isMuted = widget.initiallyMuted;
    isPlaying = widget.initiallyPlaying;
    isFullScreen = false;
    iconVisible = widget.showButtonIcons;

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.filepath))
      ..initialize().then((_) {
        setState(() {});
        if (isPlaying) _controller.play();
        _controller.setLooping(true);
      });
  }

  void handleTap() {
    setState(() {
      iconVisible = !iconVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: handleTap,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ))
            : CircularProgressIndicator(),
      ),
      floatingActionButton: iconVisible
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      isMuted
                          ? _controller.setVolume(1.0)
                          : _controller.setVolume(0.0);
                      isMuted = !isMuted;
                    });
                  },
                  child: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                      isPlaying = !isPlaying;
                    });
                  },
                  child: Icon(_controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: () async {
                    setState(() {
                      isFullScreen = !isFullScreen;
                    });
                    isFullScreen
                        ? await _controller.play()
                        : await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenPlayer(
                                      controller: _controller,
                                    )));
                  },
                  child: isFullScreen
                      ? Icon(Icons.fullscreen_exit)
                      : Icon(Icons.fullscreen),
                )
              ],
            )
          : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class FullScreenPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  bool isMuted = false;
  bool isPlay = true;
  FullScreenPlayer({required this.controller});

  void muteUnmuteCallback() {
    isMuted = !isMuted;
  }

  void playPauseCallback() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    isPlay = !isPlay;
  }

  void fullScreenCallback(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(children: [
              VideoPlayer(controller),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Colors.black38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              isMuted ? Icons.volume_off : Icons.volume_up),
                          color: Colors.white,
                          onPressed: () => muteUnmuteCallback(),
                        ),
                        IconButton(
                          icon: Icon(controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          color: Colors.white,
                          onPressed: () => playPauseCallback(),
                        ),
                        IconButton(
                          icon: Icon(Icons.fullscreen_exit),
                          color: Colors.white,
                          onPressed: () => fullScreenCallback(context),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
