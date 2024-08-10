import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/mixins.dart';
import 'package:my_app/widgets/android_massaging_text_feild.dart';

class IOSMassagingTextFeild extends StatefulWidget with MassageingTextFeild{
  final double height;
  final double width;
  final void Function(String massage) submitCommand;
  const IOSMassagingTextFeild({super.key,required this.submitCommand,this.height = 120,this.width = double.infinity});
  @override
  State<IOSMassagingTextFeild> createState() => _IOSMassagingTextFeildState();
}

class _IOSMassagingTextFeildState extends State<IOSMassagingTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: AppColors.iOSmassagingFeild,
      ),
      child: AndroidMassagingTextFeild(
        height: 45.h,
        radius: 50.r,
        padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 12.h),
        submitCommand: widget.submitCommand,
      ),
    );
  }
}