// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
//
//
// class DbyEChartScreen extends StatelessWidget {
//   const DbyEChartScreen({super.key});
//
//   final List<Map<String, dynamic>> dbyEData = const [
//     {"value": 0.0788474235033624, "year": "2023"},
//     {"value": 0.07566474492308396, "year": "2022"},
//     {"value": 0.0814416415718503, "year": "2021"},
//     {"value": 0.1610984474233625, "year": "2020"},
//     {"value": 0.20007419864837803, "year": "2019"},
//     {"value": 0.0835392259445859, "year": "2018"},
//     {"value": 0.07748039081816152, "year": "2017"},
//     {"value": 0.12290647202771827, "year": "2016"},
//     {"value": 0.035660931747380345, "year": "2015"},
//     {"value": 0.010118684898075908, "year": "2014"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List<FlSpot> spots = dbyEData
//         .asMap()
//         .entries
//         .map((entry) => FlSpot(entry.key.toDouble(), entry.value['value']))
//         .toList();
//
//     final List<String> years = dbyEData.map((e) => e['year'] as String).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DbyE Trend',style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.black,
//       ),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           height: 250,
//           child: LineChart(
//             LineChartData(
//               backgroundColor: Colors.black,
//               gridData: FlGridData(
//                 show: true,
//                 getDrawingHorizontalLine: (value) => FlLine(
//                   color: Colors.grey.shade800,
//                   strokeWidth: 1,
//                 ),
//                 getDrawingVerticalLine: (value) => FlLine(
//                   color: Colors.grey.shade800,
//                   strokeWidth: 1,
//                 ),
//               ),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, _) => Text(
//                       value.toStringAsFixed(2),
//                       style: const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                     reservedSize: 40,
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 1,
//                     getTitlesWidget: (value, _) {
//                       int index = value.toInt();
//                       if (index >= 0 && index < years.length) {
//                         return Text(
//                           years[index],
//                           style: const TextStyle(color: Colors.white, fontSize: 12),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                 ),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.white, width: 1),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: spots,
//                   isCurved: true,
//                   color: Colors.cyanAccent,
//                   barWidth: 3,
//                   belowBarData: BarAreaData(
//                     show: true,
//                     color: Colors.cyanAccent.withOpacity(0.2),
//                   ),
//                   dotData: FlDotData(show: true),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
