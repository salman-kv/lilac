import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_event.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_state.dart';
import 'package:lilac_salmankv/domain/hive/hive_function.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  String? videoUrl;
  String? photoUrl;
  late String photoPath;
  late String videoPath;
  DownloadBloc() : super(InitialDownloadState()) {
    on<OnDownloadEvent>((event, emit) async {
      if (photoUrl == null || photoUrl == null) {
      } else {
        try {
          emit(ProgressState(progress: 0));
          await FileDownloader.downloadFile(
            url: photoUrl!,
            onDownloadCompleted: (path) {
              photoPath = path;
            },
            onProgress: (fileName, progress) {},
            onDownloadError: (errorMessage) {
              log('error -  $errorMessage');
            },
          ).then((value) async {
            await FileDownloader.downloadFile(
              url: videoUrl!,
              onDownloadCompleted: (path) {
                log('path of doenloaded space $path');
                videoPath = path;
                emit(DownloadFinishState());
              },
              onProgress: (fileName, progress) {
                log('file name $fileName');
                log('progress $progress');
                emit(ProgressState(progress: progress));
              },
              onDownloadError: (errorMessage) {
                log('error -  $errorMessage');
              },
            );
          }).then((value) async {
            await HiveFunction().inserValue(
                photoPath: photoPath,
                videoPath: videoPath,
                photoUrl: photoUrl!);
          });
          HiveFunction().checkingTheFileInHive(photoUrl: photoUrl!);
        } catch (e) {
          log('$e');
        }
      }
    });
    on<ChangeEventToInisialEvent>((event, emit) {
      emit(InitialDownloadState());
    });
  }
}
