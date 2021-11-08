import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:talk/model/message.dart';

class TalkRoomPage extends StatefulWidget {
  final String name;

  TalkRoomPage(this.name);

  @override
  _TalkRoomPageState createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
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
      body:Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom:60.0),
            child: ListView.builder(
                physics: RangeMaintainingScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: messageList.length,
                itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(top:10,left:10,right:10,bottom: index == 0? 10:0 ),
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
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  //ExpandedがないとTextFieldが画面幅いっぱいまで広がる性質があるのでエラーが出る
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                          border: OutlineInputBorder()
                    ),
                  ),
                      )),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: () {  },
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
