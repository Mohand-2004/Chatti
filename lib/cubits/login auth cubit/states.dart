import 'package:my_app/models/chat.dart';

abstract class LoginState{
  String? text;
}
class LoginNullState extends LoginState{}
class LoginSuccessState extends LoginState{
  List<Chat> chats;
  LoginSuccessState(this.chats);
}
class WrongEmailOrPasswordState extends LoginState{
  WrongEmailOrPasswordState(){
    text = "Wrong email or password";
  }
}
class LoginLoadingState extends LoginState{}
