// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class OwnersEarningsChart extends StatelessWidget {
//   final List<Map<String, dynamic>> actualEarnings = [
//     {"OE": 72369.37, "year": "2023", "dateYear": "2024-03-31"},
//     {"OE": 57989.64, "year": "2022", "dateYear": "2023-03-31"},
//     {"OE": 40068.14, "year": "2021", "dateYear": "2022-03-31"},
//     {"OE": 32733.36, "year": "2020", "dateYear": "2021-03-31"},
//     {"OE": 33167.86, "year": "2019", "dateYear": "2020-03-31"},
//     {"OE": 37915.14, "year": "2018", "dateYear": "2019-03-31"},
//     {"OE": 22580.42, "year": "2017", "dateYear": "2018-03-31"},
//     {"OE": 26018.39, "year": "2016", "dateYear": "2017-03-31"},
//     {"OE": 29492.82, "year": "2015", "dateYear": "2016-03-31"},
//     {"OE": 28807.43, "year": "2014", "dateYear": "2015-03-31"},
//   ];
//
//   OwnersEarningsChart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Reverse to show oldest to latest
//     final reversedData = List<Map<String, dynamic>>.from(actualEarnings.reversed);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Owner's Earnings", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SizedBox(
//           height: 250,
//           child: LineChart(
//             LineChartData(
//               backgroundColor: Colors.black,
//               gridData: FlGridData(show: true, getDrawingHorizontalLine: (_) => FlLine(color: Colors.grey.shade800, strokeWidth: 1)),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: true, reservedSize: 60, getTitlesWidget: (value, meta) {
//                     return Text(
//                       value.toStringAsFixed(0),
//                       style: const TextStyle(color: Colors.white, fontSize: 10),
//                     );
//                   }),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, meta) {
//                       final index = value.toInt();
//                       if (index >= 0 && index < reversedData.length) {
//                         return Text(
//                           reversedData[index]["year"],
//                           style: const TextStyle(color: Colors.white, fontSize: 10),
//                         );
//                       }
//                       return const Text('');
//                     },
//                   ),
//                 ),
//                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.grey.shade700),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   isCurved: true,
//                   color: Colors.tealAccent,
//                   barWidth: 3,
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     color: Colors.tealAccent.withOpacity(0.2),
//                   ),
//                   spots: List.generate(
//                     reversedData.length,
//                         (index) => FlSpot(index.toDouble(), reversedData[index]["OE"]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
