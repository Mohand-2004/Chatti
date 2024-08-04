import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/user.dart';

class LoginAuthCubit extends Cubit<LoginState>{
  AppUser? currentUser;
  LoginAuthCubit() : super(LoginNullState());

  Future<AppUser?> selectUserByEmail(String email) async {
    var response = await fireUsers.get();
    for(var user in response.docs){
      if(user['email'] == email){
        return AppUser.fromFirebaseJson(user);
      }
    }
    return null;
  }

  void login(String email,String password) async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
      currentUser = await selectUserByEmail(email);
      emit(LoginSuccessState());
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