import 'package:my_app/models/user.dart';

abstract class LoginState{
  String? text;
}
class LoginNullState extends LoginState{}
class LoginSuccessState extends LoginState{
  List<AppUser> chats;
  LoginSuccessState(this.chats);
}
class WrongEmailOrPasswordState extends LoginState{
  WrongEmailOrPasswordState(){
    text = "Wrong email or password";
  }
}
class LoginLoadingState extends LoginState{}
