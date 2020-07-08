import 'package:flutter/material.dart';
import 'package:udemychatapp/pages/sgininPage.dart';
import 'package:udemychatapp/pages/signupPage.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool shoeSignIn = true;
  void toggeld(){
    setState(() {
      shoeSignIn = false;
    });
  }
  @override
  Widget build(BuildContext context) {
     if(shoeSignIn){
       return SigInPage(toggeld:toggeld);
     }else{
       return Register(toggeld:toggeld);
     }
  }
}
