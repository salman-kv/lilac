import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_bloc.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_event.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_state.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/video_showing_screen.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/widgets.dart';

class VideoDownloadingScreen extends StatelessWidget {
  final bool network;
  final int index;
  const VideoDownloadingScreen(
      {super.key, required this.network, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoShowingWidget()
            .downloadRow(context: context, network: network, index: index),
        BlocBuilder<DownloadBloc, DownloadState>(
          builder: (context, state) {
            if (state is ProgressState) {
              return Column(
                children: [
                  VideoShowingWidget().linearProgressIndicatorForDownload(
                      progress: state.progress),
                  Center(child: Text('Downloading ${state.progress}%'))
                ],
              );
            } else if (state is DownloadFinishState) {
              return ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<DownloadBloc>(context)
                        .add(ChangeEventToInisialEvent());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return VideoShowingScreen(
                            videoUrl: context.read<DownloadBloc>().videoPath,
                            index: index,
                            network: false);
                      },
                    ));
                  },
                  child: Text(
                    'playOfline',
                    style: Theme.of(context).textTheme.titleMedium!,
                  ));
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
