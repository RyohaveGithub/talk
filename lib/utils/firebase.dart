import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talk/utils/shared_prefs.dart';

class Firestore{
  static FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  static final userRef =  _firebaseInstance.collection("user");
  static final roomRef =  _firebaseInstance.collection("room");

  static Future<void> addUser() async{
    try{
      final newDoc = await userRef.add({
        "name":"nanasi",
        "imagePath":"https://assets.st-note.com/production/uploads/images/33258191/26e72cd1c817d16409230ea54273d3f2.png?width=330&height=240&fit=bounds"
      });
      print("アカウント作成完了");

      print(newDoc.id);
      await SharedPrefs.setUid(newDoc.id);
      String? uid = SharedPrefs.getUid();
      print(uid);

      List<String>? userIds = await getUser();
      userIds!.forEach((user) async {
        if(user != newDoc.id){
          await roomRef.add({
            "joined_user_ids":[user,newDoc.id],
            "updated_time":Timestamp.now()
          });
        }
      });
      print("ルーム作成完了");

    }catch(e){
      print("失敗しました ---$e");
    }

  }

  static Future<List<String>?> getUser() async{
    try{
      final snapshot = await userRef.get();
      List<String> userIds =[];

      snapshot.docs.forEach((user) {
        userIds.add(user.id);
        // print("ドキュメントID:${user.id}---名前:${user.data()["name"]}");
      });
      print("アカウント作成が完了");
      return userIds;
    }catch(e){
      print("取得失敗 ---$e");
      return null;
    }

  }
}