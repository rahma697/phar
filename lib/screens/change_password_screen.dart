import 'package:flutter/material.dart';
class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
      ),
      body: Container (
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
             child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "Current password",
                      labelText: "Current password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "New password",
                      labelText: "New password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: " Confirm password",
                        labelText: "Confirm password",
                        border: OutlineInputBorder()),
                  ),

                      Row(
                        children: <Widget>[

                          Container(

                            child: Padding(
                                padding: EdgeInsets.only(left: 40.0, right: 10.0,top:30,bottom: 10),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  onPressed: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (_) => DetailPage()),
//                                  );
                                  },
                                  padding: EdgeInsets.all(12),
                                  color: Colors.teal,
                                  child: Text('Save',
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ),
                          Container(
                            child: Padding(

                                padding: EdgeInsets.only(left: 50.0, right:30.0,top:30,bottom: 10),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  onPressed: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (_) => DetailPage()),
//                                  );
                                  },
                                  padding: EdgeInsets.all(12),
                                  color: Colors.teal,
                                  child: Text('Cancel',
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ),
                        ],
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