import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yearly Publications Graph',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YearlyPublicationsPage(),
    );
  }
}

class YearlyPublicationsPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yearly Publications Graph'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getDataFromMongoDB(),
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
    );
  }

  Future<List<Map<String, dynamic>>> _getDataFromMongoDB() async {
    final database = await Db.create(
      'mongodb+srv://debjitfirstname:Debjit2635@cluster0.9sj6ekf.mongodb.net/uni');
    await database.open();

    final publications = database.collection('uni');
    final cursor = publications.find();

    final List<Map<String, dynamic>> allPublications = await cursor.toList();

    // Process the data to count publications yearly
    Map<int, int> yearlyCounts = {};
    for (final publication in allPublications) {
      final int year = publication['Year'];
      yearlyCounts.update(year, (value) => value + 1, ifAbsent: () => 1);
    }

    // Prepare data for graph
    List<Map<String, dynamic>> yearlyData = [];
    yearlyCounts.forEach((year, count) {
      yearlyData.add({'year': year, 'count': count});
    });

    return yearlyData;
  }

 Widget _buildGraph(List<Map<String, dynamic>> data) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: BarChart(
      BarChartData(
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
              bottomTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
      )
    )
  );
}





  double _getMaxCount(List<Map<String, dynamic>> data) {
    int maxCount = 0;
    for (final entry in data) {
      if (entry['count'] > maxCount) {
        maxCount = entry['count'];
      }
    }
    return (maxCount * 1.2).toDouble(); // Add some padding to the top
  }
}
