import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class gridview extends StatefulWidget {
  final String title;


  gridview({Key key, this.title}) : super(key: key);

  @override
  gridviewState createState() => gridviewState();
}

class gridviewState extends State<gridview> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GridView"),),
      body:_body() ,
    );
  }

  _body() {
    return Container(
      child: Container(
          padding: EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemBuilder: (BuildContext context, int index){
              return Image.network(images[index]);
            },
          )),
    );
  }
}
