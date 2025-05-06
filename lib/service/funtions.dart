import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_editor_pro/model/appmodels.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';

ValueNotifier<List<Appmodels>> editList =ValueNotifier([]);

Future<void>tempStore(Uint8List tpimage)async{
  final db = await Hive.openBox("db");
  db.put("tempimage", tpimage);
}

Future<void>addresult(Appmodels value)async{
  final db= await Hive.openBox<Appmodels>("db2");
  db.add(value);
  getresult();
}

Future<void>getresult()async{
  final db=await Hive.openBox<Appmodels>("db2");
  editList.value.clear();
  editList.value.addAll(db.values);
  editList.notifyListeners();
}

Future<void>delete(int index)async{
  final db= await Hive.openBox<Appmodels>("db2");
  db.deleteAt(index);
  getresult();
}


Future<bool> permissionRequest()async{
  final status =await [Permission.storage,Permission.photos].request();
  return status[Permission.storage]!.isGranted || status[Permission.photos]!.isGranted;
}

Future<void> saveImageToGallery(BuildContext context, Uint8List imageBytes) async {
  bool granted = await permissionRequest();
  if (!granted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Permission not granted")));
    return;
  }
  final result = await ImageGallerySaverPlus.saveImage(imageBytes, quality: 100, name: "editing_image_${DateTime.now()}");
  if (result['isSuccess']) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text("Image is saved to gallery")));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Failed to save image")));
  }
}
