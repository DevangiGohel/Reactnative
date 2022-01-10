import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/APICall.dart';
import 'package:flutter_demo/ui/DatePicker.dart';
import 'package:flutter_demo/ui/dialog.dart';
import 'package:flutter_demo/ui/gridview.dart';
import 'package:flutter_demo/ui/registration.dart';
import 'package:flutter_demo/ui/NFC.dart';
import 'package:flutter_demo/ui/sqliteUI.dart';
import 'package:flutter_demo/ui/tableview.dart';
import 'package:flutter_demo/ui/welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebaseAuth.dart';


var id;
void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: dialog(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    /*Timer(
        Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => DatePicker())));*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  DatabaseMethods firebasemethods = new DatabaseMethods();
  auth authMethod = new auth();
  Map<String, String> userInfo;

  void _loginuser(context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (_formKey.currentState.validate()) {
        _auth
            .signInWithEmailAndPassword(
            email: emailcontroller.text, password: passcontroller.text)
            .then((value) {
              id = value.user.uid;
              preferences.setString("id", id);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => welcome()));
        });
      }
      /*final User user = (await _auth
              .signInWithEmailAndPassword(
                  email: emailcontroller.text, password: passcontroller.text)
              .catchError((err) {
        print(err);
      })).user;



      if (user != null) {
        print("welcome");
        Navigator.push(context, MaterialPageRoute(builder: (context) => welcome()));
      }*/
    } catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for this email.");
        print('No user found for this email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password.');
        print('Wrong password.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          constraints: new BoxConstraints.expand(
            height: double.infinity,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter EmailAddress';
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'EmailId',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Password';
                      } else if (value.length < 6) {
                        return 'Please enter at least 6 character for Password';
                      }
                      return null;
                    },
                    controller: passcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 20),
                  child: TextButton(
                    child: Text(
                      "Don't have account?Signup Now",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registration()));
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: ButtonTheme(
                        height: 50.0,
                        minWidth: 100.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.white,
                          hoverColor: Colors.black,
                          onPressed: () => _loginuser(context),
                          child: Text("LOGIN",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                        ))),
              ),
            ],
          ),
        ));
  }


}
