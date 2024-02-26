import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uni/Models/Publication.dart';
import 'package:uni/dbhelper/helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchString = "Sarkar R.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase().getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  var totalData = snapshot.data.length;
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
            }),
      ),
    );
  }

  buildBody(var totalData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search By",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget displayPubs(Publication data) {
    return Card(
      child: Column(
        children: [
          Text("${data.authors?.a1},${data.affiliations?.af1}"),
          Text("${data.authors?.a2},${data.affiliations?.af2}"),
          Text("${data.authors?.a3},${data.affiliations?.af3}"),
          Text("${data.authors?.a4},${data.affiliations?.af4}"),
          Text("${data.title}")
        ],
      ),
    );
  }
}
