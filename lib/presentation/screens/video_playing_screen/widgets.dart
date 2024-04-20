// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_bloc.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_event.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_state.dart';
import 'package:lilac_salmankv/domain/const/const_drive_file_name.dart';
import 'package:lilac_salmankv/domain/hive/hive_function.dart';
import 'package:lilac_salmankv/domain/hive/hive_model/hive_model.dart';
import 'package:lilac_salmankv/presentation/alert/snack_bars.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/video_showing_screen.dart';
import 'package:shimmer/shimmer.dart';

class VideoShowingWidget {
  shimmerContainer({required BuildContext context}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? double.infinity
            : MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEBEBF4),
              Color(0xFFF4F4F4),
              Color(0xFFEBEBF4),
            ],
            stops: [
              0.1,
              0.3,
              0.4,
            ],
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }

  downloadRow(
      {required BuildContext context,
      required bool network,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          roundedArrowButton(
              iconData: Icons.arrow_back_ios_new,
              index: index,
              context: context,
              next: false),
          network
              ? downloadButton(context: context)
              : Text(
                  'Downloaded',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ConstColors.basicColor),
                ),
          roundedArrowButton(
              iconData: Icons.arrow_forward_ios,
              index: index,
              context: context,
              next: true)
        ],
      ),
    );
  }

  downloadButton({required BuildContext context}) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        if (state is ProgressState) {
          return const CupertinoActivityIndicator(
            radius: 20,
          );
        } else if (state is DownloadFinishState) {
          return Text(
            'Download Finished',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ConstColors.basicColor),
          );
        }
        return GestureDetector(
          onTap: () {
            BlocProvider.of<DownloadBloc>(context).add(OnDownloadEvent());
          },
          child: BlocBuilder<DownloadBloc, DownloadState>(
            builder: (context, state) {
              return Container(
                height: 65,
                width: 160,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 229, 229, 229)),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.caretDown,
                      color: ConstColors.basicColor,
                    ),
                    Text(
                      'Download',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  roundedArrowButton(
      {required iconData,
      required int index,
      required BuildContext context,
      required bool next}) {
    return GestureDetector(
      onTap: () async {
        log('tapped');
        if ((next && index < DriveFileName().driveFileList.length - 1) ||
            (!next && index > 0)) {
          BlocProvider.of<DownloadBloc>(context)
              .add(ChangeEventToInisialEvent());
          var result = await HiveFunction().checkingTheFileInHive(
              photoUrl: DriveFileName()
                  .driveFileList[next ? index + 1 : index - 1]
                  .keys
                  .first);
          if (result != false) {
            result as HiveModel;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return VideoShowingScreen(
                    videoUrl: result.map[result.map.keys.first]!,
                    index: next ? index + 1 : index - 1,
                    network: false);
              },
            ));
          } else {
            BlocProvider.of<DownloadBloc>(context).photoUrl = DriveFileName()
                .driveFileList[next ? index + 1 : index - 1]
                .keys
                .first;
            BlocProvider.of<DownloadBloc>(context).videoUrl =
                DriveFileName().driveFileList[next ? index + 1 : index - 1][
                    DriveFileName()
                        .driveFileList[next ? index + 1 : index - 1]
                        .keys
                        .first];
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return VideoShowingScreen(
                    index: next ? index + 1 : index - 1,
                    network: true,
                    videoUrl: DriveFileName()
                            .driveFileList[next ? index + 1 : index - 1][
                        DriveFileName()
                            .driveFileList[next ? index + 1 : index - 1]
                            .keys
                            .first]!);
              },
            ));
          }
        } else {
          SnackBars().errorSnackBar('No video found', context);
        }
      },
      child: Container(
        height: 65,
        width: 60,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 229, 229, 229)),
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Icon(
            iconData,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }

  linearProgressIndicatorForDownload({required double progress}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey,
        color: Colors.purple,
        value: progress / 100,
        minHeight: 20,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
