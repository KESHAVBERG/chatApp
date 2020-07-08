import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemychatapp/auths/auth_provider.dart';
import 'package:udemychatapp/database/database.dart';
import 'package:udemychatapp/helper/constants.dart';
import 'package:udemychatapp/helper/helperfunctions.dart';
import 'package:udemychatapp/pages/conversationScreen.dart';
import 'package:udemychatapp/pages/search.dart';
import 'package:udemychatapp/pages/sgininPage.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthProvider _auth = AuthProvider();
  DataBaseMethod db = DataBaseMethod();
Stream chatListStream;

  Widget chatList(){
    return StreamBuilder(
      stream: chatListStream,
      builder: (context , snapshot){
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context , index){
            return ChatListTile(
              senderName:snapshot.data.documents[index].data['catID']
              .toString().replaceAll("_", '').replaceAll(Constants.userName, ""),
              chatRoomId:snapshot.data.documents[index].data['catID'] ,
            );
          },
        ):Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();


    // TODO: implement initState
    super.initState();
  }

  getUserInfo() async {
    Constants.userName =
        await HelperFunctions.getUserUserNameSharedPreference();

      db.getUserFromChatsCollectionsSoWeCanShoeItInListWhenAppStarts(
          Constants.userName)
          .then((val) {
        setState(() {
          chatListStream = val;
        });
      });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('appbar'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SigInPage()));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search())),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
      body: chatList(),
    );
  }
}
class ChatListTile extends StatelessWidget {
  final String senderName , chatRoomId;

  const ChatListTile({Key key, this.senderName , this.chatRoomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatId: chatRoomId,)
        ));
      } ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Card(
          child: Text("${senderName}" , style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),),
        ),
      ),
    );
  }
}
