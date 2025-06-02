import 'package:diet_hub/components/welcom_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceylon Diet',
      home: const WelcomPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.windows, // Add Windows platform support
      ),
    );
  }
}
