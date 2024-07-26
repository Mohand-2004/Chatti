import 'dart:io' show Platform; 
import 'package:flutter/material.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: must_be_immutable
class Entry extends StatefulWidget{
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;
  String? errortext;
  String? Function(String? string)? validations;
  Entry({super.key,required this.hinttext,required this.icon,this.errortext,required this.controller,this.validations});
  @override
  State<Entry> createState() => _EntryState();
}
class _EntryState extends State<Entry>{
  @override
  void initState() {
    widget.controller.text = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.hellBlue,
        borderRadius: BorderRadius.circular(23.r)
      ),
      padding: EdgeInsets.all(2.r),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r)
        ),
        child: Row(
          children: [
            // icon
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Icon(
                  size: 40.r,
                  widget.icon,color: AppColors.hellBlue,
                ),
              ),
            ),

            // verticl divider
            SizedBox(
              height: double.infinity,
              child: VerticalDivider(
                indent: 16.h,
                endIndent: 16.h,
                color: Colors.grey,
                thickness: 2.sp,
                width: 20.w,
              ),
            ),

            // text feild
            Expanded(
              flex: 84,
              child: TextFormField(
                onTap: () {
                  setState(() {
                    widget.errortext = null;
                  });
                },
                validator: widget.validations,
                controller: widget.controller,
                decoration: InputDecoration(
                  errorText: widget.errortext,
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontFamily: 'impact',
                    fontSize: 17.sp
                  ),
                  border: InputBorder.none,
                  hintText: widget.hinttext,
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.only(left: 15)
                ),
                style: TextStyle(
                  fontSize: 18.sp,
                ),
                onTapOutside: (event) {
                  // pop the keyboard when foucus outside
                  // as in iOS the keboard won't pop automaticly
                  if(Platform.isIOS){
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }
}