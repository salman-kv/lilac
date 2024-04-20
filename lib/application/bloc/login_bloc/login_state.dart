abstract class LoginState{}

class InitialLoginState extends LoginState{}
class SplashScreenUserAlredyLoginedState extends LoginState{}
class LoginLoadingState extends LoginState{}
class SplashScreenUserNotLoginedState extends LoginState{}
class PasswordObscureTextChangeState extends LoginState{}
class OtpSendLoadingState extends LoginState{}
class OtpVerificationCodeSentState extends LoginState{
  final String verificationId;

  OtpVerificationCodeSentState({required this.verificationId});
}
class OtpverificationSuccessState extends LoginState{}
class OtpverificationFailedState extends LoginState{}
class UserDataEditedSuccessState extends LoginState{}
class TimerState extends LoginState{}
class OtpResentState extends LoginState{}
class ThemeChangeState extends LoginState{}