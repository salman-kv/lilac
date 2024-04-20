// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/domain/shared_prefrence_fuction/shared_prefrence.dart';
import 'package:lilac_salmankv/presentation/alert/snack_bars.dart';
import 'package:lilac_salmankv/presentation/screens/sign_in_screen/sign_in_screen.dart';

class Alert {
  alertFunction({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Do you want to Logout',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    await SharedPrefrenceFunction().userLogOut();
                    SnackBars().successSnackBar('LogOut Successfully', context);
                    BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (context) {
                        return SignInScreen();
                      },
                    ), (route) => false);
                  },
                  child: Text(
                    'Yes',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.green),
                  )),
            ],
          );
        });
  }
}
