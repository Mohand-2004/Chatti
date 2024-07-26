import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'dart:io' show Platform;

import 'package:my_app/widgets/entry.dart';
import 'package:my_app/widgets/input_password_entry.dart';
class SignupScreen extends StatelessWidget{
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height*0.07,
        ),
        child: Expanded(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 30.h,left: Platform.isIOS ? 10.w : 7.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      size: 27.r,
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: const Color.fromARGB(255, 123, 123, 123),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // chat image
          Image(
            width: 200.r,
            height: 200.r,
            image: const AssetImage('assets/images/app icon.png'),
          ),

          // space between
          const SizedBox(height: 10,),

          // signup text row
          Row(
            children: [
              // left space
              SizedBox(width: 20.w,),

              // signup text
              Text(
                'Create a new Account',
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

          // space between
          const SizedBox(height: 10,),

          // text field space
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 8.h),
            height: 300.h,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // top space
                SizedBox(height: 15.h,),

                // user name feild
                Expanded(
                  child: Entry(
                    hinttext: 'user name',
                    icon: Icons.person,
                    controller: TextEditingController(),
                  ),
                ),

                // space between
                SizedBox(height: 15.h,),

                // password feild
                Expanded(
                  child: InputPasswordEntry(
                    hinttext: 'password',
                    icon: Icons.lock,
                    controller: TextEditingController(),
                  ),
                ),

                // space between
                SizedBox(height: 15.h,),

                // confirm password feild
                Expanded(
                  child: InputPasswordEntry(
                    hinttext: 'confirm password',
                    icon: Icons.lock_reset_rounded,
                    controller: TextEditingController(),
                  ),
                ),

                // bottom space
                SizedBox(height: 15.h,),
              ],
            ),
          ),

          // signUp button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                fixedSize: Size(MediaQuery.of(context).size.width,40.h),
              ),
              child: Text(
                'SignUp',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.r
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
