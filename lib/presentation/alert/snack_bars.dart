import 'package:flutter/material.dart';

class SnackBars {
  errorSnackBar(String errorSnackBarMessage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(20),
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 1, strokeAlign: 2),
        ),
        backgroundColor: Colors.red,
        content: Text(
          errorSnackBarMessage,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  successSnackBar(String successSnackBarMessage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(20),
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 1, strokeAlign: 2),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 81, 23),
        content: Text(
          successSnackBarMessage,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
