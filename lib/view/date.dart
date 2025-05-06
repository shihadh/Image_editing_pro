import 'package:flutter/material.dart';

class Date extends StatefulWidget {
  const Date({super.key});

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  String te ="hai";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(te),
            ElevatedButton(onPressed: (){setState(() {
              DateTime now =DateTime.now();
              te="${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}";
            });}, child: Text("data")),
          ],
        ),
      ),
    );
  }
}