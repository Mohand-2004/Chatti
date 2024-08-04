import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/user.dart';

class LoginAuthCubit extends Cubit<LoginState>{
  AppUser? currentUser;
  LoginAuthCubit() : super(LoginNullState());

  Future<AppUser?> _selectUserByEmail(String email) async {
    var response = await fireUsers.get();
    for(var user in response.docs){
      if(user['email'] == email){
        return AppUser.fromFirebaseJson(user);
      }
    }
    return null;
  }

  Future<List<AppUser>> _selectChatsByEmail(String email) async {
    List<AppUser> friends = [];
    var response = await fireChats.get();
    for(var chat in response.docs){
      if(chat['first_user_email'] == email || chat['second_user_email'] == email){
        AppUser? tempUser = await _selectUserByEmail((chat['first_user_email'] != email ? chat['first_user_email'] : chat['second_user_email']));
        friends.add(tempUser!);
      }
    }
    return friends;
  }

  void login(String email,String password) async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
      currentUser = await _selectUserByEmail(email);
      emit(LoginSuccessState(await _selectChatsByEmail(email)));
    }
    on FirebaseAuthException{
      emit(WrongEmailOrPasswordState());
    }
  }

  void logout() async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signOut();
      emit(LoginNullState());
    }
    on FirebaseAuthException{
      emit(LoginNullState());
    }
  }
}