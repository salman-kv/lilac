import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/alert/snack_bars.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ThemeChangeState) {
          SnackBars().successSnackBar('Theme changed ', context);
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context).add(OnSwitchTheme());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tap to change theme',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ))
            ],
          ),
        ));
      },
    );
  }
}
