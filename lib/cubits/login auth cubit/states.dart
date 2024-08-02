abstract class LoginState{
  String? text;
}
class LoginNullState extends LoginState{}
class LoginSuccessState extends LoginState{}
class WrongEmailOrPasswordState extends LoginState{
  WrongEmailOrPasswordState(){
    text = "Wrong email or password";
  }
}
class LoginLoadingState extends LoginState{}
