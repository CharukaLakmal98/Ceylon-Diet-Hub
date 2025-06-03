import 'package:diet_hub/components/main_navbar/meal_plans/meal_plans.dart';
import 'package:diet_hub/components/main_navbar/profile_page.dart';
import 'package:diet_hub/components/main_navbar/workout_page.dart';
import 'package:flutter/material.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> with TickerProviderStateMixin {
  int _currentIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  final List<Widget> _pages = [
    MealPlansPage(),
    ProfilePage(),
    WorkoutPage(),
    Container(), // Placeholder for 4th tab
  ];

  final List<IconData> _icons = [
    Icons.restaurant_menu,
    Icons.person,
    Icons.fitness_center,
    Icons.calendar_today,
  ];

  final List<String> _labels = ['Meal Plans', 'Profile', 'Workout', 'Schedule'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.elasticOut),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController?.reset();
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            bool isSelected = _currentIndex == index;
            return GestureDetector(
              onTap: () => _onTabTapped(index),
              child: AnimatedBuilder(
                animation: _scaleAnimation ?? AlwaysStoppedAnimation(1.0),
                builder: (context, child) {
                  double scale =
                      isSelected ? (_scaleAnimation?.value ?? 1.0) : 1.0;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: scale,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Color(0xFF6366F1)
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: Color(
                                          0xFF6366F1,
                                        ).withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ]
                                    : [],
                          ),
                          child: Icon(
                            _icons[index],
                            color:
                                isSelected ? Colors.white : Color(0xFF6366F1),
                            size: isSelected ? 40 : 30,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const SizedBox(
                          height: 8,
                        ), // Only show SizedBox when selected
                      AnimatedOpacity(
                        opacity: isSelected ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          _labels[index],
                          style: TextStyle(
                            color: Color(0xFF6366F1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
