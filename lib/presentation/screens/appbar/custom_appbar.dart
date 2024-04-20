
// custom appbar 

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/screens/profile/edit_profile.dart';
import 'package:lilac_salmankv/presentation/screens/profile/profile.dart';
import 'package:lilac_salmankv/presentation/theme/user_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final Color color;
  final bool back;
  const CustomAppBar(
      {super.key, required this.icon, required this.color, required this.back});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(5),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              log('open drewer');
              if (back) {
                Navigator.pop(context);
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Icon(
                  icon,
                  size: 40,
                  color: context.watch<LoginBloc>().themeData ==
                          UserTheme().lightTheme
                      ? Colors.black
                      : Colors.white,
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return BlocProvider.of<LoginBloc>(context).userModel == null
                      ? EditProfilePage()
                      : const ProfilePage();
                },
              ));
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SizedBox(
                    height: 50,
                    width: 50,
                    child: context.read<LoginBloc>().userModel != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              context.read<LoginBloc>().userModel!.image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(2000),
                            child: Image.asset(
                              'assets/images/profile_image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
