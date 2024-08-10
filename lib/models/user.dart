import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  late final String _email;
  late final String _password;
  late final String _name;
  late final String _docId;
  AppUser({required String name,required String email,required String password,required docId}){
    _email = email;
    _password = password;
    _name = name;
    _docId = docId;
  }
  factory AppUser.fromFirebaseJson(QueryDocumentSnapshot json,String docId){
    return AppUser(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      docId: docId,
    );
  }
  factory AppUser.fromDataBaseJson(Map json){
    return AppUser(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      docId: json['id'],
    );
  }
  @override
  String toString(){
    return 'name : $name\nemail : $email\npassword : $password\nid : $_docId';
  }
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get docId => _docId;
}