import 'package:flutter/material.dart';

class ChangeUserNamePage extends StatefulWidget {
  @override
  _ChangeUserNamePageState createState() => _ChangeUserNamePageState();
}

class _ChangeUserNamePageState extends State<ChangeUserNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Username"),
      ),
    );
  }
}
