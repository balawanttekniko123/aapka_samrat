// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
//
//
// // class FinancialDashboardApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Financial Dashboard',
// //       theme: ThemeData.dark().copyWith(
// //         scaffoldBackgroundColor: Color(0xFF121212),
// //         cardColor: Color(0xFF1E1E1E),
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Color(0xFF1F1F1F),
// //           foregroundColor: Colors.white,
// //         ),
// //       ),
// //       home: FinancialDashboardScreen(),
// //     );
// //   }
// // }
//
// class FinancialDashboardScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> retainedEarnings = [
//     {"val": 54425.56, "year": "2023"},
//     {"val": 48907.39, "year": "2022"},
//     {"val": 17451.8, "year": "2021"},
//     {"val": 11740.96, "year": "2020"},
//     {"val": 7547.95, "year": "2019"},
//     {"val": 1277.72, "year": "2018"},
//     {"val": -9601.57, "year": "2017"},
//     {"val": -3618.03, "year": "2016"},
//     {"val": 2651.36, "year": "2015"},
//     {"val": 10754, "year": "2014"},
//   ];
//
//   final List<Map<String, dynamic>> earnings = [
//     {"year": "2023", "EAT": 48812.61},
//     {"year": "2022", "EAT": 38000.81},
//     {"year": "2021", "EAT": 23616.28},
//     {"year": "2020", "EAT": 18009.24},
//     {"year": "2019", "EAT": 24071.32},
//     {"year": "2018", "EAT": 27125.46},
//     {"year": "2017", "EAT": 10726.44},
//     {"year": "2016", "EAT": 14433.71},
//     {"year": "2015", "EAT": 21589.09},
//     {"year": "2014", "EAT": 21583.92},
//   ];
//
//   final List<Map<String, dynamic>> itrData = [
//     {"year": "2023", "ITR": 1.84},
//     {"year": "2022", "ITR": 2.54},
//     {"year": "2021", "ITR": 2.67},
//     {"year": "2020", "ITR": 1.31},
//     {"year": "2019", "ITR": 1.81},
//     {"year": "2018", "ITR": 3.83},
//     {"year": "2017", "ITR": 2.26},
//     {"year": "2016", "ITR": 1.40},
//     {"year": "2015", "ITR": 1.50},
//     {"year": "2014", "ITR": 1.91},
//   ];
//
//   final double dso = 35.77;
//   final double daysWC = 221.15;
//   final double cashCycle = 70.55;
//
//   List<FlSpot> _toLineSpots(List<Map<String, dynamic>> data, String key) {
//     return List.generate(data.length, (index) {
//       return FlSpot(index.toDouble(), (data[index][key] as num).toDouble());
//     });
//   }
//
//   BarChartGroupData _barData(int x, double y) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y,
//           width: 14,
//           color: Colors.tealAccent,
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ],
//     );
//   }
//
//   Widget buildLineChart(String title, List<FlSpot> spots, List<String> yearLabels) {
//     return Card(
//       color: Color(0xFF1E1E1E),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 200,
//               child: LineChart(LineChartData(
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: spots,
//                     isCurved: true,
//                     color: Colors.cyanAccent,
//                     dotData: FlDotData(show: true),
//                     barWidth: 3,
//                     belowBarData: BarAreaData(
//                       show: true,
//                       color: Colors.cyanAccent.withOpacity(0.2),
//                     ),
//                   )
//                 ],
//                 titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       interval: 1,
//                       getTitlesWidget: (value, _) {
//                         int index = value.toInt();
//                         return Text(
//                           index >= 0 && index < yearLabels.length ? yearLabels[index] : '',
//                           style: TextStyle(color: Colors.white60, fontSize: 10),
//                         );
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(show: true, getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1)),
//                 borderData: FlBorderData(show: false),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildBarChart(String title, List<BarChartGroupData> bars, List<String> yearLabels) {
//     return Card(
//       color: Color(0xFF1E1E1E),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 200,
//               child: BarChart(BarChartData(
//                 barGroups: bars,
//                 titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, _) {
//                         int index = value.toInt();
//                         return Text(
//                           index >= 0 && index < yearLabels.length ? yearLabels[index] : '',
//                           style: TextStyle(color: Colors.white60, fontSize: 10),
//                         );
//                       },
//                       interval: 1,
//                     ),
//                   ),
//                   leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(show: true, getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1)),
//                 borderData: FlBorderData(show: false),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//
//       backgroundColor: Color(0xFF1F1F1F),
//       appBar: AppBar(title: Text("📊 Financial Dashboard",style: TextStyle(color: Colors.white),),backgroundColor:  Color(0xFF1F1F1F),),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           buildLineChart(
//             "📈 Retained Earnings",
//             _toLineSpots(retainedEarnings, "val"),
//             retainedEarnings.map((e) => e["year"].toString()).toList(),
//           ),
//
//           buildLineChart(
//             "💰 Earnings After Tax",
//             _toLineSpots(earnings, "EAT"),
//             earnings.map((e) => e["year"].toString()).toList(),
//           ),
//
//           buildBarChart(
//             "📦 Inventory Turnover Ratio",
//             List.generate(itrData.length, (i) => _barData(i, itrData[i]["ITR"])),
//             itrData.map((e) => e["year"].toString()).toList(),
//           ),
//
//           buildBarChart(
//             "⚙️ DSO, Days WC, Cash Cycle",
//             [
//               _barData(0, dso),
//               _barData(1, daysWC),
//               _barData(2, cashCycle),
//             ],
//             ["DSO", "WC", "Cycle"],
//           ),
//
//         ],
//       ),
//     );
//   }
// }
