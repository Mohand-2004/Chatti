import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import 'package:my_app/widgets/massaging_text_feild.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // back arrow
                    Padding(
                      padding: EdgeInsets.only(top: 30.h, left: Platform.isIOS ? 10.w : 7.w),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 27.r,
                          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                          color: const Color.fromARGB(255, 123, 123, 123),
                        ),
                      ),
                    ),

                    // app logo image
                    Padding(
                      padding: EdgeInsets.only(top: 35,left: 5.w),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // massages listVeiw
            Expanded(
              child: ListView.builder(
                  itemBuilder:(context, index){
                  return Column(
                    children: [
                      Container(
                        color: Colors.amber,
                        child: Text('$index'),
                      ),
                    ],
                  );
                },
              ),
            ),
        
            // text feild
            Padding(
              padding: EdgeInsets.all(8.r),
              child: MassagingTextFeild(
                height: 50.h,
                radius: 10.r,
                borderWidth: 3.r,
                submitCommand: (massage){},
              ),
            ),
        
            // iOS bottom space
            SizedBox(height: (Platform.isIOS ? 18.h : 5.h),)
          ],
        ),
      ),
    );
  }
}
