import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/screens/appbar/custom_appbar.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/downloading_screen.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/widgets.dart';
import 'package:lilac_salmankv/presentation/theme/user_theme.dart';
import 'package:video_player/video_player.dart';

class VideoShowingScreen extends StatefulWidget {
  final String videoUrl;
  final int index;
  final bool network;

  const VideoShowingScreen(
      {super.key,
      required this.videoUrl,
      required this.index,
      required this.network});

  @override
  State<VideoShowingScreen> createState() => _VideoShowingScreen();
}

class _VideoShowingScreen extends State<VideoShowingScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoPlayerController = widget.network
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        : VideoPlayerController.file(File(widget.videoUrl));
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  bool visible = true;

  onTapVideo() {
    visible = !visible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: BlocProvider.of<LoginBloc>(context).themeData ==
                    UserTheme().darkTheme
                ? Colors.black
                : const Color.fromARGB(255, 240, 240, 240),
            body: ListView(
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? double.infinity
                                : MediaQuery.of(context).size.height * 0.3,
                            child: GestureDetector(
                              onTap: () {
                                onTapVideo();
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  VideoPlayer(
                                    _videoPlayerController,
                                  ),
                                  Visibility(
                                      visible: visible,
                                      child: buildControls(
                                          context: context,
                                          videoPlayerController:
                                              _videoPlayerController)),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return VideoShowingWidget()
                              .shimmerContainer(context: context);
                        }
                      },
                    ),
                    Visibility(
                        visible: visible,
                        child: const CustomAppBar(
                            back: true,
                            icon: Icons.arrow_back_ios,
                            color: Colors.white)),
                  ],
                ),
                VideoDownloadingScreen(
                  network: widget.network,
                  index: widget.index,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildControls(
      {required VideoPlayerController videoPlayerController,
      required BuildContext context}) {
    void play() {
      if (!videoPlayerController.value.isPlaying) {
        videoPlayerController.play();
        setState(() {});
      }
    }

    void pause() {
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
        setState(() {});
      }
    }

    void fastForward() {
      videoPlayerController.seekTo(
        videoPlayerController.value.position + const Duration(seconds: 10),
      );
    }

    void rewind() {
      videoPlayerController.seekTo(
        videoPlayerController.value.position - const Duration(seconds: 10),
      );
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Color.fromARGB(8, 28, 28, 28)])),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                // Icons.rotate_90_degrees_ccw_sharp,
                Icons.replay_10,
                color: Colors.white,
              ),
              onPressed: rewind,
            ),
            IconButton(
              icon: videoPlayerController.value.isPlaying
                  ? const FaIcon(
                      FontAwesomeIcons.pause,
                      color: Colors.white,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                    ),
              onPressed: () {
                videoPlayerController.value.isPlaying ? pause() : play();
              },
            ),
            IconButton(
              icon: const Icon(
                // Icons.rotate_90_degrees_cw_outlined,
                Icons.forward_10,
                color: Colors.white,
              ),
              onPressed: fastForward,
            ),
          ],
        ),
      ],
    );
  }
}
