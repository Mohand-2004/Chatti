import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections{
  chats,
  massages,
  users,
}
CollectionReference fireUsers = FirebaseFirestore.instance.collection(FirebaseCollections.users.name);
CollectionReference fireMassages = FirebaseFirestore.instance.collection(FirebaseCollections.massages.name);
CollectionReference fireChats = FirebaseFirestore.instance.collection(FirebaseCollections.chats.name);