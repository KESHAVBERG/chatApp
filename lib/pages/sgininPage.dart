import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemychatapp/auths/auth_provider.dart';
import 'package:udemychatapp/database/database.dart';
import 'package:udemychatapp/helper/helperfunctions.dart';
import 'package:udemychatapp/pages/schatRoomScreen.dart';
import 'package:udemychatapp/pages/signupPage.dart';

class SigInPage extends StatefulWidget {
  final Function toggeld;

  const SigInPage({Key key, this.toggeld}) : super(key: key);

  @override
  _SigInPageState createState() => _SigInPageState();
}

class _SigInPageState extends State<SigInPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  AuthProvider _auth = AuthProvider();
  DataBaseMethod db = DataBaseMethod();
  QuerySnapshot snapshotUserInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Siginin',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
              ),
              TextFormField(
                controller: emailEditController,
                decoration: InputDecoration(hintText: 'email'),
              ),
              TextFormField(
                controller: passwordEditingController,
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('forgot password?'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: ()async {
                  if(_formkey.currentState.validate()){
                    // that is not saveUserUserNameSharedPreference but saveUserEmil

                    HelperFunctions.saveUserUserNameSharedPreference(emailEditController.text);
                    db.getUserEmail(emailEditController.text).then((val){
                      snapshotUserInfo = val;
                      HelperFunctions.saveUserUserNameSharedPreference(snapshotUserInfo.documents[0].data['username']);
                    });
                    _auth.singInWithEmailAndPassword(emailEditController.text, passwordEditingController.text).then((value) {
                      if(value != null){
                        HelperFunctions.saveUserLoggedInSharedPreference(true);
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoom()
                        ));
                      }
                    } );


                  }
                },
//                    db.getUserEmail(emailEditController.text).then((val) async{
//                      setState(() {
//                        snapshotUserInfo = val;
//                        HelperFunctions.saveUserEmailSharedPreference(
//                            snapshotUserInfo.documents[0].data['username']);
//                      });
//                    });
//                    HelperFunctions.saveUserLoggedInSharedPreference(true);
//
//                    Navigator.pushReplacement(context,
//                        MaterialPageRoute(builder: (context) => ChatRoom()));
//                  }
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text('Login')),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text('siginIn with google')),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text('register')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
