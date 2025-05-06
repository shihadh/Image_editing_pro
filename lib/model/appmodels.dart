import 'dart:typed_data';
import 'package:hive_flutter/adapters.dart';
part 'appmodels.g.dart';

@HiveType(typeId: 0)
class Appmodels {
  
  @HiveField(0)
  Uint8List? image;

  @HiveField(1)
  String? date;

  @HiveField(2)
  String? time;

  Appmodels({
    required this.image,
    required this.date,
    required this.time
  });
}