import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:image_editor_pro/service/funtions.dart';
import 'package:image_editor_pro/widgets/class.dart';
import 'package:screenshot/screenshot.dart';
 
class DrawPage extends StatefulWidget {
  final File? fileImage;
  final Uint8List? byteImage;
  final bool? islight;
  const DrawPage({this.fileImage,this.byteImage,this.islight,super.key});

  @override
  State<DrawPage> createState() => _DrawPageState();
}


class _DrawPageState extends State<DrawPage> {
  ScreenshotController screenshot =ScreenshotController();
  List<Drawpoint?>points=[];
  final GlobalKey _imageKey = GlobalKey();
  Color selectedColor = Colors.white;

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
    Widget? imagewidget;
    if(widget.byteImage != null){
      imagewidget =Image.memory(widget.byteImage!);
    }else if(widget.fileImage !=null){
      imagewidget = Image.file(widget.fileImage!);
    }
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: Text("Draw",style: TextStyle(color: txi),),
        iconTheme: IconThemeData(color: txi,),
        actions: [
          IconButton(onPressed: colorpicker, icon: Icon(Icons.color_lens_outlined)),
          IconButton(onPressed: ()async{
            final image =await screenshot.capture();
            if(image != null){
              tempStore(image);
              Navigator.pop(context);
            }
          }, icon: Icon(Icons.check)),

        ],
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Screenshot(
            controller: screenshot,
            child: Stack(
              children: [
                if (imagewidget != null)
          Container(
            key: _imageKey,
            child: imagewidget,
          ),
                if (imagewidget != null)
          Positioned.fill(
            child: GestureDetector(
              onPanUpdate: (details) {
                RenderBox box = _imageKey.currentContext?.findRenderObject() as RenderBox;
                Offset imageOffset = box.localToGlobal(Offset.zero);
                Offset localPosition = details.globalPosition - imageOffset;
          
                Size imageSize = box.size;
          
                if (localPosition.dx >= 0 &&
                    localPosition.dy >= 0 &&
                    localPosition.dx <= imageSize.width &&
                    localPosition.dy <= imageSize.height) {
                  setState(() {
                    points.add(Drawpoint(localPosition, selectedColor));
                  });
                }
              },
              onPanEnd: (_) => points.add(null),
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: MyPainter(points),
                ),
              ),
            ),
          ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 100,
                 
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          colorpic(color: Colors.red,colorname: Colors.red),
                          colorpic(color: Colors.yellow,colorname: Colors.yellow),
                          colorpic(color: Colors.green,colorname: Colors.green),
                          colorpic(color: Colors.blue,colorname:Colors.blue ),
                          colorpic(color: Colors.orange,colorname: Colors.orange),
                          colorpic(color: Colors.purple,colorname: Colors.purple),
                        ],
                      ),
                      Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: conColor),
                            onPressed: (){
                              setState(() {
                                points.clear();
                              });
                            }, child: Text("Clear",style: TextStyle(color: txi,))),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: conColor ),
                            onPressed: (){
                              setState(() {
                                points.removeLast();
                              });
                            }, child: Text("Undu",style: TextStyle(color: txi,)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
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

