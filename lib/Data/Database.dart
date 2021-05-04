import 'package:firebase_database/firebase_database.dart';

class Database{
  static DatabaseReference database=FirebaseDatabase.instance.reference().child("Stories");

  static DatabaseReference TableUser = database.child("User");
  static DatabaseReference TableStory = database.child("Story");
  
}