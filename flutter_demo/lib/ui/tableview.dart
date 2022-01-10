import 'package:flutter/material.dart';

class tableView extends StatefulWidget {
  @override
  tableViewState createState() => tableViewState();
}

class tableViewState extends State<tableView> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Table view'),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Column(children: [
                    SizedBox(height: 10),
                    Icon(
                      Icons.account_box,
                      size: iconSize,
                    ),
                    Text('My Account')
                  ]),
                  Column(children: [
                    SizedBox(height: 10),
                    Icon(
                      Icons.settings,
                      size: iconSize,
                    ),
                    Text('Settings')
                  ]),
                  Column(children: [
                    SizedBox(height: 10),
                    Icon(
                      Icons.lightbulb_outline,
                      size: iconSize,
                    ),
                    Text('Ideas')
                  ]),
                ]),
                TableRow(children: [
                  Icon(
                    Icons.cake,
                    size: iconSize,
                  ),
                  Icon(
                    Icons.voice_chat,
                    size: iconSize,
                  ),
                  Icon(
                    Icons.add_location,
                    size: iconSize,
                  ),
                ]),
                TableRow(children: [
                  Icon(
                    Icons.email,
                    size: iconSize,
                  ),
                  Icon(
                    Icons.check_circle,
                    size: iconSize,
                  ),
                  Icon(
                    Icons.account_tree,
                    size: iconSize,
                  ),
                ]),
              ],
            ),
          ),
        ])));
  }
}
