import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';

class SuccessAlert extends StatelessWidget{
  final void Function() automaticCommand;
  final void Function() backCommand;
  final void Function() cancelCommand;
  const SuccessAlert({super.key,required this.backCommand,required this.automaticCommand,required this.cancelCommand});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      width: 300.dm,
      height: 200.dm,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.hellBlue,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Column(
          children: [
            SizedBox(height: 8.h,),
            Image(
              width: 70.r,
              height: 70.r,
              image: const AssetImage('assets/images/صح.png')
            ),
            SizedBox(height: 8.h,),
            Text(
              'your account have been created',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'impact',
              ),
            ),

            SizedBox(height: 15.h,),
            Row(
              children: [
                SizedBox(width: 30.w,),
                GestureDetector(
                  onTap: automaticCommand,
                  child: Text(
                    'Login Automatically',
                      style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              children: [
                SizedBox(width: 30.w,),
                GestureDetector(
                  onTap: backCommand,
                  child: Text(
                    'Back to Login page',
                      style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              children: [
                SizedBox(width: 30.w,),
                GestureDetector(
                  onTap: cancelCommand,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
