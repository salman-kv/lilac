
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/domain/firebase/firebase_function.dart';
import 'package:lilac_salmankv/domain/shared_prefrence_fuction/shared_prefrence.dart';
import 'package:lilac_salmankv/domain/user_model/user_model.dart';
import 'package:lilac_salmankv/presentation/theme/user_theme.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool passwordObscureText = true;
  String phoneNumber = '';
  UserModel? userModel;
  ThemeData themeData = UserTheme().lightTheme;

  final otpController = TextEditingController();
  LoginBloc() : super(InitialLoginState()) {
    on<OnSwitchTheme>((event, emit){
      if(themeData==UserTheme().lightTheme){
        themeData=UserTheme().darkTheme;
      }else{
        themeData=UserTheme().lightTheme;
      }
      emit(ThemeChangeState());
    });
    on<SplashScreenLoginEvent>((event, emit) async {
      String login = await SharedPrefrenceFunction().userLoginCheck();
      log('$login');
      if (login != '') {
        var val = await FirebaseFirestore.instance
            .collection('user')
            .doc(login)
            .get();
        userModel = UserModel.fromMap(val.data()!);
        emit(SplashScreenUserAlredyLoginedState());
      } else {
        emit(SplashScreenUserNotLoginedState());
      }
    });
    on<ChangePasswordObscureText>((event, emit) {
      passwordObscureText = !passwordObscureText;
      emit(PasswordObscureTextChangeState());
    });
    on<SignInOtpSendEvent>((event, emit) async {
      phoneNumber = event.phoneNumber;
      emit(OtpSendLoadingState());
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {
          log('verification compleated');
        },
        verificationFailed: (error) {
          log('error $error');
        },
        codeSent: (verificationId, forceResendingToken) {
          add(SignInOtpSendedEvent(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log('time out -----------');
        },
        phoneNumber: event.phoneNumber,
      );
    });
    on<SignInOtpSendedEvent>((event, emit) {
      emit(OtpVerificationCodeSentState(verificationId: event.verificationId));
    });
    on<OtpVerificationEvent>((event, emit) async {
      try {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otp);
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        await SharedPrefrenceFunction().userLogin(phoneNumber);
        var val = await FirebaseFirestore.instance
            .collection('user')
            .doc(phoneNumber)
            .get();

        if (val.data() != null) {
          userModel = UserModel.fromMap(val.data()!);
        }

        emit(OtpverificationSuccessState());
      } catch (e) {
        emit(OtpverificationFailedState());
      }
    });
    on<UserDataSettingEvent>((event, emit) async {
      await FirebaseFunction().addProfileToFireBase(userModel: event.userModel);
      userModel = event.userModel;
      emit(UserDataEditedSuccessState());
    });
    on<LogoutEvent>((event, emit) {
      phoneNumber = '';
      userModel = null;
      otpController.clear();
    });
  }
}
