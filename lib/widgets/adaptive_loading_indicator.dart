import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AdaptiveLoadingIndicator extends StatelessWidget{
  final double iOSsize;
  final double androidSize;
  final Color color;
  final double androidWidth;
  const AdaptiveLoadingIndicator({super.key,this.androidSize = 22,this.androidWidth = 4,this.iOSsize = 12,this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS ? CupertinoActivityIndicator(
        color: Colors.white,
        radius: iOSsize.r,
      ) : SizedBox(
        width: androidSize.r,
        height: androidSize.r,
        child: CircularProgressIndicator(
          strokeWidth: androidWidth.r,
          color: Colors.white,
        ),
      ),
    );
  }
}
