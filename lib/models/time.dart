import 'package:my_app/models/date.dart';

enum Mode{
  am,
  pm,
}
class Time{
  late int _seconds;
  late int _minutes;
  late int _hours;
  late bool _hour24Mode;
  late Mode _mode;
  Time({required int seconds,required int minutes,required int hours,bool hour24Mode = false,Mode mode = Mode.am}){
    _seconds = seconds;
    _minutes = minutes;
    _hours = hours;
    _hour24Mode = hour24Mode;
    _mode = mode;
  }
  void addSeconds(int seconds){
    seconds %= 86400;
    _incrementHours((seconds ~/ 3600));
    seconds %= 3600;
    _minutes += (seconds ~/ 60);
    seconds %= 60;
    _seconds += seconds;
  }
  void addMinutes(int minutes){
    minutes %= 1440;
    _incrementHours((minutes ~/ 60));
    minutes %= 60;
    _minutes += minutes;
  }
  void addHours(int hours){
    hours %= 24;
    _incrementHours(hours);
  }
  void subtractSeconds(int seconds){
    seconds %= 86400;
    _decrementHours((seconds ~/ 3600));
    seconds %= 3600;
    _minutes -= (seconds ~/ 60);
    seconds %= 60;
    _seconds -= seconds;
  }
  void subtractMinutes(int minutes){
    minutes %= 1440;
    _decrementHours((minutes ~/ 60));
    minutes %= 60;
    _minutes -= minutes;
  }
  void subtractHours(int hours){
    hours %= 24;
    _decrementHours(hours);
  }
  @override
  String toString(){
    return "$_hours:$_minutes ${_hour24Mode ? '' : _mode.name}";
  }
  void _incrementHours([int hours = 1]){
    _hours += hours;
    if(!_hour24Mode && _hours > 12){
      _hours -= 12;
      _switchMode();
    }
  }
  void _decrementHours([int hours = 1]){
    _hours -= hours;
    if(_hours < 1){
      _hours += 12;
      _switchMode();
    }
  }
  void _switchMode(){
    switch (_mode) {
      case Mode.am:
        _mode = Mode.pm;
        break;
      case Mode.pm:
        _mode = Mode.am;
      default:
        break;
    }
  }
  bool operator > (Time time){
    if(_hour24Mode && time.is24){
      if(_hours > time.hours){
        return true;
      }
      else{
        if(_hours == time.hours){
          if(_minutes > time.minutes){
            return true;
          }
          else{
            if(_minutes == time.minutes){
              if(_seconds > time.seconds){
                return true;
              }
              else{
                return _seconds > time.seconds;
              }
            }
            else{
              return false;
            }
          }
        }
        else{
          return false;
        }
      }
    }
    else if(!time.is24 && !_hour24Mode){
      if(time.mode == _mode){
        if(_hours > time.hours){
          return true;
        }
        else{
          if(_hours == time.hours){
            if(_minutes > time.minutes){
              return true;
            }
            else{
              if(_minutes == time.minutes){
                if(_seconds > time.seconds){
                  return true;
                }
                else{
                  return _seconds > time.seconds;
                }
              }
              else{
                return false;
              }
            }
          }
          else{
            return false;
          }
        }
      }
      else{
        if(_mode == Mode.am && time.mode == Mode.pm){
          return false;
        }
        else{
          return true;
        }
      }
    }
    else{
      if((!_hour24Mode && _mode == Mode.pm ? _hours + 12 : _hours) > (!time.is24 && time.mode == Mode.pm ? time.hours +12 : time.hours)){
        return true;
      }
      else{
        if((!_hour24Mode && _mode == Mode.pm ? _hours + 12 : _hours) == (!time.is24 && time.mode == Mode.pm ? time.hours +12 : time.hours)){
          if(_minutes > time.minutes){
            return true;
          }
          else{
            if(_minutes == time.minutes){
              if(_seconds > time.seconds){
                return true;
              }
              else{
                return _seconds > time.seconds;
              }
            }
            else{
              return false;
            }
          }
        }
        else{
          return false;
        }
      }
    }
  }
  bool operator < (Time time){
    if(_hour24Mode && time.is24){
      if(_hours < time.hours){
        return true;
      }
      else{
        if(_hours == time.hours){
          if(_minutes < time.minutes){
            return true;
          }
          else{
            if(_minutes == time.minutes){
              if(_seconds < time.seconds){
                return true;
              }
              else{
                return _seconds < time.seconds;
              }
            }
            else{
              return false;
            }
          }
        }
        else{
          return false;
        }
      }
    }
    else if(!time.is24 && !_hour24Mode){
      if(time.mode == _mode){
        if(_hours < time.hours){
          return true;
        }
        else{
          if(_hours == time.hours){
            if(_minutes < time.minutes){
              return true;
            }
            else{
              if(_minutes == time.minutes){
                if(_seconds < time.seconds){
                  return true;
                }
                else{
                  return _seconds < time.seconds;
                }
              }
              else{
                return false;
              }
            }
          }
          else{
            return false;
          }
        }
      }
      else{
        if(_mode == Mode.am && time.mode == Mode.pm){
          return false;
        }
        else{
          return true;
        }
      }
    }
    else{
      if((!_hour24Mode && _mode == Mode.pm ? _hours + 12 : _hours) < (!time.is24 && time.mode == Mode.pm ? time.hours +12 : time.hours)){
        return true;
      }
      else{
        if((!_hour24Mode && _mode == Mode.pm ? _hours + 12 : _hours) == (!time.is24 && time.mode == Mode.pm ? time.hours +12 : time.hours)){
          if(_minutes < time.minutes){
            return true;
          }
          else{
            if(_minutes == time.minutes){
              if(_seconds < time.seconds){
                return true;
              }
              else{
                return _seconds < time.seconds;
              }
            }
            else{
              return false;
            }
          }
        }
        else{
          return false;
        }
      }
    }
  }
  bool isEqual(Time time){
    if(_hour24Mode == time.is24){
      if(_hour24Mode && time.is24){
        return (_hours == time.hours && _minutes == time.minutes && _seconds == time.seconds);
      }
      else{
        if(time.mode != _mode){
          return false;
        }
        else{
          return (_hours == time.hours && _minutes == time.minutes && _seconds == time.seconds);
        }
      }
    }
    else{
      return (((!_hour24Mode && _mode == Mode.pm) ? _hours + 12 : _hours) == ((!time.is24 && time.mode == Mode.pm) ? time.hours + 12 : time.hours) && _minutes == time.minutes && _seconds == time.seconds);
    }
  }
  bool operator >= (Time time){
    return this > time || isEqual(time);
  }
  bool operator <= (Time time){
    return this < time || isEqual(time);
  }
  void to24Mode(){
    if(_hours != 12){
      if(!_hour24Mode){
        _hour24Mode = true;
        if(_mode == Mode.pm){
          _hours += 12;
        }
      }
    }
    else{
      if(!_hour24Mode){
        _hour24Mode = true;
        if(mode == Mode.am){
          _hours = 0;
        }
      }
    }
  }
  Time to12Mode(){
    if(_hour24Mode){
      if(_hours == 0){
        _hours = 12;
        _mode = Mode.am;
      }
      else{
          _hour24Mode = false;
          if(_hours > 12){
            _hours -= 12;
            _mode = Mode.pm;
          }
          else{
            _mode = Mode.am;
          }
      }
    }
    return this;
  }
  // static Mode _timeMode(){
  //   String now = DateFormat('hh:mm a').format(DateTime.now()).toString();
  //   String mode = now.substring(now.indexOf(' ')+1);
  //   return mode == 'PM' ? Mode.pm : Mode.am;
  // }
  static Time _current(){
    DateTime now = DateTime.now();
    return Time(
      seconds: now.second,
      minutes: now.minute,
      hours: now.hour,
      hour24Mode: true,
    );
  }
  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  Mode get mode => _mode;
  bool get is24 => _hour24Mode;
  static Time get current => _current();
}