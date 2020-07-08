import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:udemychatapp/helper/helperfunctions.dart';
import 'package:udemychatapp/model/userModel.dart';

class AuthProvider {
  FirebaseUser user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password , String username , File image) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);


      FirebaseUser user = result.user;
      //add ppic
      final StorageReference storageReference =  FirebaseStorage.instance
      .ref().child('user_ppic')
      .child(user.uid);

      final StorageUploadTask uploadTask =  storageReference.putFile(image);

      final StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      final mediaUrl = await taskSnapshot.ref.getDownloadURL();
      ///

      ///

      Firestore.instance.collection('user')
          .document(user.uid)
      .setData({
        'email':email,
        'username':username,
        'mediaUrl':mediaUrl
      });
      ///
      ///
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future singInWithEmailAndPassword(String email, String password  ) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      ///
      ///

      FirebaseUser user = result.user;
      ///
      ///

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Stream<User> get usere {
    return _auth.onAuthStateChanged.map( _userFromFirebase);
  }
}
