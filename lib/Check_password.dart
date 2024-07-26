String stronglevel(String password){
  List numbers = ['0','1','2','3','4','5','6','7','8','9'];
  List symbols = ['~','!','@','#',r'$','%','^','&','*','(',')','_','-','=','+','[',']','{','}','.','?','؟','<','>',',',';',':','÷','×',r'"',r"'"];
  List lower_letters =  ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
  List upper_letters = [];
  lower_letters.forEach((element){upper_letters.add(element.toUpperCase());});
  is_numbers_exist(String pass){
    for(String i in numbers){
      if(pass.contains(i)==true){
        return true;
      }
      else{
        return false;
      }
    }
  }
  is_symbols_exist(String pass){
  for(String i in symbols){
    if(pass.contains(i)==true){
      return true;
    }
    else{
      return false;
      }
    }
  }
  is_lowerletters_exist(String pass){
    for(String i in lower_letters){
      if(pass.contains(i)==true){
        return true;
      }
      else{
        return false;
      }
    }
  }
  is_upperletters_exist(String pass){
    for(String i in upper_letters){
      if(pass.contains(i)==true){
        return true;
      }
      else{
        return false;
      }
    }
  }
  if((is_lowerletters_exist(password)==true)&&(is_upperletters_exist(password)==true)&&(is_numbers_exist(password)==true)&&(is_symbols_exist(password)==true)){
    return "very strong";
  }
  else if(((is_lowerletters_exist(password)==true)&&(is_upperletters_exist(password)==true)&&(is_numbers_exist(password)==true)&&(is_symbols_exist(password)==false)) || ((is_lowerletters_exist(password)==true)&&(is_upperletters_exist(password)==true)&&(is_numbers_exist(password)==false)&&(is_symbols_exist(password)==true)) || ((is_lowerletters_exist(password)==true)&&(is_upperletters_exist(password)==false)&&(is_numbers_exist(password)==true)&&(is_symbols_exist(password)==true)) || ((is_lowerletters_exist(password)==false)&&(is_upperletters_exist(password)==true)&&(is_numbers_exist(password)==true)&&(is_symbols_exist(password)==true))){
    return "strong";
  }
  else if(((is_lowerletters_exist(password)==true)&&(is_upperletters_exist(password)==false)&&(is_numbers_exist(password)==false)&&(is_symbols_exist(password)==false)) || ((is_lowerletters_exist(password)==false)&&(is_upperletters_exist(password)==true)&&(is_numbers_exist(password)==false)&&(is_symbols_exist(password)==false)) || ((is_lowerletters_exist(password)==false)&&(is_upperletters_exist(password)==false)&&(is_numbers_exist(password)==true)&&(is_symbols_exist(password)==false)) || ((is_lowerletters_exist(password)==false)&&(is_upperletters_exist(password)==false)&&(is_numbers_exist(password)==false)&&(is_symbols_exist(password)==true))){
    return "weak";
  }
  else{
    return "medium";
  }
}