import 'package:fl_chart/fl_chart.dart';
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
        child: Column(
          children: [
            FutureBuilder(
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: MongoDatabase().getDataFromMongoDB(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error fetching data');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  return _buildGraph(snapshot.data!);
                }
              },
            ),
          ],
        ),
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
          SizedBox(
            height: 35,
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 10)),
                  child: Center(
                      child: Text(
                    totalData.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  )),
                ),
                SizedBox(height: 20),
                Text(
                  "Total Publications",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGraph(List<Map<String, dynamic>> data) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 2,
          child: BarChart(BarChartData(
            barGroups: List.generate(
              data.length,
              (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: data[index]['count'].toDouble(),
                  ),
                ],
              ),
            ),
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value >= 0 && value < data.length) {
                    return Text(data[value.toInt()]['year'].toString());
                  }
                  return Text("");
                },
              )),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
            ),
          )),
        ));
  }
}
