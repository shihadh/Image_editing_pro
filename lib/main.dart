import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_editor_pro/model/appmodels.dart';
import 'package:image_editor_pro/view/splash.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AppmodelsAdapter());
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}