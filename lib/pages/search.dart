import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemychatapp/database/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemychatapp/helper/constants.dart';
import 'package:udemychatapp/pages/conversationScreen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchEditController = TextEditingController();
  DataBaseMethod db = DataBaseMethod();
  QuerySnapshot snapshot;

  createChatRoom({String userName}) {
    String chatRoomId = getChatRoomId(userName , Constants.userName);

   if(userName != Constants.userName){
     List<String> users = [userName , Constants.userName];
     Map<String , dynamic> chatRoomMap = {
       'users':users,
       'catID':chatRoomId
     };
     db.setConversationCollection(chatRoomId , chatRoomMap);
     Navigator.push(context, MaterialPageRoute(
         builder: (context) => ConversationScreen(
           chatId: chatRoomId,
         )
     ));
   }
  }

  clear() {
    Future.delayed(Duration(milliseconds: 1)).then((_) {
      searchEditController.clear();
    });
  }

  initiatrSearch() {
    db.getUserForSearch(searchEditController.text).then((val) {
      print(val.toString());
      setState(() {
        snapshot = val;
      });
    });
  }

  showResult() {
    return snapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.documents.length,
            itemBuilder: (context, index) {
              return SearchTile(
                imageUrl: snapshot.documents[index].data['mediaUrl'],
                email: snapshot.documents[index].data['email'],
                name: snapshot.documents[index].data['username'],
              );
            },
          )
        : Container();
  }

  Widget SearchTile({String name , String email , String imageUrl}){
    return Container(
      child: ListTile(
        leading: CircleAvatar(
            radius: 20, backgroundImage: CachedNetworkImageProvider(imageUrl)),
        title: Text(name),
        subtitle: Text(email),
        trailing: FlatButton(
          onPressed: () {
            createChatRoom(
              userName: name
            );
          },
          color: Colors.blue,
          child: Text('message'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Container(
          color: Colors.white.withOpacity(0.1),
          child: TextFormField(
            controller: searchEditController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {
                    initiatrSearch();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ),
      body: showResult(),
    );
  }
  getChatRoomId(String a , String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";

    }
  }
}
//createChatRoom({String userName , BuildContext context}) {
//  List<String> users = [userName , Constants.userName];
//  String chatRoomId = getChatRoomId(userName , Constants.userName);
//  Map<String , dynamic> chatRoomMap = {
//    'users':users,
//    'catID':chatRoomId
//  };
//  DataBaseMethod().setConversationCollection(chatRoomId , chatRoomMap);
//  Navigator.push(context, MaterialPageRoute(
//      builder: (context) => ConversationScreen()
//  ));
//}


//class SearchTile extends StatelessWidget {
//  final String imageUrl, name, email;
//
//  const SearchTile({Key key, this.imageUrl, this.name, this.email})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: ListTile(
//        leading: CircleAvatar(
//            radius: 20, backgroundImage: CachedNetworkImageProvider(imageUrl)),
//        title: Text(name),
//        subtitle: Text(email),
//        trailing: FlatButton(
//          onPressed: () {
//            createChatRoom(
//              userName: name,
//              context: context,
//            );
//          },
//          color: Colors.blue,
//          child: Text('message'),
//        ),
//      ),
//    );
//  }
//}
