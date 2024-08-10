import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/cubits/massages%20cubit/massages_cubit.dart';
import 'package:my_app/cubits/massages%20cubit/states.dart';
import 'package:my_app/models/date.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/massage.dart';
import 'package:my_app/models/time.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/widgets/date_show_container.dart';
import 'package:my_app/widgets/friend_chat_bubble.dart';
import 'package:my_app/widgets/android_massaging_text_feild.dart';
import 'package:my_app/widgets/ios_massaging_text_feild.dart';
import 'package:my_app/widgets/self_chat_bubble.dart';
import 'dart:io' show Platform;

class ChatPage extends StatelessWidget {
  final AppUser sender;
  final AppUser receiver;
  const ChatPage({super.key, required this.receiver, required this.sender});
  @override
  Widget build(BuildContext context){
    coreController.massageCubit.getMassages(sender.email,receiver.email);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.11,
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
                        onPressed: (){
                          Navigator.pop(context);
                          coreController.massageCubit = MassagesCubit();
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
                      padding: EdgeInsets.only(top: 35, left: 5.w),
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
                      padding: EdgeInsets.only(top: 25 + 5.h),
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
              Divider(
                endIndent: 20.w,
                indent: 20.w,
                thickness: 3.r,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => coreController.massageCubit,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/chat background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  // top space
                  SizedBox(height: 8.h,),

                  // massages listVeiw
                  BlocBuilder<MassagesCubit,MassageState>(
                    builder: (context, state) {
                      if(state is GetMassageState){
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  index == 0 ? DateShowContainer(
                                    height: (MediaQuery.of(context).size.width > 500 ? 35.h : 30.h),
                                    date: state.massages[0].date,
                                  ) : const SizedBox(height: 0,),
                                  state.massages[index].senderEmail == sender.email ? SelfChatBubble(
                                      radius: 20.r,
                                      massage: state.massages[index],
                                    ) : FriendChatBubble(
                                    radius: 20.r,
                                    massage: state.massages[index],
                                  ),
                                  (index != state.massages.length-1 && !state.massages[index].date.isEqual(state.massages[index+1].date)) ? DateShowContainer(
                                    height: (MediaQuery.of(context).size.width > 500 ? 35.h : 30.h),
                                    date: state.massages[index+1].date,
                                    verticalPadding: 15.h,
                                  ) : SizedBox(height: 25.h,) 
                                ],
                              );
                            },
                            itemCount: state.massages.length,
                            physics: const BouncingScrollPhysics(),
                          ),
                        );
                      }
                      else{
                        return const Expanded(child: SizedBox());
                      }
                    },
                  ),
                        
                  // adaptive massaging text feild
                  Platform.isIOS ? IOSMassagingTextFeild(
                    height: 90.h,
                    submitCommand: (massage){
                      coreController.addChatIfNotExist(receiver);
                      coreController.addMassageToFireBase(
                        Massage(
                          content: massage,
                          senderEmail: sender.email,
                          receiverEmail: receiver.email,
                          docId: 'null',
                          date: Date.current,
                          time: Time.current,
                        ),
                      );
                    },
                  ) : AndroidMassagingTextFeild(
                    height: 50.h,
                    radius: 10.r,
                    borderWidth: 3.r,
                    bottomSpace: 5.h,
                    padding: EdgeInsets.all(8.r),
                    submitCommand: (String massageContent){
                      coreController.addChatIfNotExist(receiver);
                      coreController.addMassageToFireBase(
                        Massage(
                          content: massageContent,
                          senderEmail: sender.email,
                          receiverEmail: receiver.email,
                          docId: 'null',
                          date: Date.current,
                          time: Time.current,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        
            StreamBuilder(
              stream: fireMassages.snapshots(),
              builder: (context,snapshot){
               if(snapshot.hasData){
                coreController.massageCubit.getMassages(sender.email,receiver.email);
               } 
               return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
