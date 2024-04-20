// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_bloc.dart';
import 'package:lilac_salmankv/application/bloc/download_bloc/download_event.dart';
import 'package:lilac_salmankv/domain/const/const_drive_file_name.dart';
import 'package:lilac_salmankv/domain/hive/hive_function.dart';
import 'package:lilac_salmankv/domain/hive/hive_model/hive_model.dart';
import 'package:lilac_salmankv/presentation/screens/appbar/custom_appbar.dart';
import 'package:lilac_salmankv/presentation/screens/home/widget.dart';
import 'package:lilac_salmankv/presentation/screens/video_playing_screen/video_showing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: HomeScreenWidget().customDrawer(context: context),
      appBar: const CustomAppBar(
        back: false,
        icon: Icons.menu,
        color: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                children: List.generate(DriveFileName().driveFileList.length,
                    (index) {
              return GestureDetector(
                onTap: () async {
                  BlocProvider.of<DownloadBloc>(context)
                      .add(ChangeEventToInisialEvent());
                  var result = await HiveFunction().checkingTheFileInHive(
                      photoUrl:
                          DriveFileName().driveFileList[index].keys.first);
                  if (result != false) {
                    result as HiveModel;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return VideoShowingScreen(
                            videoUrl: result.map[result.map.keys.first]!,
                            index: index,
                            network: false);
                      },
                    ));
                  } else {
                    BlocProvider.of<DownloadBloc>(context).photoUrl =
                        DriveFileName().driveFileList[index].keys.first;
                    BlocProvider.of<DownloadBloc>(context).videoUrl =
                        DriveFileName().driveFileList[index]
                            [DriveFileName().driveFileList[index].keys.first];
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return VideoShowingScreen(
                            index: index,
                            network: true,
                            videoUrl: DriveFileName().driveFileList[index][
                                DriveFileName()
                                    .driveFileList[index]
                                    .keys
                                    .first]!);
                      },
                    ));
                  }
                },
                child: HomeScreenWidget().imageContainer(
                    image: DriveFileName().driveFileList[index].keys.first,
                    context: context),
              );
            })),
          ],
        ),
      ),
    ));
  }
}
