import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/DatabaseHelper.dart';
import 'package:flutter_demo/ui/person.dart';

class sqliteUI extends StatefulWidget {
  @override
  sqliteUIState createState() => sqliteUIState();
}

class sqliteUIState extends State<sqliteUI> {

  final dbHelper = DatabaseHelper.instance;

  List<person> persons = [];
  List<person> personsByName = [];

  //controllers used in insert operation UI
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  //controllers used in update operation UI
  TextEditingController idUpdateController = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController ageUpdateController = TextEditingController();

  //controllers used in delete operation UI
  TextEditingController idDeleteController = TextEditingController();

  //controllers used in query operation UI
  TextEditingController queryController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 5, child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(bottom: TabBar(tabs: [
        Tab(child: Text("Insert"),),
        Tab(child: Text("View"),),
        Tab(child: Text("Update"),),
        Tab(child: Text("Delete"),)
      ],),title: Text("Sqlite"),),
      body: _body(),
    ));
  }

  _body() {

  }
}
