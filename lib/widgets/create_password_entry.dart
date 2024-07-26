import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      iconbutton = Image.asset('assets/images/hideicon.png');
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
        borderRadius: BorderRadius.circular(10.sp)
      ),
      padding: EdgeInsets.all(1.sp),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.sp)
        ),
        child: Row(
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 15,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(widget.icon,color: AppColors.hellBlue,),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: double.infinity,
              child: VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 84,
              child: TextFormField(
                validator: widget.validations,
                onTapOutside: (event){
                  setState((){
                    if(widget.controller.text == ''){
                      showicon = false;
                    }
                  });
                },
                onTap: (){
                  setState((){
                    widget.errortext = null;
                    showicon = true;
                  });
                },
                onChanged: (value){
                  // if(widget.repeat == false){
                  //   setState((){
                  //     if(value == ''){
                  //       widget.errortext == null;
                  //     }
                  //     else{
                  //       widget.errortext = stronglevel(value);
                  //       if(stronglevel(value) == 'medium'){
                  //         errortextcolor = Colors.amber;
                  //       }
                  //       else if(stronglevel(value) == 'strong'){
                  //         errortextcolor = Colors.greenAccent;
                  //       }
                  //       else if(stronglevel(value) == 'very strong'){
                  //         errortextcolor = Colors.green;
                  //       }
                  //       else{
                  //         errortextcolor = Colors.red;
                  //       }
                  //     }
                  //   });
                  // }
                },
                controller: widget.controller,
                obscureText: _hiddentext,
                decoration: InputDecoration(
                  errorText: widget.errortext,
                  errorStyle: TextStyle(
                    color: errortextcolor,
                    fontFamily: 'impact',
                    fontSize: 6.sp
                  ),
                  suffixIcon: showicon ? IconButton(
                    onPressed: (){command!();},
                      icon: iconbutton
                    ) : null,
                  border: InputBorder.none,
                  hintText: widget.hinttext,
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.only(left: 20)
                ),
                style: TextStyle(
                  fontSize: 7.sp,
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}