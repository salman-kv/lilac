import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/alert/snack_bars.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';
import 'package:lilac_salmankv/presentation/screens/home/home_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            log('$state');
            if (state is OtpverificationSuccessState) {
              SnackBars().successSnackBar('Login Successfull', context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ), (route) => false);
            } else if (state is OtpverificationFailedState) {
              SnackBars().errorSnackBar('Invalid otp', context);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PinFieldAutoFill(
                    textInputAction: TextInputAction.done,
                    controller: context.watch<LoginBloc>().otpController,
                    decoration: UnderlineDecoration(
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.blue),
                      colorBuilder: const FixedColorBuilder(
                        Colors.transparent,
                      ),
                      bgColorBuilder: FixedColorBuilder(
                        Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    currentCode: context.watch<LoginBloc>().otpController.text,
                    onCodeSubmitted: (code) {},
                    onCodeChanged: (code) {
                      if (code?.length == 6) {
                        BlocProvider.of<LoginBloc>(context).add(
                            OtpVerificationEvent(
                                otp: context
                                    .read<LoginBloc>()
                                    .otpController
                                    .text,
                                verificationId: verificationId));
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<LoginBloc>(context).add(
                          OtpVerificationEvent(
                              otp: context.read<LoginBloc>().otpController.text,
                              verificationId: verificationId));
                    },
                    child: Text(
                      'Verify Otp',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ConstColors.basicColor),
                    )),
              ],
            );
          },
        ),
      ),
    ));
  }
}
