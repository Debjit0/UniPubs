import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uni/dbhelper/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  return buildBody(totalData);
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
            "Statistics",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 35,),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(width: 10)),
                  child: Center(child: Text(totalData.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),)),
                ),
                SizedBox(height: 20),
                Text("Total Publications", style: TextStyle(fontSize: 20),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
