import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:uni/pages/globalData.dart';

class DocumentTypePieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const DocumentTypePieChart({Key? key, required this.data}) : super(key: key);

  Map<String, int> calculateDocumentTypeCounts() {
    Map<String, int> typeCounts = {
      'Article': 0,
      'Conference Paper': 0,
      'Journal': 0,
      'Book Chapter': 0,
      'Review': 0,
      'Erratum':0,
      'Institute of Electrical and Electronics Engineers Inc.':0,
      'Springer':0,
      'wiley':0,
      'Taylor and Francis Ltd.':0,
      'Springer Science and Business Media Deutschland GmbH':0,
      'Books and Journals Private Ltd.':0,
      "Bentham Science Publishers":0,
      'Editorial':0

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
    return Center(
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
