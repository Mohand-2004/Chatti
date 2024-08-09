import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cubits/add%20chat%20cubit/add_chat_cubit.dart';
import 'package:my_app/cubits/add%20chat%20cubit/states.dart';
import 'package:my_app/cubits/core_controller.dart';
import 'package:my_app/models/app_colors.dart';
import 'package:my_app/models/chat.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/widgets/freind_chat.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/chat_page.dart';
import 'package:my_app/widgets/adaptive_loading_indicator.dart';
import 'package:my_app/widgets/add_friend_alert.dart';
import 'package:my_app/widgets/logout_confirm_alert.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  final AppUser user;
  final List<Chat> firebaseFrirnds;
  const HomePage({super.key, required this.user, required this.firebaseFrirnds});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAlert = false;
  bool isLogoutAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // app logo image
                    Padding(
                      padding: EdgeInsets.only(top: 35, left: 15.w),
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

                    // logout button
                    Padding(
                      padding: EdgeInsets.only(
                          left: 2, bottom: 2, top: 35, right: 15.w),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            showAlert = true;
                            isLogoutAlert = true;
                          });
                        },
                        icon: const Icon(Icons.logout_outlined),
                        iconSize: 23.r,
                        color: Colors.grey,
                        padding: const EdgeInsets.only(left: 5.5, bottom: 0.5),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:const Color.fromARGB(255, 237, 237, 237),
                          shape: const CircleBorder(),
                          fixedSize: Size(40.r, 40.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                endIndent: 25.w,
                indent: 25.w,
                thickness: 3.r,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            showAlert = false;
          });
        },
        child: BlocProvider(
          create: (context) => coreController.chatCubit,
          child: Stack(
            children: [
              // body widget
              BlocBuilder<AddChatCubit,AddChatState>(
                builder: (context, state) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: (state is ChatsRefreshState ? state.newChats.isEmpty : widget.firebaseFrirnds.isEmpty) ? Center(
                      child: Text(
                        'No Chats',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context,index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context){
                                      return ChatPage(
                                        sender: widget.user,
                                        receiver: (state is ChatsRefreshState ? state.newChats[index].user : widget.firebaseFrirnds[index].user),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FreindChat(
                                height: 100.h,
                                chat: (state is ChatsRefreshState ? state.newChats[index] : widget.firebaseFrirnds[index]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        );
                      },
                      itemCount: (state is ChatsRefreshState ? state.newChats.length : widget.firebaseFrirnds.length),
                    ),
                  );
                },
              ),

              // logout confirm alert
              showAlert ? SizedBox(
                child: isLogoutAlert
                  ? Center(
                      child: LogoutConfirmAlert(
                        yesCommand: () {
                          coreController.chatCubit = AddChatCubit();
                          coreController.logout();
                        },
                        noCommand: (){
                          setState((){
                            showAlert = false;
                          });
                        },
                      ),
                    )
                  : Center(
                      child: AddFriendAlert(
                        currentUserEmail: widget.user.email,
                        saveCommand: (String freindEmail) async {
                          AppUser? newFriend = await coreController.chatCubit.getUserByEmail(freindEmail);
                          if (newFriend != null) {
                            coreController.addChatToFireBase(widget.user.email,newFriend.email);
                            setState((){
                              showAlert = false;
                            });
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox(),

              // loading indicator
              BlocBuilder<AddChatCubit, AddChatState>(
                builder: (context, state) {
                  if (state is AddChatLoadingState) {
                    return Container(
                      color: AppColors.transprantHellBlue,
                      child: Center(
                        child: AdaptiveLoadingIndicator(
                          androidWidth: 5.r,
                          androidSize: 60,
                          iOSsize: 25,
                          color: AppColors.orange,
                        ),
                      ),
                    );
                  }
                  else{
                    return const SizedBox();
                  }
                },
              ),

              // streambuilder to listen to dataBase 
              // and trigger cubit
              StreamBuilder(
                stream: fireChats.snapshots(),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    coreController.chatCubit.refreshChats(widget.user.email);
                    return const SizedBox();
                  }
                  else{
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: (Platform.isIOS ? 15.h : 10.h)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: IconButton(
            onPressed: () {
              setState(() {
                showAlert = true;
                isLogoutAlert = false;
              });
            },
            icon: const Icon(Icons.add_comment),
            iconSize: 32.r,
            padding: const EdgeInsets.only(top: 3),
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: AppColors.orange,
              fixedSize: Size(58.r, 58.r),
              iconColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
