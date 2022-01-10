

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DatePicker extends StatefulWidget {
  final String title;


  DatePicker({Key key, this.title}) : super(key: key);

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DatePicker"),),
      body:/*WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://flutter.dev",
      )*/ _body() ,
    );
  }


  _body() {
    return Container(
      margin: EdgeInsets.all(10),
      child:/*Container(
        height: 100,
        width: 100,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: *//*WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://flutter.dev",
        )*//*,
      ) */Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Select Date :",style: TextStyle(fontSize: 20)),
          Text("${selectedDate.toLocal()}".split(' ')[0],style: TextStyle(fontSize: 20)),
          InkWell(onTap:()=> _openDatePicker(context),
            child:Icon(Icons.calendar_today_sharp,color: Colors.blue),),
        ],
      ),
    );
  }

  Future<void> _openDatePicker(BuildContext context) async{

    var datepicker = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2021,4), lastDate: DateTime(3000));
    if(datepicker != null && datepicker != selectedDate){
      setState(() {
        selectedDate = datepicker;

      });
    }
  }
}
