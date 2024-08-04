import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/user.dart';

class FreindChat extends StatelessWidget{
  final AppUser user;
  final double width;
  final double height;
  final double imageBorderWidth;
  final double imageRadius;
  const FreindChat({super.key,required this.user,this.height = 120,this.width = double.infinity,this.imageBorderWidth = 2,this.imageRadius = 32});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: CircleAvatar(
                  backgroundColor: AppColors.hellBlue,
                  radius: imageRadius.r,
                  child: Padding(
                    padding: EdgeInsets.all(imageBorderWidth.r),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
                      radius: imageRadius.r,
                    ),
                  ),
                ),
              ),
          
              SizedBox(width: 10.w,),
          
              Text(
                user.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.r,
                ),
              )
            ],
          ),
          SizedBox(height: 5.h,),
          Divider(
            endIndent: 50.w,
            indent: 50.w,
            thickness: 2.r,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}