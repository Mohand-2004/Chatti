import 'package:my_app/models/chat.dart';

abstract class AddChatState{}
class AddChatNullState extends AddChatState{}
class AddChatSuccsessState extends AddChatState{}
class NoUserState extends AddChatState{}
class AddChatLoadingState extends AddChatState{}
class ChatsRefreshState extends AddChatState{
  List<Chat> newChats;
  ChatsRefreshState(this.newChats);
}