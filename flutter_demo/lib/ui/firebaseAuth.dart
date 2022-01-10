import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user){
    return user!= null ? User(id:user.uid) : null;
  }

  Future SignIn (String email,String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){

    }
  }

  Future SignUp (String email,String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUseruser = result.user;
      return _userFromFirebaseUser(firebaseUseruser);
    }catch(e){

    }
  }
}

class User{
  String id;
  User({this.id});
}

class DatabaseMethods{
  getUserByName(){
      return Firestore.instance.collection("users").getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap);
  }

  creatChatRoom(String chatRoomId,chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap);
  }
}
