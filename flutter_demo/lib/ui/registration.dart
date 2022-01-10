import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/firebaseAuth.dart';
import 'package:flutter_demo/ui/main.dart';
import 'package:flutter_demo/ui/welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';

class registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyRegPage(),
    );
  }
}

class MyRegPage extends StatefulWidget {
  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyRegPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  auth firebasemethods = new auth();
  DatabaseMethods databaseMethods = new DatabaseMethods();

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
                    "SignUp",
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
                      "Already Have an account?SignIn Now",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
                        child: RaisedButton(
                          color: Colors.white,
                          hoverColor: Colors.black,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _registeruser();
                            }
                          },
                          child: Text("REGISTER",
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

  void _registeruser() async {
    try {
      Map<String, String> userInfo = {"email": emailcontroller.text,
        "name": "devangi"};

      firebasemethods.SignUp(emailcontroller.text, passcontroller.text).then((value){
              databaseMethods.uploadUserInfo(userInfo);
              Navigator.push(context, MaterialPageRoute(builder: (context) => welcome()));
        });

    } catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
        print('The account already exists for that email.');
      } else if (e.code == "invalid-email") {
        Fluttertoast.showToast(msg: "The email address is badly formatted.");
        print("The email address is badly formatted.");
      }
    }
  }
}
