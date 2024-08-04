import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/cubits/auth%20cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/firebase_collections.dart';

class SignUpAuthCubit extends Cubit<AuthState>{
  SignUpAuthCubit() : super(NullState());

  void _addUser(String email,String password,String name){
    fireUsers.add(
      {
        'email' : email,
        'name' : name,
        'password' : password,
      }
    );
  }

  void signUp(String email,String password,String name) async {
    emit(LoadingState());
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      _addUser(email,password,name);
      emit(SuccessState());
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        emit(UsedEmailState());
      }
    }
  }

  void reset(){
    emit(NullState());
  }
}

