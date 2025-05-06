import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:image_editor_pro/service/funtions.dart';
import 'package:image_editor_pro/widgets/class.dart';
import 'package:image_editor_pro/widgets/widgets.dart';
import 'package:screenshot/screenshot.dart';


class TextPage extends StatefulWidget {
  final Uint8List? byteImage;
  final bool? islight;
  const TextPage({required this.byteImage,this.islight ,super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  ScreenshotController scrnController =ScreenshotController();
  List<TextOverlay> overlays = [];
  final TextEditingController _controller=TextEditingController();
  Color selectedColor = Colors.white;
  double fontsize = 24;

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

  void addnewoverlay(){
    if(_controller.text.trim().isEmpty)return;
    setState(() {
      overlays.add(TextOverlay(
        text:_controller.text.trim(),
        position:Offset(100, 100),
        color:selectedColor,
        fontsize:fontsize
      ));
      _controller.clear();
    });
  }
    void colorpicker(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Pick a color"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: selectedColor, onColorChanged: 
          (color) =>setState(() {
            selectedColor = color;
          })
      ),

    ),
    actions: [
      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Done"))
    ],
    )
    );
    
  }
  
  @override
    void initState() {
    islight =widget.islight;
    check();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        iconTheme: IconThemeData(color: txi),
        backgroundColor: bg,
        title: Text("Text",style: TextStyle(color: txi),),
        actions: [
          IconButton(onPressed: ()async{
            final image =await scrnController.capture();
            if(image != null){
              tempStore(image);
              Navigator.pop(context);
            }
          }, icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Screenshot(controller: scrnController,
             child: Stack(
              children: [
                if(widget.byteImage != null)
                  Center(child: Image.memory(widget.byteImage!)),
                  ...overlays.map((overlay){
                    return Positioned(
                      left: overlay.position.dx,
                      top:  overlay.position.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            overlay.position = overlay.position + details.delta;
                          });
                        },
                        child: Text(overlay.text.toString(),style: TextStyle(
                          color: overlay.color,fontSize: overlay.fontsize,fontWeight: FontWeight.bold
                        ),),
                      ));
                  })
              ],
             )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          
                          hintText: "Enter Text",hintStyle: TextStyle(color: txi) ,border: OutlineInputBorder()),
                          style: TextStyle(color: txi),
                      ),
                    ),
                    Gap(5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: conColor,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))
                      ),
                      onPressed: addnewoverlay, child: Text("Add",style: TextStyle(color: txi),))
                  ],
                ),
                Row(
                  children: [
                    texts(tittle: "Size", size: 24,color: txi),
                    Expanded(child: Slider(
                      inactiveColor: txi,
                      max: 72,
                      min: 12,
                      value: fontsize,
                      onChanged: (value)=>setState(() => 
                      fontsize =value
                    ),activeColor: selectedColor,))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    colorpic(color: Colors.red, colorname: Colors.red),
                    colorpic(color: Colors.yellow, colorname: Colors.yellow),
                    colorpic(color: Colors.green, colorname: Colors.green),
                    colorpic(color: Colors.blue, colorname: Colors.blue),
                    IconButton(onPressed: colorpicker, icon: Icon(Icons.color_lens_outlined),iconSize: 35,color: txi,),
                    IconButton(onPressed: (){
                      setState(() {
                        overlays.removeLast();
                      });
                      }, icon: Icon(Icons.undo),iconSize: 35,color: txi,),


                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
   GestureDetector colorpic({
    required Color color,
    required Color colorname

  }) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedColor = colorname;
      }),
      child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle
                            ),
                          ),
    );
  }
}