class Time{
  late int _seconds;
  late int _minutes;
  late int _hours;
  Time({required int seconds,required int minutes,required int hours}){
    _seconds = seconds;
    _minutes = minutes;
    _hours = hours;
  }
  void addSeconds(int seconds){
    while(seconds != 0){
      if(_seconds == 60){
        _seconds = 0;
        _minutes++;

      }
      else{
        _seconds++;
        seconds--;
      }
    }
  }
  @override
  String toString(){
    return "$_hours:$_minutes:$_seconds";
  }
}