import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/chat_bubble.dart';

class FriendChatBubble extends StatelessWidget with ChatBubble{
  final double radius;
  final String massage;
  const FriendChatBubble({super.key,required this.massage,this.radius = 15});
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        SizedBox(width: 3.w,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColors.hellBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: Text(
            massage,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.r,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}