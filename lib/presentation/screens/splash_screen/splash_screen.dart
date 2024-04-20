import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/screens/home/home_screen.dart';
import 'package:lilac_salmankv/presentation/screens/sign_in_screen/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(SplashScreenLoginEvent());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SplashScreenUserNotLoginedState) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return SignInScreen();
            },
          ), (route) => false);
        } else if (state is SplashScreenUserAlredyLoginedState) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (route) => false);
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: Center(child: Image.asset('assets/images/lilac.png')),
      )),
    );
  }
}
