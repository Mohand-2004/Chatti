import 'package:my_app/models/date.dart';
import 'package:my_app/models/time.dart';

class Massage{
  late final String _docId;
  late final String _content;
  late final String _senderEmail;
  late final String _receiverEmail;
  late final Date _date;
  late final Time _time;
  Massage({required String content,required String senderEmail,required String receiverEmail,required String docId,required Date date,required Time time}){
    _content = content;
    _date = date;
    _time = time;
    _docId = docId;
    _senderEmail = senderEmail;
    _receiverEmail = receiverEmail;
  }
  factory Massage.fromJson(Map<String,dynamic> json,String id){
    return Massage(
      content: json['content'],
      senderEmail: json['senderEmail'],
      receiverEmail: json['receiverEmail'],
      docId: id,
      date: Date(day: json['day'], month: json['month'], year: json['year']),
      time: Time(seconds: json['seconds'], minutes: json['minutes'], hours: json['hours']),
    );
  }
  String get id => _docId;
  String get content => _content;
  String get senderEmail => _senderEmail;
  String get receiverEmail => _receiverEmail;
  Date get date => _date;
  Time get time => _time; 
}