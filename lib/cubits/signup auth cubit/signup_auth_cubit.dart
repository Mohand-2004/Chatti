import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/cubits/signup%20auth%20cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupAuthCubit extends Cubit<AuthState>{
  SignupAuthCubit() : super(NullState());
  void signUp(String email,String password) async {
    emit(LoadingState());
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      emit(SuccessState());
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        emit(UsedEmailState());
      }
    }
  }
}

