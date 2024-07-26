import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/screens/login_screen.dart';
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return const ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
void main(){
  // check orientation 
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp,
  //   ]
  // );
  runApp(DevicePreview(builder:(context) => const MyApp(),));
  //runApp(const MyApp());
}