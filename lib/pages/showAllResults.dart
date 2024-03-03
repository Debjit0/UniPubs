import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni/dbhelper/helper.dart';
import 'package:uni/pages/publicationsdetails.dart';
import 'package:uni/pages/widget/pubcard.dart';

import '../Models/Publication.dart';

class showAllResults extends StatelessWidget {
  const showAllResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results")),
      body: SafeArea(child: FutureBuilder(
            future: MongoDatabase().searchAuthors2InUni(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  //var totalData = snapshot.data.length;
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayPubs(
                            Publication.fromJson(snapshot.data[index]));
                      });
                } else {
                  return Text("No data available");
                }
              }
            }),)
    );
  }

  
}