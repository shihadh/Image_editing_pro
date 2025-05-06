
import 'package:flutter/material.dart';


class Drawpoint{
  final Offset offset;
  final Color color;
  Drawpoint(this.offset,this.color);
}

class MyPainter extends CustomPainter{
   List<Drawpoint?>points=[];
  
  MyPainter(this.points);
  @override
  void paint(Canvas canvas,Size size){
    for(int i=0;i<points.length-1;i++){
      final current = points[i];
      final next= points[i+1];
      if(current != null && next != null){
        final paint =Paint()
          ..color = current.color
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(current.offset, next.offset, paint);
      }
    }
  }
  @override
  bool shouldRepaint(MyPainter oldDelegate)=>true;
}


class TextOverlay {
  String text;
  Offset position;
  Color color;
  double fontsize;
  TextOverlay({
    required this.text,required this.position,required this.color,required this.fontsize 
  });

}
