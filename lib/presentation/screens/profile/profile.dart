import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';
import 'package:lilac_salmankv/presentation/screens/profile/edit_profile.dart';
import 'package:lilac_salmankv/presentation/theme/user_theme.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(),
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.65,
                        decoration: BoxDecoration(
                            color: ConstColors.basicColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * (.13),
                            ),
                            Text(
                              BlocProvider.of<LoginBloc>(context)
                                  .userModel!
                                  .name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    BlocProvider.of<LoginBloc>(context)
                                        .userModel!
                                        .email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    BlocProvider.of<LoginBloc>(context)
                                        .userModel!
                                        .dob,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Color.fromARGB(255, 16, 108, 19)
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const EditProfilePage();
                                    },
                                  ));
                                },
                                child: Text(
                                  'Edit profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                    color: BlocProvider.of<LoginBloc>(context)
                                                .themeData ==
                                            UserTheme().darkTheme
                                        ? Colors.black
                                        : Colors.white,
                                    width: 20,
                                    strokeAlign: BorderSide.strokeAlignOutside),
                                borderRadius: BorderRadius.circular(1000)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: context.read<LoginBloc>().userModel !=
                                        null
                                    ? Image.network(
                                        context
                                            .read<LoginBloc>()
                                            .userModel!
                                            .image,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Lottie.asset(
                                              'assets/images/profile_loading.json');
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/profile.png');
                                        },
                                      )
                                    : const Text('data')),
                          ),
                        );
                      },
                    ),
                  ],
                )));
      },
    );
  }
}
