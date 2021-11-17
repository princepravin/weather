import 'package:custom/CUSTOM%20FOLDER/custom_one.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // themeMode: isSelecting? ThemeMode.system,
      // theme: isSelecting ? Themes.darkTheme : Themes.lightTheme,
//         primarySwatch: Colors.blue,
      home: WeatherReport(),
    );
  }
}

class Themes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    fontFamily: 'poppins',
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    fontFamily: 'poppins',
  );
}

// class TrueOrFalse extends ChangeNotifier {
//   bool isSelecting = false;
//   currentTime = Date
//   changing() {
    
//     isSelecting = !isSelecting;
//     notifyListeners();
//   }
// }
