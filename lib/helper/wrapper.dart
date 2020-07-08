import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemychatapp/auths/auth_provider.dart';
import 'package:udemychatapp/helper/authenticate.dart';
import 'package:udemychatapp/model/userModel.dart';
import 'package:udemychatapp/pages/schatRoomScreen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
  final user =   Provider.of<User>(context);
     if(user != null){
       return ChatRoom();
     }else{
       return Authenticate();
     }
  }
}
