import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/cubits/auth%20cubit/signup_auth_cubit.dart';
import 'package:my_app/cubits/auth%20cubit/states.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/widgets/adaptive_loading_indicator.dart';
import 'package:my_app/widgets/create_password_entry.dart';
import 'package:my_app/widgets/entry.dart';
import 'package:my_app/widgets/input_password_entry.dart';
import 'dart:io' show Platform;

import 'package:my_app/widgets/success_alert.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => coreController.signUpAuthCubit,
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                coreController.signUpAuthCubit.reset();
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.07,
                  ),
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h, left: Platform.isIOS ? 10.w : 7.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
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
                body: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Column(
                      children: [
                        // chat image
                        Image(
                          width: 160.r, // 200
                          height: 160.r, // 200
                          image: const AssetImage('assets/images/app icon.png'),
                        ),
              
                        // space between
                        const SizedBox(
                          height: 10,
                        ),
              
                        // signup text row
                        Row(
                          children: [
                            // left space
                            SizedBox(
                              width: 20.w,
                            ),
              
                            // signup text
                            Text(
                              'Create a new Account',
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
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                          height: (
                            (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) <= 1.79 ? 
                            (MediaQuery.of(context).size.width > 500 ? (Platform.isIOS ? 330.h : 335.h) : (Platform.isIOS ? 315.h : 330.h)) 
                            : (Platform.isIOS ? 350.h : 365.h)
                          ), // 290
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: coreController.signUpValidationsKey,
                            child: Column(
                              children: [
                                // top space
                                SizedBox(
                                  height: 10.h,
                                ),
              
                                // user name feild
                                Expanded(
                                  child: BlocBuilder<SignUpAuthCubit, AuthState>(
                                    builder: (context, state) {
                                      return Entry(
                                        errorTextSize: (state is UsedEmailState? 12 : null),
                                        errortext: state.text,
                                        validations: (value) {
                                          if (value == null || value == ''){
                                            return 'Email feild is required';
                                          }
                                          else if (!coreController.isValidEmail(value)){
                                            return 'Email is not valid';
                                          }
                                          return null;
                                        },
                                        hinttext: 'Email',
                                        icon: Icons.email,
                                        controller: coreController.emailSignController,
                                      );
                                    },
                                  ),
                                ),

                                // space between
                                SizedBox(
                                  height: 10.h,
                                ),

                                Expanded(
                                  child: Entry(
                                    validations: (value) {
                                      if (value == null || value == ''){
                                        return 'Name feild is required';
                                      }
                                      return null;
                                    },
                                    hinttext: 'name',
                                    icon: Icons.person,
                                    controller: coreController.nameSignController,
                                  ),
                                ),
              
                                // space between
                                SizedBox(
                                  height: 10.h,
                                ),
              
                                // password feild
                                Expanded(
                                  child: CreatePasswordEntry(
                                    validations: (value) {
                                      if (value == null || value == '') {
                                        return 'Password feild is required';
                                      } else if (coreController.stronglevel(value) == 'weak' || coreController.stronglevel(value) == 'medium'){
                                        return 'You must create a strong password';
                                      }
                                      else if (value.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      }
                                      return null;
                                    },
                                    hinttext: 'password',
                                    icon: Icons.lock,
                                    controller: coreController.passwordSignController,
                                  ),
                                ),
              
                                // space between
                                SizedBox(
                                  height: 10.h,
                                ),
              
                                // confirm password feild
                                Expanded(
                                  child: InputPasswordEntry(
                                    validations: (value) {
                                      if (coreController.passwordSignValidate() && coreController.emailSignController.text != '' && !coreController.matchPasswordsValidate() && coreController.nameSignController.text != ''){
                                        return "Passwords don't match";
                                      }
                                      return null;
                                    },
                                    hinttext: 'confirm password',
                                    icon: Icons.lock_reset_rounded,
                                    controller: coreController.confirmpasswordController,
                                  ),
                                ),
              
                                // bottom space
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
              
                        // signUp button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: ElevatedButton(
                            onPressed: () {
                              coreController.signUpValidationsKey.currentState!.validate();
                              if (coreController.passwordSignValidate() && coreController.emailSignController.text != '' && coreController.matchPasswordsValidate() && coreController.isValidEmail(coreController.emailSignController.text)) {
                                coreController.signUp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orange,
                              fixedSize: Size(MediaQuery.of(context).size.width, 40.h),
                            ),
                            child: BlocBuilder<SignUpAuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return const AdaptiveLoadingIndicator();
                                } else {
                                  return Text(
                                    'SignUp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.r,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ),

            // succsess alert
            BlocBuilder<SignUpAuthCubit,AuthState>(
              builder: (context, state){
                if (state is SuccessState){
                  return Center(
                    child: SuccessAlert(
                      automaticCommand: (){
                        Navigator.pop(context);
                        coreController.loginAuthCubit.login(coreController.emailSign,coreController.passwordSign);
                      },
                      backCommand: (){
                        Navigator.pop(context);
                      },
                      cancelCommand: (){
                        coreController.signUpAuthCubit.reset();
                      },
                    )
                  );
                }
                else{
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
