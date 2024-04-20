// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:lilac_salmankv/presentation/const/colors.dart';
// import 'package:lilac_salmankv/presentation/screens/sign_in_screen/sign_in_screen.dart';

// class LoginWidget {
//   static loginText({required BuildContext context}) {
//     return Text(
//       'Login',
//       style: Theme.of(context)
//           .textTheme
//           .titleLarge!
//           .copyWith(color: ConstColors.basicColor, fontSize: 22),
//     );
//   }

//   static signInText({required BuildContext context}) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//           return SignInScreen();
//         },));
//       },
//       child: RichText(
//         text: TextSpan(
//             text: 'Don\'t have an account?',
//             style: Theme.of(context).textTheme.displayMedium,
//             children: <TextSpan>[
//               TextSpan(
//                 text: ' Sign up',
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium!
//                     .copyWith(color: Colors.blue),
//               )
//             ]),
//       ),
//     );
//   }
// }
