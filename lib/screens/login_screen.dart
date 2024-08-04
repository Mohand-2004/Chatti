import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/cubits/auth%20cubit/signup_auth_cubit.dart';
import 'package:my_app/cubits/login%20auth%20cubit/login_auth_cubit.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/screens/signup_screen.dart';
import 'package:my_app/widgets/adaptive_loading_indicator.dart';
import 'package:my_app/widgets/entry.dart';
import 'package:my_app/widgets/input_password_entry.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
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
                    const SizedBox(
                      height: 10,
                    ),
      
                    // login text row
                    Row(
                      children: [
                        // left space
                        SizedBox(
                          width: 20.w,
                        ),
      
                        // login text
                        Text(
                          'Login to your Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'impact',
                            fontSize: 30.sp,
                          ),
                        ),
      
                        // right space
                        const Spacer(),
                      ],
                    ),
      
                    // space between
                    const SizedBox(
                      height: 10,
                    ),
      
                    // text field space
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                      height: 250.r,
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        key: coreController.loginValidationsKey,
                        child: BlocBuilder<LoginAuthCubit,LoginState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                // top space
                                SizedBox(
                                  height: 15.h,
                                ),
      
                                // user name feild
                                Expanded(
                                  child: Entry(
                                    errorTextSize: (state is WrongEmailOrPasswordState ? 15 : 17),
                                    errortext: (state is WrongEmailOrPasswordState ? state.text : null),
                                    validations: (string) {
                                      if (string == null || string == '') {
                                        return 'Email feild is required';
                                      }
                                      else if (!coreController.isValidEmail(string)) {
                                        return 'Email is not valid';
                                      }
                                      return null;
                                    },
                                    hinttext: 'Email',
                                    icon: Icons.email_rounded,
                                    controller: coreController.emailLoginController,
                                  ),
                                ),
      
                                // space between
                                SizedBox(
                                  height: 15.h,
                                ),
      
                                // password feild
                                Expanded(
                                  child: InputPasswordEntry(
                                    errorTextSize:
                                        (state is WrongEmailOrPasswordState ? 15 : 17),
                                    errortext:
                                        (state is WrongEmailOrPasswordState ? state.text : null),
                                    validations: (value) {
                                      if (value == null || value == '') {
                                        return 'password feild is required';
                                      }
                                      return null;
                                    },
                                    hinttext: 'password',
                                    icon: Icons.lock,
                                    controller: coreController.passwordLoginController,
                                  ),
                                ),
      
                                // bottom space
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
      
                    // login button row
                    Row(
                      children: [
                        // right space
                        const Spacer(),
      
                        // login button
                        ElevatedButton(
                          onPressed: () {
                            coreController.loginValidationsKey.currentState!.validate();
                            if (coreController.emailLoginController.text != '' && coreController.passwordLoginController.text != '' && coreController.isValidEmail(coreController.emailLoginController.text)) {
                              coreController.login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange,
                            fixedSize: Size(80.w + 20, 40.h),
                          ),
                          child: Text(
                            'login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.r,
                            ),
                          ),
                        ),
      
                        // left space
                        SizedBox(
                          width: 15.w,
                        ),
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
                            color: Colors.black,
                          ),
                        ),
      
                        // signUp text buttton
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const SignupScreen();
                              },
                            ));
      
                            // reset signup cubit to avoid emit after cloasing exception
                            coreController.signUpAuthCubit = SignUpAuthCubit();
                          },
                          child: Text(
                            '\t\tSignUp',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.orange,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      
          // loading indicator
          BlocBuilder<LoginAuthCubit,LoginState>(
            builder: (context,state) {
              if(state is LoginLoadingState){
                return Container(
                  color: AppColors.transprantHellBlue,
                  child: Center(
                    child: AdaptiveLoadingIndicator(
                      androidWidth: 5.r,
                      androidSize: 60,
                      iOSsize: 25,
                      color: AppColors.orange,
                    ),
                  ),
                );
              }
              else{
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
