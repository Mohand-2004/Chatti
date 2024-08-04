import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/add%20chat%20cubit/states.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/user.dart';

class AddChatCubit extends Cubit<AddChatState>{
  AddChatCubit() : super(AddChatNullState());

  Future<AppUser?> _selectUserByEmail(String email) async {
    var response = await fireUsers.get();
    for(var user in response.docs){
      if(user['email'] == email){
        return AppUser.fromFirebaseJson(user);
      }
    }
    return null;
  }

  Future<AppUser?>? getUserByEmail(String email) async {
    emit(AddChatLoadingState());
    AppUser? user = await _selectUserByEmail(email);
    if(user == null){
      emit(NoUserState());
      return null;
    }
    else{
      emit(AddChatNullState());
      return user;
    }
  }
}