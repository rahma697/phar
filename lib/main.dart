import 'package:flutter/material.dart';
/*import 'package:phar/screens/medicament_list.dart';
import 'package:phar/screens/medicament_detail.dart';*/
import 'package:phar/screens/medicament_list.dart';
import 'package:phar/utils/database_helper.dart';

import 'screens/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ===== wait database to initialize;
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.database;
  //=========================================
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
     theme: ThemeData(
          primarySwatch: Colors.teal
      ),

      home: LoginPage(),
    );
  }
}