import 'package:flutter/material.dart';

Text texts({required String tittle, required double size, required Color color}) => Text(
  tittle,
  style: TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.bold,
  ),
);


Column toolBar({required icon, required String icname, required funtion,required Color color}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: funtion,
        icon: Icon(icon, size: 40, color: color),
      ),
      texts(tittle: icname, size: 20,color: color),
    ],
  );
}

