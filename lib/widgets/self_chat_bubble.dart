import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/chat_bubble.dart';
import 'package:my_app/models/massage.dart';

class SelfChatBubble extends StatelessWidget with ChatBubble{
  final double radius;
  final Massage massage;
  const SelfChatBubble({super.key,required this.massage,this.radius = 15});
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const Spacer(),
        Container(
          padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 20.h,bottom: 10.h),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                coreController.formteMassage(massage.content),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.r,
                ),
              ),
              Text(
                '${(coreController.mediaQuery!.alwaysUse24HourFormat ? massage.time : massage.time.to12Mode())}',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.r,
                  fontFamily: 'impact',
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 3.w,)
      ],
    );
  }
}