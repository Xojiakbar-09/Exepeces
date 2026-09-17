import 'dart:io';

import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/utils/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';
import 'package:video_player/video_player.dart';

class FullVideo extends StatefulWidget {
  final File fayl;
  const FullVideo({super.key, required this.fayl});

  @override
  State<FullVideo> createState() => _FullVideoState();
}

class _FullVideoState extends State<FullVideo>
    with SingleTickerProviderStateMixin {
  bool isVisibal = true;
  late final AnimationController _animationController;
  late final VideoPlayer _videoPlayer;
  late final VideoPlayerController _videoPlayerController;

  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '$minutes:$seconds';
  // }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // _videoPlayerController =
    //     VideoPlayerController.networkUrl(
    //         Uri.parse(
    //           'https://fra.cloud.appwrite.io/v1/storage/buckets/6aa42198001612c273c0/files/6aa93a360002afb8cd22/view?project=6aa413fc001db8e22ee0',
    //         ),
    //       )
    //       ..initialize().then((v) {
    //         setState(() {});
    //         _videoPlayerController.play();
    //       });
    _videoPlayerController = VideoPlayerController.file(widget.fayl)
      ..initialize().then((v) {
        setState(() {});
        _videoPlayerController.play();
      });
    _videoPlayer = VideoPlayer(_videoPlayerController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cols.black,
      appBar: AppBar(
        backgroundColor: Cols.black,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: LiquidGlassButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          LiquidGlassButton(
            icon: Icons.speed,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => LiquidGlassDialog(
                  child: StatefulBuilder(
                    builder: (context, dialogsetStet) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Speed'),
                          Slider(
                            activeColor: Cols.black,
                            divisions: 3,
                            min: 0.3,
                            max: 2,
                            value: _videoPlayerController.value.playbackSpeed,
                            onChanged: (v) {
                              _videoPlayerController.setPlaybackSpeed(v);
                              dialogsetStet(() {});
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                isVisibal = true;
                setState(() {});
                Future.delayed(Duration(seconds: 3)).then((v) {
                  isVisibal = false;
                  setState(() {});
                });
              },
              child: Hero(
                tag: 'video1',
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isVisibal == true ? 1.0 : 0.0,
                child: LiquidGlassSlider(
                  width: context.width,
                  maximumValue: _videoPlayerController
                      .value
                      .duration
                      .inMilliseconds
                      .toDouble(),
                  activeColor: Cols.black,
                  value: _videoPlayerController.value.position.inMilliseconds
                      .toDouble(),
                  onChanged: (v) {
                    _videoPlayerController.seekTo(
                      Duration(milliseconds: v.toInt()),
                    );
                  },
                ),
              ),
            ),
            // Positioned(
            //   bottom: 3,
            //   child: AnimatedOpacity(
            //     duration: Duration(milliseconds: 500),
            //     opacity: isVisibal == true ? 1.0 : 0.0,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           _formatDuration(_videoPlayerController.value.position),
            //           style: const TextStyle(color: Colors.white, fontSize: 12),
            //         ),
            //         Text(
            //           _formatDuration(_videoPlayerController.value.duration),
            //           style: const TextStyle(color: Colors.white, fontSize: 12),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isVisibal == true ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      LiquidGlassButton(
                        onPressed: () {
                          _videoPlayerController.seekTo(
                            Duration(
                              seconds:
                                  _videoPlayerController
                                      .value
                                      .position
                                      .inSeconds -
                                  10,
                            ),
                          );
                        },
                        child: Icon(Icons.replay_10),
                      ),
                      Spacer(),
                      LiquidGlassButton(
                        onPressed: () {
                          Future.delayed(Duration(seconds: 3)).then((v) {
                            isVisibal = false;
                            setState(() {});
                          });
                          if (_videoPlayerController.value.isPlaying) {
                            _animationController.forward();
                            _videoPlayerController.pause();
                          } else {
                            _animationController.reverse();
                            _videoPlayerController.play();
                          }
                        },
                        child:
                            (_videoPlayerController.value.isInitialized ==
                                    false ||
                                _videoPlayerController.value.isBuffering ==
                                    true)
                            ? CupertinoActivityIndicator()
                            : AnimatedIcon(
                                icon: AnimatedIcons.pause_play,
                                progress: _animationController,
                              ),
                      ),
                      Spacer(),
                      LiquidGlassButton(
                        onPressed: () {
                          _videoPlayerController.seekTo(
                            Duration(
                              seconds:
                                  _videoPlayerController
                                      .value
                                      .position
                                      .inSeconds +
                                  10,
                            ),
                          );
                        },
                        child: Icon(Icons.forward_10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
