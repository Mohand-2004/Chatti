class Date{
  late int _year;
  late int _month;
  late int _day;
  Date({required int day,required int month,required int year}){
    _day = day;
    _month = month;
    _year = year;
  }
  void addDays(int days){
    while(days != 0){
      _day++;
      if(_day > (_month == 2 ? 28 : (_month % 2 == 0 ? 31 : 30))){
        _day -= (_month == 2 ? 28 : (_month % 2 == 0 ? 31 : 30));
        _month++;
      }
      if(_month > 12){
        _year++;
        _month = 1;
      }
      days--;
    }
  }
  void addmonths(int months){
    int days = 0;
    int currentMonth = _month;
    while(months != 0){
      days += (currentMonth == 2 ? 28 : (currentMonth % 2 == 0 ? 31 : 30));
      months--;
      currentMonth++;
    }
    addDays(days);
  }
  void addYears(int years){
    _year += years;
  }
  String toStr(){
    return '$_day/$_month/$_year';
  }
  bool operator > (Date date){
    if(_year == date.year){
      if(_month == date._month){
        if(_day == date.day){
          return false;
        }
        else{
          return _day > date.day;
        }
      }
      else{
        return _month > date.month;
      }
    }
    else{
      return _year > date.year;
    }
  }
  bool operator < (Date date){
    if(_year == date.year){
      if(_month == date._month){
        if(_day == date.day){
          return false;
        }
        else{
          return _day < date.day;
        }
      }
      else{
        return _month < date.month;
      }
    }
    else{
      return _year < date.year;
    }
  }
  bool isEqual(Date date){
    if(_year == date.year && _day == date.day && month == date._month){
      return true;
    }
    else{
      return false;
    }
  }
  bool operator >= (Date date){
    return (this > date || isEqual(date));
  }
  bool operator <= (Date date){
    return (this < date || isEqual(date));
  }
  int get year => _year;
  int get day => _day;
  int get month => _month;
}