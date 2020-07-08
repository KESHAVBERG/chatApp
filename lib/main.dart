import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemychatapp/auths/auth_provider.dart';
import 'package:udemychatapp/helper/authenticate.dart';
import 'package:udemychatapp/helper/helperfunctions.dart';
import 'package:udemychatapp/helper/wrapper.dart';
import 'package:udemychatapp/model/userModel.dart';
import 'package:udemychatapp/pages/schatRoomScreen.dart';

void main() => runApp(MyApp());

//class MyApp extends StatefulWidget {
//  // This widget is the root of your application.
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  bool isLoggedIn ;
//  @override
////  getLogedIn() async{
////    await HelperFunctions.getUserLoggedInSharedPreference()
////    .then((value) {
////      setState(() {
////        isLoggedIn = value;
////      });
////    });
////  }
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
////     home:isLoggedIn != null?isLoggedIn ? ChatRoom():Authenticate():null,
//    );
//  }
//}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthProvider().usere,
      child: MaterialApp(
        home:Wrapper() ,
      ),
    );
  }
}
