import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double waterIntake = 0.0;

  // Custom color palette
  final Color backgroundColor1 = const Color(0xFF556B2F); // Olive Green
  final Color backgroundColor2 = const Color(0xFF3E4B2B);
  final Color backgroundColor3 = const Color(0xFF6B8E23);
  final Color iconColor = const Color(0xFF808080); // Grey icons
  final Color textColor = const Color(0xFFFFFFF0); // Ivory text
  final Color cardColor = Colors.black54;
  final Color accentColor = const Color(0xFFDCDCDC);

  void _incrementWater() {
    setState(() {
      waterIntake += 0.25; // Increment by 250ml (0.25L)
    });
  }

  void _resetWater() {
    setState(() {
      waterIntake = 0.0;
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
            colors: [
              backgroundColor1,
              backgroundColor3,
              backgroundColor2,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Section
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
                          icon: Icon(Icons.notifications,
                              color: iconColor, size: 28),
                          onPressed: () {
                            print('Notifications clicked');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.psychology_alt,
                              color: iconColor, size: 28),
                          onPressed: () {
                            print('Chatbot clicked');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Calorie Intake Circle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(0.2), // Semi-transparent white
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "1200 kcal left",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor),
                        ),
                        Text(
                          "Goal: 2200 kcal",
                          style: TextStyle(fontSize: 14, color: accentColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: iconColor, // Grey for unselected icons
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: iconColor),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: iconColor),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_circle, color: iconColor, size: 36),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: iconColor),
            label: "Diary",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: iconColor),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildMealTile(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        trailing: Icon(Icons.arrow_forward_ios, color: accentColor),
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
          leading: Icon(Icons.local_drink, color: textColor),
          title: Text(
            "Water Intake",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${waterIntake.toStringAsFixed(2)} L",
            style: TextStyle(color: accentColor.withOpacity(0.8)),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add, color: textColor),
            onPressed: _incrementWater,
          ),
        ),
      ),
    );
  }
}
