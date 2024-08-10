import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/widgets/adaptive_loading_indicator.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 80.r,
              height: 80.r,
              image: const AssetImage('assets/images/app icon.png'),
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                const Spacer(),
                Text(
                  'DataBase init',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'impact',
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 15.w,),
                const AdaptiveLoadingIndicator(
                  color: Colors.grey,
                  androidSize: 15,
                  androidWidth: 3,
                  iOSsize: 10,
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}