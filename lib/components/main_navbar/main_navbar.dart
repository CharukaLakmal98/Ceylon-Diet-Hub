import 'package:diet_hub/components/main_navbar/meal_plans.dart';
import 'package:diet_hub/components/main_navbar/profile_page.dart';
import 'package:diet_hub/components/main_navbar/workout_page.dart';
import 'package:flutter/material.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MealPlansPage(),
    ProfilePage(),
    WorkoutPage(),
    Container(), // Placeholder for 4th tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF6366F1),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 0
                          ? Color(0xFF6366F1)
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant_menu,
                  color: _currentIndex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Meal Plans',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 1
                          ? Color(0xFF6366F1)
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: _currentIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 2
                          ? Color(0xFF6366F1)
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: _currentIndex == 2 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Workout',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 3
                          ? Color(0xFF6366F1)
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: _currentIndex == 3 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
