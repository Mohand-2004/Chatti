import 'package:my_app/models/user.dart';

class Chat{
  late final String _docId;
  late final AppUser _user;
  Chat({required String docId,required AppUser user}){
    _docId = docId;
    _user = user;
  }
  String get docId => _docId;
  AppUser get user => _user;
}