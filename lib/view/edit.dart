import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_editor_pro/model/appmodels.dart';
import 'package:image_editor_pro/service/funtions.dart';
import 'package:image_editor_pro/view/draw.dart';
import 'package:image_editor_pro/view/text.dart';
import 'package:image_editor_pro/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';

class EditPage extends StatefulWidget {
  final File? image;
  final Uint8List? byteImage;
  final bool? islight;
  const EditPage({this.image,this.byteImage,this.islight,super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Uint8List? byteImage;
  Uint8List?  currentImage;
  bool? islight;
  Color bg=Colors.black;
  Color txi = Colors.white;
  Color conColor = Color(0xFF1A1A1A);

  void check(){
    if(islight==false){
        bg=Colors.black;
        txi = Colors.white;
        conColor = Color(0xFF1A1A1A);
    }else{
       txi=Colors.black;
       bg= Colors.white;
       conColor = Color(0xFFEFEFEF);
    }
  }
  @override
  void initState() {
    islight =widget.islight;
    check();
    if(widget.byteImage != null){
      currentImage=widget.byteImage!;
    }else if(widget.image != null){
      currentImage = widget.image!.readAsBytesSync();
    }
    
    super.initState();
  }

  Future<void> cropingImage() async {
    if (currentImage == null) return;
    final tempdr = await getTemporaryDirectory();
    final tempfile = await File('${tempdr.path}/temp_image.png').create();
    await tempfile.writeAsBytes(currentImage!);
    CroppedFile? croppedimage = await ImageCropper().cropImage(
      sourcePath: tempfile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarWidgetColor: Colors.white,
          toolbarColor: Color(0xFF1A1A1A),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,

        ),
        IOSUiSettings(title: "crop"),
      ],
    );
    if (croppedimage != null) {
      final croppedFile = File(croppedimage.path);
      setState(() {
        currentImage = croppedFile.readAsBytesSync();
        
      });
    }
  }

  Future<void> drowing()async{

    await  Navigator.push(context, MaterialPageRoute(
      builder: (context) => DrawPage(byteImage: currentImage,islight: islight,)));
      final db =await Hive.openBox("db");
      final Uint8List? tpsaved =db.get("tempimage");
      if(tpsaved != null){
        setState(() {
          currentImage = tpsaved;
        });
      }
      await db.delete("tempimage");
  }

  Future<void> addText() async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TextPage(byteImage: currentImage,islight: islight,),
    ),
  );

  final db = await Hive.openBox("db");
  final Uint8List? updated = db.get("tempimage");
  if (updated != null) {
    setState(() {
      currentImage = updated;
    });
    await db.delete("tempimage");
  }
}

void save(){
  DateTime now = DateTime.now();
  String date ="Date: ${now.day}-${now.month}-${now.year}";
  String time = "Time: ${now.hour}:${now.minute}";
  final newsave =Appmodels(image: currentImage, date: date, time: time);
  addresult(newsave);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        iconTheme: IconThemeData(color: txi),
        backgroundColor: bg,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(  child: currentImage != null
                    ? Image.memory(currentImage!)
                        : null,),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: conColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          toolBar(
                            color: txi,
                            icon: Icons.crop_outlined,
                            icname: "Crop",
                            funtion: cropingImage,
                          ),
                          toolBar(
                            color: txi,
                            icon: Icons.edit_outlined,
                            icname: "Draw",
                            funtion: drowing
                          ),
                          toolBar(
                            color: txi,
                            icon: Icons.text_fields_outlined,
                            icname: "Text",
                            funtion: addText,
                          ),
                          toolBar(
                            color: txi,
                            icon: Icons.save_alt_rounded,
                            icname: "Save",
                            funtion: () {
                                if (currentImage != null) {
                                  save();
                                  saveImageToGallery(context, currentImage!);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text("Image is saved to gallery")));
                                  Navigator.pop(context);
                                } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text("Failed to save image")));
                                }
                              },

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
