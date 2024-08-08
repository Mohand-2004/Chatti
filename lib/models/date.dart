class Date{
  late int _year;
  late int _month;
  late int _day;
  late int _yearsDays;
  late Map<int,int> _monthDays;
  Date({required int day,required int month,required int year}){
    _day = day;
    _month = month;
    _year = year;
    _monthDays = {
      1 : 31,
      2 : (_year % 4 == 0 ? 29 : 28),
      3 : 31,
      4 : 30,
      5 : 31,
      6 : 30,
      7 : 31,
      8 : 31,
      9 : 30,
      10 : 31,
      11 : 30,
      12 : 31,
    };
    _yearsDays = (_year % 4 == 0 ? 366 : 365);
  }
  void _setYear(){
    if(year % 4 == 0){
      _yearsDays = 366;
      _monthDays[2] = 29;
    }
    else{
      _yearsDays = 365;
      _monthDays[2] = 28;
    }
  }
  void addDays(int days){
    while(days + _day >= _yearsDays){
      _year++;
      days -= _yearsDays;
      _setYear();
    }
    while(days + _day >= _monthDays[_month]!){
      days -= _monthDays[_month]!;
      _month++;
    }
    _day += days;
  }
  void addmonths(int months){
    while(months + _month >= 12){
      _year++;
      months -= 12;
      _setYear();
    }
    _month += months;
  }
  void addYears(int years){
    // ignore: no_wildcard_variable_uses
    for(int _ = 0; _ < years;_++){
      _year++;
      _setYear();
    }
  }
  void subtractDays(int days){
    while(days >= _yearsDays){
      _year--;
      days -= _yearsDays;
      _setYear();
    }
    while(days >= _monthDays[_month]!){
      days -= _monthDays[_month]!;
      _month--;
    }
    _day -= days;
  }
  void subtractmonths(int months){
    while(months >= 12){
      _year--;
      months -= 12;
      _setYear();
    }
    _month -= months;
  }
  void subtractYears(int years){
    // ignore: no_wildcard_variable_uses
    for(int _ = 0; _ < years;_++){
      _year--;
      _setYear();
    }
  }
  @override
  String toString(){
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
  int get yearsDays => _yearsDays;
}