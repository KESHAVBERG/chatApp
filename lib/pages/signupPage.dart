import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:udemychatapp/auths/auth_provider.dart';
import 'package:udemychatapp/helper/helperfunctions.dart';
import 'package:udemychatapp/pages/schatRoomScreen.dart';

class Register extends StatefulWidget {
  final Function toggeld;

  const Register({Key key, this.toggeld}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final StorageReference storageReference = FirebaseStorage.instance.ref();
  File image;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  String mediaUrl;
  final AuthProvider _auth = AuthProvider();

  getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
  }

  addPic() {
    return image == null
        ? Container(
            child: GestureDetector(
              onTap: () => getImage(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Add your profile pic'),
                ],
              ),
            ),
          )
        : Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: FileImage(image))),
          );
  }

  @override
  Widget build(BuildContext context) {
//    var user = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(50),
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    addPic(), //to add pic
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: userNameEditController,
                      decoration: InputDecoration(hintText: 'name'),
                    ), //for name
                    TextFormField(
                      validator: (val) => val.isNotEmpty && val.contains("@")
                          ? null
                          : 'enter a vaild email',
                      controller: emailEditController,
                      decoration: InputDecoration(hintText: 'email'),
                    ), //for email
                    TextFormField(
                      validator: (val) => val.isEmpty && val.length < 3
                          ? 'enter a vaild password'
                          : null,
                      controller: passwordEditingController,
                      decoration: InputDecoration(hintText: 'password'),
                    ), //for password
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formkey.currentState.validate()) {
                          HelperFunctions.saveUserEmailSharedPreference(
                              emailEditController.text);
                          HelperFunctions.saveUserUserNameSharedPreference(
                              userNameEditController.text);

                          ///
                          ///
                          dynamic result = _auth.registerWithEmailAndPassword(
                              emailEditController.text,
                              passwordEditingController.text,
                              userNameEditController.text,
                              image);

                          ///
                          ///
                          HelperFunctions.saveUserLoggedInSharedPreference(
                              true);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom()));

                          //dynamic result = AuthProvider().registerWithEmailAndPassword(email, password

                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          )),
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.toggeld();
                      },
                      child: Text('login'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
