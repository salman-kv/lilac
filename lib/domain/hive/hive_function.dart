import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lilac_salmankv/domain/hive/hive_model/hive_model.dart';
import 'package:lilac_salmankv/domain/shared_prefrence_fuction/shared_prefrence.dart';

ValueNotifier<List<HiveModel>?> listOfModel =
    ValueNotifier<List<HiveModel>?>(null);

class HiveFunction {
  // insert video and photo to local database
  inserValue(
      {required String photoPath,
      required String videoPath,
      required String photoUrl}) async {
    var box = await Hive.openBox<HiveModel>(SharedPrefrenceFunction.login);
    await box.add(HiveModel(id: photoUrl, map: {photoPath: videoPath}));
  }

// cheching the video is localy stored or not
  checkingTheFileInHive({required String photoUrl}) async {
    var box = await Hive.openBox<HiveModel>(SharedPrefrenceFunction.login);
    for (HiveModel i in box.values) {
      if (i.id == photoUrl) {
        return i;
      }
    }
    return false;
  }
}
