import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/presentation/alert/snack_bars.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';
import 'package:lilac_salmankv/presentation/screens/sign_in_screen/otp_screen.dart';
import 'package:lilac_salmankv/presentation/widget/common_widget/common_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: ConstColors.basicColor),
          ),
          CommonWidget().textFormFieldWidget(
              context: context,
              controller: phoneNumberController,
              secure: false,
              labelText: 'Phone Number'),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is OtpVerificationCodeSentState) {
                SmsAutoFill().listenForCode();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return OtpScreen(verificationId: state.verificationId);
                  },
                ));
              }
            },
            builder: (context, state) {
              if (state is OtpSendLoadingState) {
                return const CupertinoActivityIndicator(
                  radius: 20,
                );
              }
              return ElevatedButton(
                  onPressed: () async {
                    if (phoneNumberController.text.isNotEmpty &&
                        phoneNumberController.text.length == 10) {
                      BlocProvider.of<LoginBloc>(context).phoneNumber =
                          phoneNumberController.text;
                      BlocProvider.of<LoginBloc>(context).add(
                          SignInOtpSendEvent(
                              phoneNumber: '+91${phoneNumberController.text}'));
                    } else {
                      SnackBars().errorSnackBar(
                          'Enter 10 digit valid phone number', context);
                    }
                  },
                  child: Text(
                    'Login With Otp',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ConstColors.basicColor),
                  ));
            },
          )
        ],
      ),
    ));
  }
}
