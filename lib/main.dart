import 'package:flutter/material.dart';
/*import 'package:phar/screens/note_list.dart';
import 'package:phar/screens/note_detail.dart';*/
import 'package:phar/screens/note_list.dart';


void main() {
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

      home: NoteList(),
    );
  }
}