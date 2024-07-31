import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/check_password.dart';
import 'package:my_app/models/app_colors.dart';
// ignore: must_be_immutable
class CreatePasswordEntry extends StatefulWidget{
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;
  String? errortext;
  String? Function(String? string)? validations;
  bool repeat;
  CreatePasswordEntry({super.key,required this.hinttext,required this.icon,this.errortext,required this.controller,this.validations,this.repeat = false});
  @override
  State<CreatePasswordEntry> createState() => _CreatePasswordEntryState();
}
class _CreatePasswordEntryState extends State<CreatePasswordEntry>{
  bool _hiddentext = false;
  Function? command;
  bool showicon = false;
  Widget iconbutton = const Icon(Icons.remove_red_eye_rounded);
  Color errortextcolor = Colors.red;
  void showtext(){
    void hidetext(){
      setState((){
        _hiddentext = true;
        command = showtext;
        iconbutton = const Icon(Icons.remove_red_eye_rounded);
      });
    }
    setState((){
      _hiddentext = false;
      command = hidetext;
      iconbutton = Image(
        image: const AssetImage('assets/images/hideicon.png'),
        width: 30.r,
        height: 30.r,
      );
    });
  }
  @override
  void initState(){
    widget.controller.text = '';
    _hiddentext = true;
    showicon = false;
    command = showtext;
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
        width: double.infinity,
        height: double.infinity,
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
                padding: EdgeInsets.only(left: (showicon && MediaQuery.of(context).size.width > 500) ? 13.w : 10.w),
                child: Icon(
                  size: 40.r,
                  widget.icon,
                  color: AppColors.hellBlue,
                ),
              ),
            ),

            // verticl divider
            SizedBox(
              height: double.infinity,
              child: VerticalDivider(
                indent: 16.h,
                endIndent: 16.h,
                thickness: 2.sp,
                color: Colors.grey,
                width: showicon ? 30.w+10 : 25.w,
              ),
            ),

            // text feild
            Expanded(
              flex: 84,
              child: TextFormField(
                validator: widget.validations,
                onTapOutside: (event){
                  setState((){
                    if(widget.controller.text == ''){
                      showicon = false;
                      widget.errortext = null;
                    }
                  });
                  // pop the keyboard when foucus outside
                  // as in iOS the keboard won't pop automaticly
                  if(Platform.isIOS){
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
                onTap: (){
                  setState((){
                    if(widget.controller.text == ''){
                      widget.errortext = null;
                    }
                    showicon = true;
                  });
                },
                onChanged: (value){
                  if(widget.repeat == false){
                    setState((){
                      if(value == ''){
                        widget.errortext == null;
                      }
                      else{
                        widget.errortext = stronglevel(value);
                        if(stronglevel(value) == 'medium'){
                          errortextcolor = Colors.amber;
                        }
                        else if(stronglevel(value) == 'strong'){
                          errortextcolor = Colors.greenAccent;
                        }
                        else if(stronglevel(value) == 'very strong'){
                          errortextcolor = Colors.green;
                        }
                        else{
                          errortextcolor = Colors.red;
                        }
                      }
                    });
                  }
                },
                controller: widget.controller,
                obscureText: _hiddentext,
                onFieldSubmitted: (value){
                  setState(() {
                    if(widget.controller.text == ''){
                      showicon = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  errorText: widget.errortext,
                  errorStyle: TextStyle(
                    color: errortextcolor,
                    fontFamily: 'impact',
                    fontSize: 15.sp
                  ),
                  border: InputBorder.none,
                  hintText: widget.hinttext,
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: EdgeInsets.only(left: showicon ? 5 : 13)
                ),
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),

            // eye button
            showicon ? IconButton(
              iconSize: 25.r,
              onPressed: (){command!();},
                icon: iconbutton
            ) : const SizedBox(),

            // right space
            SizedBox(width: 5.w+(MediaQuery.of(context).size.width > 500 ? 5.w : 0),),
          ],
        )
      ),
    );
  }
}