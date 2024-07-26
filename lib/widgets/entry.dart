import 'package:flutter/material.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: must_be_immutable
class Entry extends StatefulWidget{
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;
  // String? text;
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
                    fontSize: 6.sp
                  ),
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