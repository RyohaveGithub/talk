import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:talk/model/message.dart';

class TalkRoom extends StatefulWidget {
  final String name;

  TalkRoom(this.name);

  @override
  _TalkRoomState createState() => _TalkRoomState();
}

class _TalkRoomState extends State<TalkRoom> {
  List<Message> messageList=[
    Message(
        message: 'はいよ',
        isMe: true,
        sendTime: DateTime(2021,1,1,12,12)
    ),
    Message(
        message: 'いいよ',
        isMe: false,
        sendTime: DateTime(2021,1,2,13,14)
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title:Text(widget.name)
      ),
      body:ListView.builder(
          physics: RangeMaintainingScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: messageList.length,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.only(top:10,left:10,right:10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: messageList[index].isMe? TextDirection.rtl:TextDirection.ltr,
            children: [
              Container(
                  //メッセージが画面横幅の0.７倍で折り返される
                  constraints:BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.7),
                  padding:EdgeInsets.symmetric(horizontal: 10,vertical:6),
                  decoration: BoxDecoration(
                      color: messageList[index].isMe? Colors.green:Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(messageList[index].message)
              ),
              Text(intl.DateFormat("HH:mm").format(messageList[index].sendTime),style: TextStyle(fontSize: 12),)
            ],
          ),
        );
      }
      )
    );
  }
}
