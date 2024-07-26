import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 200.r,
              height: 200.r,
              image: const AssetImage('assets/images/app icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}
