import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore{
  static FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;

  static Future<void> addUser() async{
    final userRef = await _firebaseInstance.collection("user").add({
      "name":"nanasi",
      "imagePath":"https://assets.st-note.com/production/uploads/images/33258191/26e72cd1c817d16409230ea54273d3f2.png?width=330&height=240&fit=bounds"
    });
  }
}