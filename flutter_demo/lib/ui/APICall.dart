import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Product.dart';
List<Product> data = [];
var url = "https://gfioehu47k.execute-api.us-west-1.amazonaws.com/staging/main";

class APICall extends StatefulWidget {
  final String title;


  APICall({Key key, this.title}) : super(key: key);

  @override
  APICallState createState() => APICallState();
}

class APICallState extends State<APICall> {

  List<Product> product = new List();
  final _apiGatewayURL = "https://gfioehu47k.execute-api.us-west-1.amazonaws.com/staging/main";

  @override
  void initState() {
    super.initState();
    http.get(this._apiGatewayURL)
        .then((response) => response.body)
        .then(json.decode)
        .then((movies) {
      movies.forEach(_addMovie);
    });

  }

  void _addMovie(dynamic product){
    this.product.add(Product(
      title: product["title"],
      overview: product["overview"],
      poster_path: product["poster_path"],
      release_date: product["release_date"]
    ));
    print(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Data"),),
      body: _body(),
    );
  }

   _body() {
    return ListView.builder(padding: EdgeInsets.all(10),itemCount:product.length,
        itemBuilder: (context,i){
          return Card(
            child: new Container(
              margin: EdgeInsets.all(5),
              child: new Row(
                children: [
                  Align(
                    child: Image.network("https://image.tmdb.org/t/p/w500"+product[i].poster_path, width: 100, height: 100,),
                    alignment: Alignment.center,
                  ),
                  Flexible(flex: 4,fit:FlexFit.loose,child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: Container(
                        padding: EdgeInsets.all(3),
                        child: Text(product[i].title),
                      ),flex: 1,),
                      Flexible(child: Text(product[i].overview),flex: 2,),
                      Flexible(child: Text(product[i].release_date),flex: 1)
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
