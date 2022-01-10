import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/chatScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebaseAuth.dart';


var id;
class chat extends StatefulWidget {
  final String title;

  chat({Key key, this.title}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<chat> {

  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> usersList;
  final CollectionReference _collectionReference = Firestore.instance.collection("users");
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {

    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() async{

        usersList = datasnapshot.documents;
        print("Users List ${usersList.length}");
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: _body(),
    );
  }

  _body() {
    if(usersList!= null){
      return Container(
          padding: EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: (context,index){
          return Card(
            elevation: 5,
            child: ListTile(
              onTap: _chatScreen(usersList[index].data["email"]),
              contentPadding: EdgeInsets.all(5),
              title: Text(usersList[index].data["email"]),
            ),
          );
        },itemCount: usersList.length,),
      );
    }
  }

  _chatScreen(String email) {
    List<String> users = [email,"name"];
    String chatRoomId = getChatRoomId("name",email);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };
    databaseMethods.creatChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => chatScreen()));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


}
