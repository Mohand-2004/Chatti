import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/models/app_colors.dart';

class MassagingTextFeild extends StatefulWidget{
  final double width;
  final double height;
  final double radius;
  final double borderWidth;
  final void Function(String massage) submitCommand;
  const MassagingTextFeild({super.key,required this.submitCommand,this.height = 15,this.width = double.infinity,this.radius = 25,this.borderWidth = 3});
  @override
  State<MassagingTextFeild> createState() => _MassagingTextFeildState();
}

class _MassagingTextFeildState extends State<MassagingTextFeild>{
  TextEditingController controller = TextEditingController();
  bool enableSubmit = false;
  @override
  Widget build(BuildContext context){
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(widget.borderWidth),
      decoration: BoxDecoration(
        color: AppColors.hellBlue,
        borderRadius: BorderRadius.circular(widget.radius)
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius-widget.borderWidth),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w,right: (enableSubmit ? 4.w : 10.w)),
          child: Row(
            children: [
              // massage text feild
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'massage',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    )
                  ),
                  onChanged: (value){
                    if(value != '' && !enableSubmit){
                      setState((){
                        enableSubmit = true;
                      });
                    }
                    if(value == ''){
                      setState((){
                        enableSubmit = false;
                      });
                    }
                  },
                ),
              ),
          
              // submit button
              enableSubmit ? IconButton(
                onPressed: (){
                  widget.submitCommand(controller.text);
                  controller.text = '';
                },
                padding: const EdgeInsets.only(left: 5),
                icon: Icon(
                  size: 25.r,
                  color: AppColors.orange,
                  Icons.send_rounded,
                ),
              ) : Icon(
                size: 25.r,
                color: AppColors.transprantOrange,
                Icons.send_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
