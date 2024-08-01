import 'package:flutter/material.dart';
import 'package:my_app/cubits/signup%20auth%20cubit/signup_auth_cubit.dart';

class CoreController{
  GlobalKey<FormState> signUpValidationsKey = GlobalKey();
  TextEditingController emailSignController = TextEditingController();
  TextEditingController passwordSignController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  SignupAuthCubit signupAuthCubit = SignupAuthCubit();

  void signUp(){
    signupAuthCubit.signUp(emailSignController.text,passwordSignController.text);
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

  bool matchPasswordsValidate() => passwordSignController.text == confirmpasswordController.text;
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
}
CoreController coreController = CoreController();