import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Sample AppBar Text',
          style: TextStyle(
            fontSize: 25.sp
          ),
        ),
        toolbarHeight: 50.h,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey,
        child: Text(
          'Text',
          style: TextStyle(
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }
}