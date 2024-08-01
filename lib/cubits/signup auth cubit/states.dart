abstract class AuthState{
  String? text;
}
class NullState extends AuthState{}
class SuccessState extends AuthState{}
class UsedEmailState extends AuthState{
  UsedEmailState(){
    text = "This email is used for another account";
  }
}
class LoadingState extends AuthState{}
