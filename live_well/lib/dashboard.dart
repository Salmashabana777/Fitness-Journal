import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double waterIntake = 0.0;
  double? bmiResult;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController mealNameController = TextEditingController();
  TextEditingController calorieController = TextEditingController();

  List<Map<String, dynamic>> meals = [];

  // Custom color palette
  final Color backgroundColor1 = const Color(0xFF2F4F2F);
  final Color backgroundColor2 = const Color(0xFF5C4033);
  final Color backgroundColor3 = const Color(0xFF3F513A);
  final Color iconColor = const Color(0xFF4A4A4A);
  final Color textColor = const Color(0xFFFFFFF0); // Ivory
  final Color cardColor = Colors.black54;
  final Color accentColor = const Color(0xFFDCDCDC);

  void _incrementWater() {
    setState(() {
      waterIntake += 0.25;
    });
  }

  void _resetWater() {
    setState(() {
      waterIntake = 0.0;
    });
  }

  void _calculateBMI() {
    try {
      double height =
          double.parse(heightController.text) / 100; // Convert cm to meters
      double weight = double.parse(weightController.text);

      if (height <= 0 || weight <= 0) {
        _showError('Please enter valid height and weight values');
        return;
      }

      setState(() {
        bmiResult = weight / (height * height);
      });

      _showBMIResult();
    } catch (e) {
      _showError('Please enter valid numbers');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor1,
          title: Text('Error', style: TextStyle(color: textColor)),
          content: Text(message, style: TextStyle(color: textColor)),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: textColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _getBMICategoryColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  void _showBMIResult() {
    if (bmiResult == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor1,
          title: Text('BMI Result', style: TextStyle(color: textColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your BMI',
                style: TextStyle(color: textColor, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                bmiResult!.toStringAsFixed(1),
                style: TextStyle(
                  color: _getBMICategoryColor(bmiResult!),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                _getBMICategory(bmiResult!),
                style: TextStyle(
                  color: _getBMICategoryColor(bmiResult!),
                  fontSize: 24,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close', style: TextStyle(color: textColor)),
              onPressed: () {
                Navigator.of(context).pop();
                heightController.clear();
                weightController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBMICalculator() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor1,
          title: Text('BMI Calculator', style: TextStyle(color: textColor)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    labelStyle: TextStyle(color: textColor),
                    hintText: 'Enter height in cm',
                    hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: TextStyle(color: textColor),
                    hintText: 'Enter weight in kg',
                    hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _calculateBMI();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddMealDialog(String mealType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor1,
          title: Text('Add $mealType', style: TextStyle(color: textColor)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: mealNameController,
                  decoration: InputDecoration(
                    labelText: 'Meal Name',
                    labelStyle: TextStyle(color: textColor),
                    hintText: 'Enter meal name',
                    hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: calorieController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Calories',
                    labelStyle: TextStyle(color: textColor),
                    hintText: 'Enter calories',
                    hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                    ),
                  ),
                  style: TextStyle(color: textColor),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addMeal(mealType);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text(
                    'Add Meal',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addMeal(String mealType) {
    setState(() {
      meals.add({
        'type': mealType,
        'name': mealNameController.text,
        'calories': double.parse(calorieController.text),
      });
      mealNameController.clear();
      calorieController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // Top Section with App Name and Icons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "liveWELL",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.person, color: textColor, size: 28),
                          onPressed: () {
                            print('Profile clicked');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.psychology_alt,
                              color: textColor, size: 28),
                          onPressed: () {
                            print('Chatbot clicked');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // Calorie Tracker
              InkWell(
                onTap: () {
                  print('Calorie tracker clicked');
                  _showBMICalculator();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: 0.6,
                          strokeWidth: 15,
                          backgroundColor: Colors.black38,
                          valueColor: AlwaysStoppedAnimation(textColor),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1200",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "KCAL LEFT",
                          style: TextStyle(
                            fontSize: 16,
                            color: accentColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // Meal Tracking Section
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildMealTile("Breakfast", "Recommended: 442 - 619 kcal",
                        Icons.free_breakfast),
                    _buildMealTile("Lunch", "Recommended: 531 - 708 kcal",
                        Icons.lunch_dining),
                    _buildMealTile("Dinner", "Recommended: 690 - 902 kcal",
                        Icons.dinner_dining),
                    _buildMealTile(
                        "Snack", "Recommended: 131 kcal", Icons.local_pizza),
                    _buildMealTile(
                        "Exercise", "Burned: 250 kcal", Icons.directions_run),
                    _buildWaterIntake(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          unselectedItemColor: accentColor.withOpacity(0.7),
          selectedItemColor: textColor,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedIconTheme: IconThemeData(size: 24),
          onTap: (index) {
            if (index == 1) {
              // Progress tab
              _showBMICalculator();
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Diary"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "Progress"),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add, size: 32, color: textColor),
              ),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Programs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt), label: "Recipes"),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTile(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showAddMealDialog(title);
        },
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: textColor),
          ),
          title: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: accentColor.withOpacity(0.8)),
          ),
          trailing: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add, color: textColor),
              ),
            ),
            onPressed: () {
              _showAddMealDialog(title);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWaterIntake() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: backgroundColor1,
                title: Text('Water Intake', style: TextStyle(color: textColor)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${waterIntake.toStringAsFixed(2)} L',
                      style: TextStyle(color: textColor, fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Each + adds 250ml of water',
                      style: TextStyle(color: accentColor),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Reset', style: TextStyle(color: textColor)),
                    onPressed: () {
                      _resetWater();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Close', style: TextStyle(color: textColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.local_drink, color: textColor),
          ),
          title: Text(
            "Water Intake",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${waterIntake.toStringAsFixed(2)} L",
            style: TextStyle(color: accentColor.withOpacity(0.8)),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.add, color: textColor),
                  ),
                ),
                onPressed: _incrementWater,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    mealNameController.dispose();
    calorieController.dispose();
    super.dispose();
  }
}
