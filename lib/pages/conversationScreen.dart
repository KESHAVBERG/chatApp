import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udemychatapp/database/database.dart';
import 'package:udemychatapp/helper/constants.dart';

class ConversationScreen extends StatefulWidget {
  final String chatId;

  const ConversationScreen({Key key, this.chatId}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageEditController = TextEditingController();
  DataBaseMethod db = DataBaseMethod();
  Stream chatMessageStream;
  Widget ChatMessaheShown(){
    return StreamBuilder(
      stream: Firestore.instance.collection("chats")
      .document(widget.chatId)
      .collection("conversation")
      .snapshots(),
      builder: (context , snapshot){
        return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context , index){
              return ShowTextMessageTile(
                message: snapshot.data.documents[index].data['message'],
                sendIsMe: snapshot.data.documents[index].data['senderName'] == Constants.userName,
              );
            }):Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(100),
                  child: CircularProgressIndicator(),);
              },
            );
  }

  addChatToFirebase() {
    Map<String, dynamic> messageMap = {
      'senderName': Constants.userName,
      'message': messageEditController.text,
      'timestamp':DateTime.now().toUtc(),
    };
    db.setConversationInConversationCollection(widget.chatId, messageMap);
    Future.delayed(Duration(milliseconds: 1))
        .then((_) => messageEditController.clear());
  }


@override
  void initState() {
    db.getConversationInConversationCollection(widget.chatId)
    .then((val){
      chatMessageStream = val;
    });
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: messageEditController,
          decoration: InputDecoration(
              hintText: "message.....",
              suffixIcon: IconButton(
                onPressed: () => addChatToFirebase(),
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
              )),
        ),
      ),
      body:ChatMessaheShown() ,
    );
  }
}
class ShowTextMessageTile extends StatelessWidget {
  final String   message;
  final bool sendIsMe;

  const ShowTextMessageTile({Key key, this.sendIsMe ,this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      //

      //
      padding: EdgeInsets.only(bottom: 5),
      //
      //
      width: MediaQuery.of(context).size.width,
      //
      //
      alignment: sendIsMe?Alignment.centerRight:Alignment.centerLeft,
      //
      //
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          color: sendIsMe? Colors.blue:Colors.yellow,
          borderRadius:sendIsMe? BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.elliptical(2,3)
          ):BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
             bottomRight : Radius.circular(20),
            bottomLeft: Radius.elliptical(2,3)
          )
        ),
        child: Text('${message}',style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}
