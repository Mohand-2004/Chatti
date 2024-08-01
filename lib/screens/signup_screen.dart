import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Check_password.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/widgets/create_password_entry.dart';
import 'dart:io' show Platform;
import 'package:my_app/widgets/entry.dart';
import 'package:my_app/widgets/input_password_entry.dart';
// ignore: must_be_immutable
class SignupScreen extends StatelessWidget{
  GlobalKey<FormState> signUpValidationsKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  SignupScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.89,
          child: Column(
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
                height: 290.h,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: signUpValidationsKey,
                  child: Column(
                    children: [
                      // top space
                      SizedBox(height: 15.h,),
                            
                      // user name feild
                      Expanded(
                        child: Entry(
                          validations: (value){
                            if(value == null || value == ''){
                              return 'Email feild is required';
                            }
                            return null;
                          },
                          hinttext: 'Email',
                          icon: Icons.person,
                          controller: emailController,
                        ),
                      ),
                            
                      // space between
                      SizedBox(height: 15.h,),
                            
                      // password feild
                      Expanded(
                        child: CreatePasswordEntry(
                          validations: (value){
                            if(value == null || value == ''){
                              return 'Password feild is required';
                            }
                            else if(stronglevel(value) == 'weak' || stronglevel(value) == 'medium'){
                              return 'You must create a strong password';
                            }
                            else if(value.length < 8){
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          hinttext: 'password',
                          icon: Icons.lock,
                          controller: passwordController,
                        ),
                      ),
                            
                      // space between
                      SizedBox(height: 15.h,),
                            
                      // confirm password feild
                      Expanded(
                        child: InputPasswordEntry(
                          hinttext: 'confirm password',
                          icon: Icons.lock_reset_rounded,
                          controller: confirmpasswordController,
                        ),
                      ),
                            
                      // bottom space
                      SizedBox(height: 15.h,),
                    ],
                  ),
                ),
              ),
          
              // signUp button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ElevatedButton(
                  onPressed: (){
                    if(signUpValidationsKey.currentState!.validate()){
                      print(emailController.text);
                    }
                  },
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
          ),
        ),
      )
    );
  }
}
