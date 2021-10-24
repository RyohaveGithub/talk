import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talk/model/user.dart';
import 'package:talk/pages/settings_profile.dart';
import 'package:talk/pages/talk_room.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList =[
    User(
        name: '田中',
        uid: 'abc',
        imagePath: 'https://assets.st-note.com/production/uploads/images/33258191/26e72cd1c817d16409230ea54273d3f2.png?width=330&height=240&fit=bounds',
        lastMessage: 'こんにちは'
    ),
    User(
        name: '小林',
        uid: 'def',
        imagePath: 'https://cbtdev.net/wp-content/uploads/2020/06/udemy-flutter-300x158.png',
        lastMessage: 'ありがとう'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("チャットアプリ"),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsProfilePage()));
            },
          )
        ],
      ),
      body:ListView.builder(
          itemCount: userList.length,
          itemBuilder:(context,index){
            return InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TalkRoom(userList[index].name)));
              },
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userList[index].imagePath),
                        radius: 30,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userList[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text(userList[index].lastMessage,style: TextStyle(color: Colors.grey),),
                      ],
                    )
                  ],
                ),
              ),
            );
    }
    ),
    );
  }
}
