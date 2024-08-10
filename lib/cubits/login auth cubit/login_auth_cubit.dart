import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/database/login_token_check.dart';
import 'package:my_app/models/chat.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/user.dart';

class LoginAuthCubit extends Cubit<LoginState>{
  AppUser? currentUser;
  LoginAuthCubit() : super(LoginSplashState());

  Future<AppUser?> _selectUserByEmail(String email) async {
    var response = await fireUsers.get();
    for(var user in response.docs){
      if(user['email'] == email){
        return AppUser.fromFirebaseJson(user,user.id);
      }
    }
    return null;
  }

  Future<List<Chat>> _selectChatsByEmail(String email) async {
    List<Chat> friends = [];
    var response = await fireChats.get();
    for(var chat in response.docs){
      if(chat['first_user_email'] == email || chat['second_user_email'] == email){
        AppUser? tempUser = await _selectUserByEmail((chat['first_user_email'] != email ? chat['first_user_email'] : chat['second_user_email']));
        friends.add(Chat(docId: chat.id, user: tempUser!));
      }
    }
    return friends;
  }

  void login(String email,String password) async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
      currentUser = await _selectUserByEmail(email);
      inserttocheckdatabase(currentUser!);
      emit(LoginSuccessState(await _selectChatsByEmail(email)));
    }
    on FirebaseAuthException{
      emit(WrongEmailOrPasswordState());
    }
  }

  void autoStartLogin() async {
    Future.delayed(const Duration(seconds: 1),() async {
      AppUser? loggedUser = await fetchcheck();
      if(loggedUser != null){
        currentUser = loggedUser;
        emit(LoginSuccessState(await _selectChatsByEmail(loggedUser.email)));
        return ;
      }
      emit(LoginNullState());
    });
  }

  void logout() async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signOut();
      resetcheckdatabase();
      emit(LoginNullState());
    }
    on FirebaseAuthException{
      emit(LoginNullState());
    }
  }
}