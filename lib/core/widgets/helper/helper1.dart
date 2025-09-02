// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// class GrowthTrendsScreen extends StatelessWidget {
//   const GrowthTrendsScreen({super.key});
//
//   final List<Map<String, dynamic>> data = const [
//     {"year": "2014", "interestCoverageRatio": 3053.16, "netRecivables": 8521.88, "netPayables": 920.76, "totalEquety": 40418.9},
//     {"year": "2015", "interestCoverageRatio": 1052.56, "netRecivables": 11447.61, "netPayables": 3297.15, "totalEquety": 34002.41},
//     {"year": "2016", "interestCoverageRatio": 36.15, "netRecivables": 12476.27, "netPayables": 3884.31, "totalEquety": 24872.7},
//     {"year": "2017", "interestCoverageRatio": 25.79, "netRecivables": 6257.8, "netPayables": 6974.4, "totalEquety": 20209.02},
//     {"year": "2018", "interestCoverageRatio": 78.90, "netRecivables": 5498.55, "netPayables": 891.58, "totalEquety": 26860.7},
//     {"year": "2019", "interestCoverageRatio": 42.10, "netRecivables": 23843.57, "netPayables": 7250.96, "totalEquety": 32551},
//     {"year": "2020", "interestCoverageRatio": 33.58, "netRecivables": 19623.12, "netPayables": 8473.14, "totalEquety": 36958.44},
//     {"year": "2021", "interestCoverageRatio": 44.79, "netRecivables": 11367.68, "netPayables": 8603.53, "totalEquety": 43816.83},
//     {"year": "2022", "interestCoverageRatio": 47.14, "netRecivables": 0, "netPayables": 8549.18, "totalEquety": 58015.57},
//     {"year": "2023", "interestCoverageRatio": 56.90, "netRecivables": 13255.75, "netPayables": 8385.65, "totalEquety": 83581.9},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> years = data.map((e) => e['year'].toString()).toList();
//
//     final List<FlSpot> icrSpots = data.asMap().entries.map(
//           (entry) {
//         final index = entry.key;
//         final icr = entry.value['interestCoverageRatio'] ?? 0.0;
//         return FlSpot(index.toDouble(), icr.toDouble());
//       },
//     ).toList();
//
//     final List<BarChartGroupData> barGroups = data.asMap().entries.map((entry) {
//       final index = entry.key;
//       final item = entry.value;
//
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(toY: item['netRecivables'] / 1000, color: Colors.orangeAccent, width: 6),
//           BarChartRodData(toY: item['netPayables'] / 1000, color: Colors.cyanAccent, width: 6),
//           BarChartRodData(toY: item['totalEquety'] / 1000, color: Colors.lightGreenAccent, width: 6),
//         ],
//       );
//     }).toList();
//
//     return Scaffold(
//       backgroundColor: Color(0xff121212),
//       appBar: AppBar(title: const Text("GROWTH TRENDS")),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SizedBox(
//           height: 300,
//           child: BarChart(
//             BarChartData(
//               barGroups: barGroups,
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   axisNameWidget: const Text('ICR', style: TextStyle(color: Colors.redAccent)),
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) =>
//                         Text("${value.toInt()}", style: const TextStyle(color: Colors.redAccent, fontSize: 10)),
//                     reservedSize: 40,
//                   ),
//                 ),
//                 rightTitles: AxisTitles(
//                   axisNameWidget: const Text('₹ Cr', style: TextStyle(color: Colors.white)),
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) =>
//                         Text("${value.toInt()}", style: const TextStyle(color: Colors.white70, fontSize: 10)),
//                     reservedSize: 40,
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) {
//                       int index = value.toInt();
//                       if (index >= 0 && index < years.length) {
//                         return RotationTransition(
//                           turns: new AlwaysStoppedAnimation(15/360),
//                             child: Text(years[index], style: const TextStyle(color: Colors.white, fontSize: 10)));
//                       }
//                       return const Text('');
//                     },
//                   ),
//                 ),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               gridData: FlGridData(show: true, getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1)),
//               borderData: FlBorderData(
//                 show: true,
//                 border: const Border(
//                   bottom: BorderSide(color: Colors.white54),
//                   left: BorderSide(color: Colors.white54),
//                 ),
//               ),
//               alignment: BarChartAlignment.spaceAround,
//               barTouchData: BarTouchData(enabled: true),
//               maxY: 90,
//               groupsSpace: 20,
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SizedBox(
//           height: 200,
//           child: LineChart(
//             LineChartData(
//               minY: 0,
//               maxY: 3200,
//               gridData: FlGridData(show: true),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   axisNameWidget: const Text("ICR", style: TextStyle(color: Colors.redAccent)),
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) =>
//                         Text("${value.toInt()}", style: const TextStyle(color: Colors.redAccent, fontSize: 10)),
//                     reservedSize: 40,
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) {
//                       int index = value.toInt();
//                       if (index >= 0 && index < years.length) {
//                         return Text(years[index], style: const TextStyle(color: Colors.white, fontSize: 10));
//                       }
//                       return const Text('');
//                     },
//                   ),
//                 ),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               borderData: FlBorderData(show: true, border: const Border(bottom: BorderSide(), left: BorderSide())),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: icrSpots,
//                   isCurved: true,
//                   color: Colors.redAccent,
//                   dotData: FlDotData(show: true),
//                   barWidth: 2,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
