import 'package:flutter/material.dart';

class MealPlansPage extends StatefulWidget {
  @override
  _MealPlansPageState createState() => _MealPlansPageState();
}

class _MealPlansPageState extends State<MealPlansPage> {
  int? selectedMealIndex;

  final List<Map<String, dynamic>> mealTypes = [
    {
      'name': 'Breakfast',
      'image': 'assets/images/breakfast.jpg', // Replace with your image path
      'icon': Icons.breakfast_dining,
    },
    {
      'name': 'Lunch',
      'image': 'assets/images/lunch.jpg', // Replace with your image path
      'icon': Icons.lunch_dining,
    },
    {
      'name': 'Dinner',
      'image': 'assets/images/dinner.jpg', // Replace with your image path
      'icon': Icons.dinner_dining,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BMI Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Body Mass Index(BMI)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Health Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Normal weight',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4DB6AC),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.favorite,
                                  color: Color(0xFF4DB6AC),
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Your BMI',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '20.67',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Meal Selection Title
              Text(
                'Please select one of them',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              // Meal Options
              ...mealTypes.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> meal = entry.value;

                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMealIndex = index;
                      });
                      // Add your navigation logic here
                      print('Selected: ${meal['name']}');
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            selectedMealIndex == index
                                ? Color(0xFF6366F1).withOpacity(0.1)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              selectedMealIndex == index
                                  ? Color(0xFF6366F1)
                                  : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Meal Image/Icon
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getMealColor(index),
                            ),
                            child: ClipOval(
                              child: Icon(
                                meal['icon'],
                                size: 35,
                                color: Colors.white,
                              ),
                              // If you have actual images, replace the Icon with:
                              // Image.asset(
                              //   meal['image'],
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),

                          SizedBox(width: 20),

                          // Meal Name
                          Expanded(
                            child: Text(
                              meal['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Selection Indicator
                          if (selectedMealIndex == index)
                            Icon(
                              Icons.check_circle,
                              color: Color(0xFF6366F1),
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: 30),

              // Continue Button (if meal is selected)
              if (selectedMealIndex != null)
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your continue logic here
                      print(
                        'Continue with: ${mealTypes[selectedMealIndex!]['name']}',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6366F1),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getMealColor(int index) {
    switch (index) {
      case 0: // Breakfast
        return Color(0xFFFF9800);
      case 1: // Lunch
        return Color(0xFF4CAF50);
      case 2: // Dinner
        return Color(0xFF9C27B0);
      default:
        return Color(0xFF6366F1);
    }
  }
}
