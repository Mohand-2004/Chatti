import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/add%20chat%20cubit/add_chat_cubit.dart';
import 'package:my_app/cubits/add%20chat%20cubit/states.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/widgets/entry.dart';

GlobalKey<FormState> formKey = GlobalKey();
TextEditingController controller = TextEditingController();

class AddFriendAlert extends StatefulWidget{
  final void Function(String freindEmail) saveCommand;
  final bool noUser;
  final String currentUserEmail;
  const AddFriendAlert({super.key, required this.saveCommand,required this.currentUserEmail,this.noUser = false});
  @override
  State<AddFriendAlert> createState() => _AddFriendAlertState();
}

class _AddFriendAlertState extends State<AddFriendAlert>{
  double errorTextSize = 12;
  String? errortext;
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      width: 300.dm,
      height: (MediaQuery.of(context).size.width < 500 ? 200.dm : 225.h),
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppColors.hellBlue,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  'Add User by email',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: 'impact',
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Form(
              key: formKey,
              child: SizedBox(
                height: 70.h,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocBuilder<AddChatCubit,AddChatState>(
                      builder: (context, state){
                        return Entry(
                          errortext: (state is NoUserState ? "There is no user has this email" : (state is ExistChatState?  "There is already a chat with this user" : errortext)),
                          errorTextSize: (state is NoUserState ? 12 : (state is ExistChatState ? 10 : errorTextSize)),
                          iconDivederSpace: 15,
                          hinttext: 'Email',
                          icon: Icons.email,
                          controller: controller,
                          validations: (string) {
                            if (string != null && !coreController.isValidEmail(string)){
                              return 'Email is not valid';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                    if(widget.currentUserEmail == controller.text){
                      setState(() {
                        errortext = "You can't add Chat with yourself";
                        errorTextSize = 11;
                      });
                    }
                    else if (coreController.isValidEmail(controller.text)) {
                      widget.saveCommand(controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      fixedSize: Size(85.w, 40.h)),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
