import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talk/model/talk_room.dart';
import 'package:talk/model/user.dart';
import 'package:talk/utils/shared_prefs.dart';

class Firestore {
  static FirebaseFirestore _firebaseInstance = FirebaseFirestore.instance;
  static final userRef = _firebaseInstance.collection("user");
  static final roomRef = _firebaseInstance.collection("room");
  

  static Future<void> addUser() async {
    try {
      final newDoc = await userRef.add({
        "name": "nanasi",
        "imagePath": "https://assets.st-note.com/production/uploads/images/33258191/26e72cd1c817d16409230ea54273d3f2.png?width=330&height=240&fit=bounds"
      });
      print("アカウント作成完了");

      // print(newDoc.id);
      await SharedPrefs.setUid(newDoc.id);
      // String? uid = SharedPrefs.getUid();
      // print(uid);

      List<String>userIds = await getUser();
      userIds.forEach((user) async {
        if (user != newDoc.id) {
          await roomRef.add({
            "joined_user_ids": [user, newDoc.id],
            "updated_time": Timestamp.now()
          });
        }
      });
      print("ルーム作成完了");
    } catch (e) {
      print("失敗しました ---$e");
    }
  }

  static Future<List<String>> getUser() async {
    try {
      final snapshot = await userRef.get();
      List<String> userIds = [];

      snapshot.docs.forEach((user) {
        userIds.add(user.id);
        // print("ドキュメントID:${user.id}---名前:${user.data()["name"]}");
      });
      print("アカウント作成が完了");
      return userIds;
    } catch (e) {
      print("取得失敗 ---$e");
      return null;
    }
  }

  static Future<User> getProfile(String uid) async {
    final profile = await userRef.doc(uid).get();
    User myProfile = User(
      name: profile.data()["name"],
      imagePath: profile.data()["image_path"],
      uid: uid,
    );
    return myProfile;
  }

  static Future<List<TalkRoom>> getRooms(String myUid) async {
    final snapshot = await roomRef.get();
    List<TalkRoom> roomList = [];
    await Future.forEach(snapshot.docs, (doc) async {
      if (doc.data()["joined_user_ids"].contains(myUid)) {
        String yourUid;
        doc.data()["joined_user_ids"].forEach((id) {
          if (id != myUid) {
            yourUid = id;
            return;
          }
        });
        print(yourUid);
        User yourProfile = await getProfile(yourUid);
        print(yourProfile);
        TalkRoom room = TalkRoom(
            talkUser: yourProfile,
            roomId: doc.id,
            lastMessage: doc.data()["last_message"] ?? ""
        );

        roomList.add(room);
      }
    });
    print(roomList.length);
    return roomList;
  }
}