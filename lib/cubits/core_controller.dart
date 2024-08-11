import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/cubits/add%20chat%20cubit/add_chat_cubit.dart';
import 'package:my_app/cubits/auth%20cubit/signup_auth_cubit.dart';
import 'package:my_app/cubits/login%20auth%20cubit/login_auth_cubit.dart';
import 'package:my_app/cubits/massages%20cubit/massages_cubit.dart';
import 'package:my_app/models/chat.dart';
import 'package:my_app/models/firebase_collections.dart';
import 'package:my_app/models/massage.dart';
import 'package:my_app/models/user.dart';

class CoreController{
  GlobalKey<FormState> signUpValidationsKey = GlobalKey();
  GlobalKey<FormState> loginValidationsKey = GlobalKey();
  TextEditingController emailSignController = TextEditingController();
  TextEditingController nameSignController = TextEditingController();
  TextEditingController passwordSignController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  ScrollController chatsListVeiwController = ScrollController();
  SignUpAuthCubit signUpAuthCubit = SignUpAuthCubit();
  LoginAuthCubit loginAuthCubit = LoginAuthCubit();
  AddChatCubit chatCubit = AddChatCubit();
  MassagesCubit massageCubit = MassagesCubit();
  MediaQueryData? mediaQuery;

  CoreController(){
    loginAuthCubit.autoStartLogin();
  }

  void addChatToFireBase(String firstEmail,String secondEmail){
    fireChats.add(
      {
        "first_user_email" : firstEmail,
        "second_user_email" : secondEmail,
      }
    );
  }

  void addMassageToFireBase(Massage massage){
    fireMassages.add(
      {
        "content" : massage.content,
        "day" : massage.date.day,
        "hours" : massage.time.hours,
        "minutes" : massage.time.minutes,
        "month" : massage.date.month,
        "receiver_email" : massage.receiverEmail,
        "seconds" : massage.time.seconds,
        "sender_email" : massage.senderEmail,
        "year" : massage.date.year,
      }
    );
  }

  void addChatIfNotExist(AppUser user) async {
    var response = await fireChats.get();
    for(var chat in response.docs){
      if(
        (chat['first_user_email'] == user.email && chat['second_user_email'] == coreController.loginAuthCubit.currentUser!.email)||
        (chat['second_user_email'] == user.email && chat['first_user_email'] == coreController.loginAuthCubit.currentUser!.email)){
        return ;
      }
    }
    addChatToFireBase(user.email,loginAuthCubit.currentUser!.email);
  }

  void signUp(){
    signUpAuthCubit.signUp(emailSignController.text,passwordSignController.text,nameSignController.text);
  }

  void login(){
    loginAuthCubit.login(emailLoginController.text,passwordLoginController.text);
  }

  void logout(){
    loginAuthCubit.logout();
  }

  bool passwordSignValidate(){
    if(passwordSignController.text == ''){
      return false;
    }
    else if(stronglevel(passwordSignController.text) == 'weak' || stronglevel(passwordSignController.text) == 'medium'){
      return false;
    }
    else if(passwordSignController.text.length < 8){
      return false;
    }
    return true;
  }

  bool isValidEmail(String s){
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(s);
  }

  bool matchPasswordsValidate() => passwordSignController.text == confirmpasswordController.text;

  String formteMassage(String massage){
    int counter = 0;
    String newMassage = '';
    for(int i = 0;i<massage.length;i++){
      switch(massage[i]){
        case '\n':
          counter = 0;
          break;
        default:
          counter++;
          break;
      }
      newMassage += massage[i];
      if(counter > 32){
        counter = 0;
        newMassage += '\n';
      }
    }
    return newMassage;
  }
  void deleteChatMassages(Chat chat) async {
    var response = await fireMassages.get();
    for(var massage in response.docs){
      if((massage['sender_email'] == chat.user.email && massage['receiver_email'] == coreController.loginAuthCubit.currentUser!.email) || (massage['receiver_email'] == chat.user.email && massage['sender_email'] == coreController.loginAuthCubit.currentUser!.email)){
        fireMassages.doc(massage.id).delete();
      }
    }
  }
  String stronglevel(String password){
    List numbers = ['0','1','2','3','4','5','6','7','8','9'];
    List symbols = ['~','!','@','#',r'$','%','^','&','*','(',')','_','-','=','+','[',']','{','}','.','?','؟','<','>',',',';',':','÷','×',r'"',r"'"];
    List lowerletters =  ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
    List upperletters = [];
    for (String element in lowerletters){
      upperletters.add(element.toUpperCase());
    }
    isnumbersexist(String pass){
      for(String i in numbers){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    issymbolsexist(String pass){
      for(String i in symbols){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    islowerlettersexist(String pass){
      for(String i in lowerletters){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    isupperlettersexist(String pass){
      for(String i in upperletters){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    if((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true)){
      return "very strong";
    }
    else if(((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==true)) || ((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true))){
      return "strong";
    }
    else if(((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==true))){
      return "weak";
    }
    else{
      return "medium";
    }
  }

  String get emailSign => emailSignController.text;
  String get passwordSign => passwordSignController.text;
}
CoreController coreController = CoreController();