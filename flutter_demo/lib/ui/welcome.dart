import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/chat.dart';
import 'package:flutter_demo/ui/dashboard.dart';
import 'package:flutter_demo/ui/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UserDTO.dart';
import 'firebaseAuth.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyWelcomePage(),
    );
  }
}

class MyWelcomePage extends StatefulWidget {
  final String id;

  MyWelcomePage({Key key, this.id}) : super(key: key);

  @override
  _MyWelcomeRegState createState() => _MyWelcomeRegState();
}

class _MyWelcomeRegState extends State<MyWelcomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
   int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover)
      ),
      child: ClipRRect(

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text("Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
    Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover)
      ),
      child: ClipRRect(

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text("Chat",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
    Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover)
      ),
      child: ClipRRect(

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text("Notifications",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
    Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover)
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text("Search",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    )

  ];

  void _onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard, color: Colors.blue),
                label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.blue), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.blue),
                label: "Notifications"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.blue), label: "Search"),
          ],
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: Text("Dashboard"),
                leading: Icon(Icons.dashboard, color: Colors.blue),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => dashboard()));
                },
              ),
              ListTile(
                title: Text("Chat"),
                leading: Icon(Icons.chat, color: Colors.blue),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => chat()));
                  }
              ),
              ListTile(
                title: Text("Call"),
                leading: Icon(Icons.call, color: Colors.blue),
              ),
              ListTile(
                title: Text("Setting"),
                leading: Icon(Icons.settings, color: Colors.blue),
              ),
              ListTile(
                  title: Text("Edit Profile"),
                  leading: Icon(Icons.person_rounded, color: Colors.blue),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => edit_profile()));
                  }),
              ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout, color: Colors.blue),
                  onTap: () {
                    _logout();
                    //Navigator.pop(context);
                  }),
            ],
          ),
        ),
      body: Container(
        child: Center(
          child:  _widgetOptions.elementAt(_selectedIndex),
        )
        ,)
    ),
    );
  }
  void _logout() async{
    await _auth.signOut();
    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
