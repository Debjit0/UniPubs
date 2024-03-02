import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uni/dbhelper/helper.dart';
import 'package:uni/pages/globalData.dart';
import 'package:uni/pages/testing/graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    MongoDatabase().start();
  }

  //pie chart calculation
  Map<String, int> calculateDocumentTypeCounts() {
    Map<String, int> typeCounts = {
      'Article': 0,
      'Conference Paper': 0,
      'Journal': 0,
      'Book Chapter': 0,
      'Review': 0,
      'Erratum': 0,
      'Institute of Electrical and Electronics Engineers Inc.': 0,
      'Springer': 0,
      'wiley': 0,
      'Taylor and Francis Ltd.': 0,
      'Springer Science and Business Media Deutschland GmbH': 0,
      'Books and Journals Private Ltd.': 0,
      "Bentham Science Publishers": 0,
      'Editorial': 0
    };

    for (final document in allData) {
      final type = document['Document Type'];
      if (typeCounts.containsKey(type)) {
        typeCounts[type] = (typeCounts[type] ?? 0) + 1;
      }
    }
    print(typeCounts);
    return typeCounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              SizedBox(height:80),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: MongoDatabase().getDocumentTypeFromMongoDB(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error fetching data');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data available');
                  } else {
                    return buildPieChart(allData);
                  }
                },
              ),
              SizedBox(height:80),
            ],
          ),
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
          ),
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



  Widget buildPieChart(List<Map<String, dynamic>> data){
    return Container(
      height: 150,
      width: 100,
      child: Center(
        child: data.isNotEmpty
            ? PieChart(
                PieChartData(
                  sections: _buildPieChartSections(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 50,
                  sectionsSpace: 0,
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final Map<String, int> typeCounts = calculateDocumentTypeCounts();
    final List<PieChartSectionData> sections = [];

    typeCounts.forEach((type, count) {
      final double value = count.toDouble();
      sections.add(PieChartSectionData(
        color: _getColorForType(type),
        value: value,
        title: '$type\n$count',
        radius: 100,
        titleStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
      ));
    });

    return sections;
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'Article':
        return Colors.blue;
      case 'Conference Paper':
        return Colors.green;
      case 'Journal':
        return Colors.orange;
      case 'Book Chapter':
        return Colors.purple;
      case 'Review':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
