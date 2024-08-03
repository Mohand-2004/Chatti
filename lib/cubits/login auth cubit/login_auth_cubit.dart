import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/login%20auth%20cubit/states.dart';

class LoginAuthCubit extends Cubit<LoginState>{
  LoginAuthCubit() : super(LoginSuccessState());

  void login(String email,String password) async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
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