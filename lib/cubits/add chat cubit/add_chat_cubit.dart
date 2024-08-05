import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/add%20chat%20cubit/states.dart';
import 'package:my_app/models/chat.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/user.dart';

class AddChatCubit extends Cubit<AddChatState>{
  AddChatCubit() : super(AddChatNullState());

  Future<AppUser?> _selectUserByEmail(String email) async {
    var response = await fireUsers.get();
    for(var user in response.docs){
      if(user['email'] == email){
        return AppUser.fromFirebaseJson(user,user.id);
      }
    }
    return null;
  }

  void refreshChats(String email) async {
    List<Chat> friends = [];
    var response = await fireChats.get();
    for(var chat in response.docs){
      if(chat['first_user_email'] == email || chat['second_user_email'] == email){
        AppUser? tempUser = await _selectUserByEmail((chat['first_user_email'] != email ? chat['first_user_email'] : chat['second_user_email']));
        friends.add(Chat(docId: chat.id, user: tempUser!));
      }
    }
    emit(ChatsRefreshState(friends));
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