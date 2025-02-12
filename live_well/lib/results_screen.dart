import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> quizResults;

  // Custom color palette matching dashboard
  final Color backgroundColor1 = const Color(0xFF556B2F);
  final Color backgroundColor2 = const Color(0xFF3E4B2B);
  final Color backgroundColor3 = const Color(0xFF6B8E23);
  final Color iconColor = const Color(0xFF808080);
  final Color textColor = const Color(0xFFFFFFF0);
  final Color cardColor = Colors.black54;
  final Color accentColor = const Color(0xFFDCDCDC);

  const ResultsScreen({Key? key, required this.quizResults}) : super(key: key);

  double calculateBMI() {
    double height =
        double.parse(quizResults['What is your height?'].toString());
    double weight =
        double.parse(quizResults['What is your weight?'].toString());
    String heightUnit = quizResults['What is your height?_unit'];
    String weightUnit = quizResults['What is your weight?_unit'];

    // Convert to metric if necessary
    if (heightUnit == 'ft/in') {
      List<String> parts = height.toString().split('.');
      double feet = double.parse(parts[0]);
      double inches = parts.length > 1 ? double.parse(parts[1]) : 0;
      height = (feet * 30.48) + (inches * 2.54);
    }

    if (weightUnit == 'lbs') {
      weight = weight * 0.453592;
    }

    height = height / 100;
    return weight / (height * height);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  List<String> getRecommendations() {
    double bmi = calculateBMI();
    String activityLevel = quizResults['How active are you?'];
    String goal = quizResults['What is your goal?'];
    List<String> recommendations = [];

    if (bmi < 18.5) {
      recommendations
          .add('Focus on increasing caloric intake with nutrient-dense foods');
    } else if (bmi > 25) {
      recommendations.add(
          'Consider creating a small caloric deficit through diet and exercise');
    }

    if (activityLevel.contains('Sedentary')) {
      recommendations.add(
          'Try to incorporate more daily movement, starting with short walks');
    }

    if (goal == 'Gain muscle') {
      recommendations.add(
          'Ensure adequate protein intake and progressive resistance training');
    } else if (goal == 'Lose weight') {
      recommendations.add('Focus on creating a sustainable caloric deficit');
    }

    return recommendations;
  }

  Widget _buildPieChart(double bmi) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 30,
        sections: [
          PieChartSectionData(
            value: bmi,
            color: accentColor,
            radius: 40,
            title: '',
            showTitle: false,
          ),
          PieChartSectionData(
            value: 35 - bmi,
            color: iconColor.withOpacity(0.3),
            radius: 40,
            title: '',
            showTitle: false,
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: accentColor.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            getTitles: (value) {
              return value.toInt().toString();
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            getTitles: (value) {
              return value.toInt().toString();
            },
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: accentColor.withOpacity(0.2)),
        ),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.5, 4),
              FlSpot(4.9, 5),
            ],
            isCurved: true,
            colors: [accentColor],
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              colors: [accentColor.withOpacity(0.1)],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    String bmiCategory = getBMICategory(bmi);
    List<String> recommendations = getRecommendations();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColor1, backgroundColor3, backgroundColor2],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Your Results",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // BMI Card
              Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BMI Results',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your BMI',
                                style: TextStyle(color: accentColor),
                              ),
                              Text(
                                bmi.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                bmiCategory,
                                style: TextStyle(color: accentColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: _buildPieChart(bmi),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Recommendations Card
              Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommendations',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...recommendations
                          .map((recommendation) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_right, color: accentColor),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        recommendation,
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Progress Tracking Card
              Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress Tracking',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: _buildLineChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
