import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_editor_pro/view/edit.dart';
import 'package:image_editor_pro/view/history.dart';
import 'package:image_editor_pro/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  bool islight = false;
  Color bg=Colors.black;
  Color txi = Colors.white;
  Color conColor = Color(0xFF1A1A1A);
  Future<void>imagepicker()async{
  final pic= await ImagePicker().pickImage(source:ImageSource.gallery);
  if(pic != null){
      image =File(pic.path);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(image: image!,islight: islight,),));
  }
}

  Future<void>cameraimage()async{
    final cam = await ImagePicker().pickImage(source: ImageSource.camera);
    if(cam !=null){
        image=File(cam.path);
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(image: image!,islight: islight,),));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(child: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(islight: islight,),));
                  }, icon: Icon(Icons.history,color: txi,)),
                  texts(tittle: "Pick Image",size: 23,color: txi),
                  IconButton(onPressed: (){
                    setState(() {
                        if(islight==true){
                          islight =false;
                             bg=Colors.black;
                             txi = Colors.white;
                             conColor = Color(0xFF1A1A1A);
                            }else{
                              islight =true;
                              bg=Colors.white;
                              txi = Colors.black;
                              conColor = Color(0xFFEFEFEF);
                              
  }
                    });
                  }, icon: Icon(
                    islight ==false ? Icons.light_mode_outlined :Icons.dark_mode_outlined, color: !islight ? Colors.white : Colors.black,))
                ],
              ),
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: conColor,
                ),
                child: Icon(
                  size: 90,
                  color: txi,
                  Icons.camera_alt),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(10, 50),
                              backgroundColor: conColor,shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            onPressed: imagepicker, child: texts(tittle: "Pic image", size: 20,color: txi)),
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(10, 50),
                              backgroundColor: conColor,shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            onPressed: cameraimage, child: texts(tittle: "Take photo", size: 20,color: txi))),
                      ],
                    ),
                    Gap(40)
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

}