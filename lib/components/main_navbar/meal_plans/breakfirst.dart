import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BreakfirstPage extends StatefulWidget {
  const BreakfirstPage({super.key});

  @override
  _BreakfirstPageState createState() => _BreakfirstPageState();
}

class _BreakfirstPageState extends State<BreakfirstPage> {
  bool isVegan = true;
  String selectedItem = '';
  bool showHealthAlert = true;
  bool isDropdownOpen = false;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  // Vegan foods list with unique values
  final List<String> veganFoods = [
    'Oatmeal with fruits',
    'Whole grain toast with avocado',
    'Vegan pancakes',
    'Fruit smoothie bowl',
    'Tofu scramble',
    'Quinoa breakfast bowl',
    'Chia pudding with berries',
    'Vegan granola with almond milk',
  ];

  // Non-vegan foods list with unique values
  final List<String> nonVeganFoods = [
    'Bacon, cooked 1 slice',
    'Steak (rump)',
    'Lamb chop',
    'Scrambled eggs',
    'Greek yogurt with honey',
    'Ham and cheese sandwich',
    'Chicken breast grilled',
    'Salmon fillet',
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isVegan = prefs.getBool('isVegan') ?? true;
      showHealthAlert = prefs.getBool('showHealthAlert') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isVegan', isVegan);
    await prefs.setBool('showHealthAlert', showHealthAlert);
  }

  // Call _savePreferences() when changing isVegan value
  void toggleVeganMode() {
    setState(() {
      isVegan = !isVegan;
      _savePreferences();
    });
  }

  // Close health alert permanently
  void closeHealthAlert() {
    setState(() {
      showHealthAlert = false;
    });
    _savePreferences();
  }

  List<String> get currentFoodList => isVegan ? veganFoods : nonVeganFoods;

  List<String> get filteredFoodList {
    if (searchQuery.isEmpty) {
      return currentFoodList;
    }
    return currentFoodList
        .where((food) => food.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
      if (!isDropdownOpen) {
        searchQuery = '';
        searchController.clear();
      }
    });
  }

  void selectItem(String item) {
    setState(() {
      selectedItem = item;
      isDropdownOpen = false;
      searchQuery = '';
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Breakfast',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the type that suits your preference.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // Vegan/Non-Vegan Toggle
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVegan = true;
                          selectedItem = '';
                          isDropdownOpen = false;
                          searchQuery = '';
                          searchController.clear();
                        });
                        _savePreferences();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isVegan ? Color(0xFF6366F1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Vegan',
                            style: TextStyle(
                              color: isVegan ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVegan = false;
                          selectedItem = '';
                          isDropdownOpen = false;
                          searchQuery = '';
                          searchController.clear();
                        });
                        _savePreferences();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              !isVegan ? Color(0xFF6366F1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Non Vegan',
                            style: TextStyle(
                              color: !isVegan ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Select your food here',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15),

            // Food List with Custom Dropdown
            Text(
              'Food List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),

            // Custom Dropdown with Search
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Dropdown Header
                  GestureDetector(
                    onTap: toggleDropdown,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedItem.isEmpty
                                  ? 'Select item'
                                  : selectedItem,
                              style: TextStyle(
                                color:
                                    selectedItem.isEmpty
                                        ? Colors.grey[600]
                                        : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(
                            isDropdownOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Dropdown Content
                  if (isDropdownOpen) ...[
                    Divider(height: 1, color: Colors.grey[500]),

                    // Search Bar
                    Container(
                      padding: EdgeInsets.all(12),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF6366F1)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),

                    // Food Items List
                    Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredFoodList.length,
                        itemBuilder: (context, index) {
                          final item = filteredFoodList[index];
                          return InkWell(
                            onTap: () => selectItem(item),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[200]!,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Text(item, style: TextStyle(fontSize: 16)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),

            Spacer(),

            // Health Alert - Only show if showHealthAlert is true
            if (showHealthAlert)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Health Alert',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.notifications, color: Colors.red, size: 20),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'According to your BMI, it is more suitable to eat your Breakfast in the range of 400-550 Cal.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: closeHealthAlert,
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
