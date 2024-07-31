import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/screens/signup_screen.dart';
import 'package:my_app/widgets/entry.dart';
import 'package:my_app/widgets/input_password_entry.dart';
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // chat image
              Image(
                width: 200.r,
                height: 200.r,
                image: const AssetImage('assets/images/app icon.png'),
              ),
        
              // space between
              const SizedBox(height: 10,),
        
              // login text row
              Row(
                children: [
                  // left space
                  SizedBox(width: 20.w,),
        
                  // login text
                  Text(
                    'Login to your Account',
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
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 8.h),
                height: 250.r,
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
                        controller: usernameController,
                      ),
                    ),
        
                    // space between
                    SizedBox(height: 15.h,),
        
                    // password feild
                    Expanded(
                      child: InputPasswordEntry(
                        hinttext: 'password',
                        icon: Icons.lock,
                        controller: passwordController,
                      ),
                    ),
        
                    // bottom space
                    SizedBox(height: 15.h,),
                  ],
                ),
              ),
        
              // login button row
              Row(
                children: [
                  // right space
                  const Spacer(),
        
                  // login button
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      fixedSize: Size(80.w+20,40.h),
                    ),
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.r
                      ),
                    ),
                  ),
        
                  // left space
                  SizedBox(width: 15.w,),
                ],
              ),
        
              // divider
              Divider(
                indent: 50.w,
                endIndent: 50.w,
                color: Colors.grey,
                thickness: 2.h,
                height: 50.h,
              ),
        
              // signup section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // don't have an account text
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black
                    ),
                  ),
        
                  // signUp text buttton
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return SignupScreen();
                          }, 
                        )
                      );
                    },
                    child: Text(
                      '\t\tSignUp',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.orange
                      ),
                    ),
                  )
                ],
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
