import 'package:cloud_firestore/cloud_firestore.dart';

/// if things go wrong then remember sharedpreference
class DataBaseMethod {
  getUserForSearch(String userName) async {
    return await Firestore.instance
        .collection("user")
        .where('username', isGreaterThanOrEqualTo: userName)
        .getDocuments();
  }

  getUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection("user")
        .where('email', isGreaterThanOrEqualTo: userEmail)
        .getDocuments();
  }

  setConversationCollection(String userName, chatData) {
    Firestore.instance.collection("chats").document(userName).setData(chatData);
  }

  setConversationInConversationCollection(String chatId, messageMap) {
   Firestore
   .instance
       .collection("chats")
       .document(chatId)
       .collection('conversation')
       .add(messageMap);
  }
  getConversationInConversationCollection(String chatId) async{
   return await Firestore
        .instance
        .collection("chats")
        .document(chatId)
    .collection("conversation")
   .orderBy('timestamp' , descending: true)
        .snapshots();
  }
  
  getUserFromChatsCollectionsSoWeCanShoeItInListWhenAppStarts(String userName) async{
  return await Firestore.instance
        .collection('chats')
        .where('users' , arrayContains:  userName)
    .snapshots();
  }


}
