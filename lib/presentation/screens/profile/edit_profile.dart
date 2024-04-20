import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_bloc.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_event.dart';
import 'package:lilac_salmankv/application/bloc/login_bloc/login_state.dart';
import 'package:lilac_salmankv/domain/user_model/user_model.dart';
import 'package:lilac_salmankv/presentation/const/colors.dart';
import 'package:lilac_salmankv/presentation/style/style.dart';
import 'package:lilac_salmankv/presentation/widget/common_widget/common_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  String? image;
  @override
  void initState() {
    image = BlocProvider.of<LoginBloc>(context).userModel?.image;
    nameController.text =
        BlocProvider.of<LoginBloc>(context).userModel?.name ?? '';
    emailController.text =
        BlocProvider.of<LoginBloc>(context).userModel?.email ?? '';
    dobController.text =
        BlocProvider.of<LoginBloc>(context).userModel?.dob ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is UserDataEditedSuccessState) {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    onImagepicking();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset('assets/images/profile.png'),
                      ),
                    ],
                  ),
                ),
                CommonWidget().textFormFieldWidget(
                    context: context,
                    labelText: 'Name',
                    controller: nameController,
                    secure: false),
                CommonWidget().textFormFieldWidget(
                    context: context,
                    labelText: 'email',
                    controller: emailController,
                    secure: false),
                CommonWidget().textFormFieldWidget(
                    context: context,
                    labelText: 'dob',
                    controller: dobController,
                    secure: false),
                ElevatedButton(
                    style: Style().elevatedButtonStyle(),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(
                          UserDataSettingEvent(
                            userModel: UserModel(
                                name: nameController.text,
                                image: image!,
                                dob: dobController.text,
                                email: emailController.text,
                                password: ''),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'submit',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ConstColors.basicColor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  onImagepicking() async {
    XFile? val = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (val != null) {
      final ref = FirebaseStorage.instance.ref('image').child(val.name);
      await ref.putFile(File(val.path));
      final imageUrl = await ref.getDownloadURL();
      image = imageUrl;
    }
    setState(() {});
  }
}
