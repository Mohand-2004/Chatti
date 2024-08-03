import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';

class LogoutConfirmAlert extends StatelessWidget{
  final void Function() yesCommand;
  final void Function() noCommand;
  const LogoutConfirmAlert({super.key,required this.yesCommand,required this.noCommand});
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
            SizedBox(height: 10.h,),
            Image(
              width: 85.r,
              height: 85.r,
              image: const AssetImage('assets/images/error.png'),
            ),
            SizedBox(height: 10.w,),
            Text(
              'LogOut ?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontFamily: 'impact',
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: yesCommand,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    fixedSize: Size(120.w,35.h)
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                ElevatedButton(
                  onPressed: noCommand,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    fixedSize: Size(120.w,35.h)
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        )
      ),
    );
  }
}
