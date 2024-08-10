import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/date.dart';

class DateShowContainer extends StatelessWidget{
  final Date date;
  final double height;
  final double? width;
  final double verticalPadding;
  const DateShowContainer({super.key,required this.date,this.height = 25,this.width,this.verticalPadding = 0});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(height: verticalPadding,),
        Row(
          children: [
            const Spacer(),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.transprantHellBlue,
                borderRadius: BorderRadius.circular(50.r),
              ),
              padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 7.h,bottom: 5.h),
              child: Text(
                date.toString(),
                style: TextStyle(
                  fontFamily: 'impact',
                  fontSize: 12.sp,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: verticalPadding,),
      ],
    );
  }
}