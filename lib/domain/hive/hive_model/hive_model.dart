import 'package:hive_flutter/adapters.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  Map<String, String> map;
  HiveModel({required this.id, required this.map});
}
