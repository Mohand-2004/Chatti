import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/cubits/login%20auth%20cubit/login_auth_cubit.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/screens/home_page.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    coreController.mediaQuery = MediaQuery.of(context);
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) => coreController.loginAuthCubit,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<LoginAuthCubit,LoginState>(
            builder: (context,state){
              if(state is LoginSuccessState){
                return HomePage(
                  user: coreController.loginAuthCubit.currentUser!,
                  firebaseFrirnds: state.chats,
                );
              }
              else if(state is LoginSplashState){
                return const SplashScreen();
              }
              else{
                return const LoginScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}

void main() async {
  // check orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //runApp(DevicePreview(builder:(context) => const MyApp(),));
  runApp(const MyApp());
}
