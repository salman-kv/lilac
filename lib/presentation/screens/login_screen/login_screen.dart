// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
// import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
// import 'package:lilac_salmankv/presentation/screens/login_screen/widget.dart';
// import 'package:lilac_salmankv/presentation/widget/common_widget/common_widget.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             LoginWidget.loginText(context: context), 
//             CommonWidget().textFormFieldWidget(
//                 context: context,
//                 controller: phoneNumberController,
//                 secure: false,
//                 labelText: 'Phone Number'),
//             BlocBuilder<LoginBloc, LoginState>(
//               builder: (context, state) {
//                 log('emitting');
//                 return CommonWidget().textFormFieldWidget(
//                   context: context,
//                   controller: passwordController,
//                   secure: true,
//                   visible:
//                       BlocProvider.of<LoginBloc>(context).passwordObscureText,
//                   labelText: 'Password',
//                 );
//               },
//             ),
//             LoginWidget.signInText(context: context)
//           ],
//         )),
//       ),
//     );
//   }
// }
