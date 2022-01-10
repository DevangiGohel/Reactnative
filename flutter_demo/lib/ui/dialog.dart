import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dialog extends StatefulWidget {
  @override
  dialogState createState() => dialogState();
}

class dialogState extends State<dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("dialog")),
      body: Center(
        child: RaisedButton(
          child: Text("click me"),
          onPressed: () {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Dialog'),
                    content: TextField(
                      decoration: InputDecoration(hintText: "Enter here.."),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
