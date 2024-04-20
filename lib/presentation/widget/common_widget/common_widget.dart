import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';

class CommonWidget {
  textFormFieldWidget(
      {required BuildContext context,
      required String labelText,
      required TextEditingController controller,
      required bool secure,
      bool visible = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          validator: (value) {
            if (value == null || value == '') {
              return 'invalid';
            } else {
              return null;
            }
          },
          obscureText: visible,
          controller: controller,
          decoration: InputDecoration(
            suffix: secure
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<LoginBloc>()
                          .add(ChangePasswordObscureText());
                    },
                    child: visible
                        ? const FaIcon(FontAwesomeIcons.eyeSlash)
                        : const FaIcon(FontAwesomeIcons.eye))
                : null,
            border: InputBorder.none,
            fillColor: const Color.fromARGB(255, 242, 242, 242),
            filled: true,
            labelText: labelText,
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 111, 111, 111), fontSize: 16),
          ),
          style: TextStyle(
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
