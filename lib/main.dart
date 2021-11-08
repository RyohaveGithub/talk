import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talk/pages/top_page.dart';
import 'package:talk/utils/firebase.dart';
import 'package:talk/utils/shared_prefs.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.setInstance();
  checkAccount();
  runApp(const MyApp());
}

  Future<void> checkAccount()async{
    String uid = SharedPrefs.getUid();
    if(uid == "") {
      Firestore.addUser();
    }
  }


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TopPage(),
    );
  }
}

//todo IOS非対応