import 'package:flutter/material.dart';

class QueryResultPage extends StatelessWidget {
  QueryResultPage(this.message);
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results")),
      body: Column(children: [
        Text(message)
      ]),
    );
  }
}
