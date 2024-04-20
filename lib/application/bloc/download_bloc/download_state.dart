abstract class DownloadState{}
class InitialDownloadState extends DownloadState{}
class ProgressState extends DownloadState{
  final double progress;

  ProgressState({required this.progress});
}
class DownloadFinishState extends DownloadState{}