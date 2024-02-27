import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PublicationDetails extends StatelessWidget {
  PublicationDetails({this.data});
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publication Details"),
      ),

      body: Column(
        children: [
          Text("Title - ${data.title}")
        ],
      ),
    );
  }
}
