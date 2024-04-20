import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lilac_salmankv/domain/shared_prefrence_fuction/shared_prefrence.dart';
import 'package:lilac_salmankv/domain/user_model/user_model.dart';

class FirebaseFunction {
  // Add user data to firebase
  addProfileToFireBase({required UserModel userModel}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(SharedPrefrenceFunction.login)
        .set(userModel.toMap());
  }
}
