import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserDTO.dart';

class dashboard extends StatefulWidget {
  final String title;

  dashboard({Key key, this.title}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    List<UserDTO> list = [];

    list.add(new UserDTO("name", "Ahm", Icons.add));
    list.add(new UserDTO("name1", "Rjt", Icons.add_alert));
    list.add(new UserDTO("name2", "Baroda", Icons.sanitizer));
    list.add(new UserDTO("name3", "Surat", Icons.save));

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            margin: EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(list[index].name),
                    leading: Icon(list[index].icon),
                    subtitle: Text(list[index].city),
                  ),
                );
              },
            ),
          )),
    );
  }
}
