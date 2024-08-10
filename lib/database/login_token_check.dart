import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:my_app/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
Future<Database> initcheckdatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> questionsdata = openDatabase(
  join(await getDatabasesPath(),'check.db'),
  onCreate: (db,version){
    return db.execute("CREATE TABLE IF NOT EXISTS userin (email varchar(50),password varchar(50),id varchar(50),name varchar(50))");
  },
  version: 1
  );
  return questionsdata;
}
Future<void> inserttocheckdatabase(AppUser user) async {
  final Database db = await initcheckdatabase();
  db.insert('userin',{"email":user.email,"password":user.password,"id":user.docId,"name" : user.name},conflictAlgorithm: ConflictAlgorithm.replace);
}
Future<AppUser?> fetchcheck() async {
  final Database db = await initcheckdatabase();
  final List<Map> maps = await db.query('userin');
  if(maps.isEmpty){
    return null;
  }
  else{
    return AppUser.fromDataBaseJson(maps[0]);
  }
}
void resetcheckdatabase() async {
  final Database db = await initcheckdatabase();
  db.execute("DELETE FROM userin");
}