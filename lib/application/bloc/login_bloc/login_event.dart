import 'package:lilac_salmankv/domain/user_model/user_model.dart';

abstract class LoginEvent{}

class SplashScreenLoginEvent extends LoginEvent{}
class ChangePasswordObscureText extends LoginEvent{}
class SignInOtpSendEvent extends LoginEvent{
  final String phoneNumber;

  SignInOtpSendEvent({required this.phoneNumber});
}
class SignInOtpSendedEvent extends LoginEvent{
  final String verificationId;

  SignInOtpSendedEvent({required this.verificationId});
}
class OtpVerificationEvent extends LoginEvent{
  final String otp;
  final String verificationId;

  OtpVerificationEvent({required this.otp, required this.verificationId});
}

class UserDataSettingEvent extends LoginEvent{
  final UserModel userModel;

  UserDataSettingEvent({required this.userModel});
}

class LogoutEvent extends LoginEvent{
}

class OnSwitchTheme extends LoginEvent{}