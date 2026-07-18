import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity Chart",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Calories Burned (Last 7 Days)",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 1000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Mon';
                              break;
                            case 1:
                              text = 'Tue';
                              break;
                            case 2:
                              text = 'Wed';
                              break;
                            case 3:
                              text = 'Thu';
                              break;
                            case 4:
                              text = 'Fri';
                              break;
                            case 5:
                              text = 'Sat';
                              break;
                            case 6:
                              text = 'Sun';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4.0,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 600, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 800, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 450, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 900, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 700, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 550, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 650, color: const Color(0xff616def), width: 15, borderRadius: BorderRadius.circular(4))]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100), // padding for bottom nav
          ],
        ),
      ),
    );
  }
}
