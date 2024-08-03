import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/auth%20cubit/states.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/cubits/login%20auth%20cubit/login_auth_cubit.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/widgets/adaptive_loading_indicator.dart';
import 'package:my_app/widgets/logout_confirm_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAlert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.09,
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // app logo and mode button row
              Expanded(
                child: Row(
                  children: [
                    // app logo image
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 15.w),
                      child: Image(
                        image: const AssetImage('assets/images/app icon.png'),
                        height: 45.h,
                      ),
                    ),

                    // space between
                    SizedBox(
                      width: 10.w,
                    ),

                    // chatti text
                    Padding(
                      padding: EdgeInsets.only(top: 25+5.h),
                      child: Text(
                        'Chatti',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.r,
                          fontFamily: 'impact',
                        ),
                      ),
                    ),

                    // space between
                    const Spacer(),

                    // logout button
                    Padding(
                      padding: EdgeInsets.only(left: 2, bottom: 2, top: 35, right: 15.w),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            showAlert = true;
                          });
                        },
                        icon: const Icon(Icons.logout_outlined),
                        iconSize: 23.r,
                        color: Colors.grey,
                        padding: const EdgeInsets.only(left: 5.5, bottom: 0.5),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                          shape: const CircleBorder(),
                          fixedSize: Size(40.r, 40.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            showAlert = false;
          });
        },
        child: Stack(
          children: [
            // bodyv widget
            Container(
              alignment: Alignment.center,
              color: Colors.cyan,
              child: Text(
                'Text',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
        
            // logout confirm alert
            showAlert ? SizedBox(
              child: Center(
                child: LogoutConfirmAlert(
                  yesCommand: (){
                    coreController.logout();
                  },
                  noCommand: (){
                    setState(() {
                      showAlert = false;
                    });
                  },
                ),
              ),
            ) : BlocBuilder<LoginAuthCubit,LoginState>(
              builder: (context, state){
                if (state is LoadingState){
                  return Container(
                    color: AppColors.transprantHellBlue,
                    child: Center(
                      child: AdaptiveLoadingIndicator(
                        androidWidth: 5.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}
