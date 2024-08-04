import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  late final String _email;
  late final String _password;
  late final String _name;
  AppUser({required String name,required String email,required String password}){
    _email = email;
    _password = password;
    _name = name;
  }
  factory AppUser.fromFirebaseJson(QueryDocumentSnapshot json){
    return AppUser(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
  String get email => _email;
  String get password => _password;
  String get name => _name;
}