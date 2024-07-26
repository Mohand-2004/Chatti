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
            // chat image
            Image(
              width: 200.r,
              height: 200.r,
              image: const AssetImage('assets/images/app icon.png'),
            ),

            // space between
            const SizedBox(height: 10,),

            // login text row
            Row(
              children: [
                // left space
                SizedBox(width: 20.w,),

                // login text
                Text(
                  'Login to your Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'impact',
                    fontSize: 30.sp
                  ),
                ),

                // right space
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
