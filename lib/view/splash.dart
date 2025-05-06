import 'package:flutter/material.dart';
import 'package:image_editor_pro/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    splash();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("images/imagepro.png"),
      ),
    );
  }
  Future<void>splash()async{
   await Future.delayed(Duration(seconds: 3));
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  }
}