import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phar/models/patient.dart';
import 'dart:async';
import 'package:phar/utils/database_helper.dart';
import 'package:intl/intl.dart';

class PatientDetail extends StatefulWidget {
  final Patient patient;
  PatientDetail(this. patient, );
  @override
  State<StatefulWidget> createState() {

    return PatientDetailState(patient);
  }
}
class PatientDetailState extends State<PatientDetail> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Patient patient;
  TextEditingController nameContoller = TextEditingController();
  TextEditingController heightContoller = TextEditingController();
  TextEditingController weightContoller =TextEditingController();
  TextEditingController bodysurfaceContoller = TextEditingController();

  PatientDetailState(this.patient);

  @override
  Widget build(BuildContext context) {
    final List<BoxShadow> myShadows = <BoxShadow>[
      new BoxShadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(2.0, 2.0))
    ];

    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameContoller.text = patient.name ?? "";
    heightContoller.text = patient.height?.toString() ?? "";
    weightContoller.text = patient.weight?.toString() ?? "";
    bodysurfaceContoller.text = patient.surface?.toString() ?? "";

    return  Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body:Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.teal[600],
                  Colors.white,
                ]
            )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0,right: 250,top:20.0,bottom: 300.0),
              child:IconButton (icon: Icon(
                  Icons.arrow_back
              ),
                  color: Colors.white,
                  onPressed: () {
                    // Write some code to control things, when user press back button in AppBar
                    Navigator.of(context).pop();
                  }
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 190.0, right: 30.0, top: 70.0, bottom: 60.0),
              child: Image.asset("assets/patient.png"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 20.0, right: 90.0, top: 90.0, bottom: 60.0),
              child: Text("Add", style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0)

              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 70.0, right: 90.0, top: 120.0, bottom: 60.0),

              child: Text("Patient", style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 25.0)
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 220.0, bottom: 50.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: myShadows,
              ),
             child: Padding(
               padding: const EdgeInsets.only(left: 16.0, right: 16.0),
               child: Column(
                 children: <Widget>[
                   Expanded(child: ListView(
                     children: <Widget>[
                       SizedBox(height: 10,),
                        TextField(
                           controller:  nameContoller,
                           style: textStyle,
                           onChanged: (value) {
                             updateName();
                           },
                           decoration: InputDecoration(

                             labelText: "Name ",
                             hintStyle: TextStyle(color: Colors.grey[600]),

                           ),
                         ),
                       SizedBox(height: 10,),
                       TextField(
                           controller: heightContoller,
                           keyboardType: TextInputType.number,
                           style: textStyle,
                           onChanged: (value) {

                             updateheight();
                           },
                           decoration: InputDecoration(
                             hintText: "Height (cm)",
                             labelText: "Height (cm)",
                             hintStyle: TextStyle(color: Colors.grey[600]),
                           ),
                         ),
                       SizedBox(height: 10,),
                           TextField(
                           controller:  weightContoller,
                           style: textStyle,
                           keyboardType: TextInputType.number,
                           onChanged: (value) {
                             updateWeight();
                           },
                           decoration: InputDecoration(
                             hintText: "Weight(kg)",
                             labelText: "Weight (kg)",
                             hintStyle: TextStyle(color: Colors.grey[600]),

                           ),
                         ),
                       SizedBox(height: 10,),
                       TextField(
                           controller: bodysurfaceContoller,
                           style: textStyle,
                           keyboardType: TextInputType.number,
                           enabled: false,
                           decoration: InputDecoration(
                             hintText: "Body surface",
                             labelText: "Body surface (m2)",
                             hintStyle: TextStyle(color: Colors.grey[600]),
                           ),
                         ),

                       Padding(
                           padding: EdgeInsets.symmetric(vertical: 90.0),
                           child:RaisedButton(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24),
                             ),
                             onPressed: () {
                               setState(() {
                                 _save();
                               });
                             },
                             padding: EdgeInsets.all(12),
                             color: Colors.cyan[700],
                             child: Text('Save',
                                 style: TextStyle(color: Colors.white)),
                           )
                       ),
                     ],
                   ),
                   ),
                 ],
               ),
             ),
            ),
          ],
        ),
      ),
    );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
  // Convert the String priority in the form of integer before saving it to Database
  // Update the title of Note object
  void updateName(){
    patient.name = nameContoller.text;
  }
  // Update the description of Note object
  void updateheight() {
    patient.height = double.parse(heightContoller.text.toString());
    updatesurface();
  }
  void updateWeight(){
    patient.weight =double.parse(weightContoller.text.toString());
    updatesurface();
  }
  void updatesurface(){
    if(double.parse(heightContoller.text.toString()) > 0 && double.parse(weightContoller.text.toString()) > 0 ){
      /*
      SC = racine carrée du (poids x taille)/3600
       */
      double poids = double.parse(weightContoller.text.toString());
      double taille = double.parse(heightContoller.text.toString());
      //calcul ta3 surface
      String surface = sqrt((poids * taille) / 3600).toStringAsFixed(2);


      //save
      patient.surface = double.parse(surface);
      bodysurfaceContoller.text = surface.toString();
    }

  }


  // Save data to database
  void _save() async {
    //Checks for fields
    if (patient.height <= 0.5 || patient.weight <= 5 || patient.surface == 0.0 ){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please fill correct details")));
    }
    else if (
    patient.name.isNotEmpty &&
        patient.height.toString().isNotEmpty &&
       patient.weight.toString().isNotEmpty &&
        patient.surface.toString().isNotEmpty
    ){

      int result;
      if (patient.id != null) {  // Case 1: Update operation
        result = await helper.updatePatient(patient);
      } else { // Case 2: Insert Operation
        result = await helper.insertPatient(patient);
      }

      if (result != 0) {  // Success
        await _showAlertDialog('Status', 'Patient Saved Successfully');
        moveToLastScreen();
      } else {  // Failure
        await _showAlertDialog('Status', 'Problem Saving Patient');
        moveToLastScreen();
      }
    }
    else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please fill all the fields"),));
    }
  }
  void _delete() async {

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (patient.id == null) {
      _showAlertDialog('Status', 'No Patient was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteMedecament(patient.id);
    if (result != 0) {
      await _showAlertDialog('Status', 'Patient Deleted Successfully');
      moveToLastScreen();
    } else {
      await _showAlertDialog('Status', 'Error Occured while Deleting Patient');
      moveToLastScreen();
    }
  }

  Future<void> _showAlertDialog(String title, String message) async {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    await showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }


}
