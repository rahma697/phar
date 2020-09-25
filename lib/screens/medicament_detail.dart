import 'package:flutter/material.dart';
import 'package:phar/screens/medicament_list.dart';
import 'package:phar/screens/showpage.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phar/models/medicament.dart';
import 'package:phar/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Medicament note;
  NoteDetail(this. note, this.appBarTitle );
  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  final List<BoxShadow> myShadows = <BoxShadow>[
    new BoxShadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(2.0, 2.0))
  ];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Medicament note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController presContoller=TextEditingController();
  TextEditingController ciController= TextEditingController();
  TextEditingController cmnConroller=TextEditingController();
  TextEditingController cmxController=TextEditingController();
  TextEditingController volController=TextEditingController();
  TextEditingController prixController=TextEditingController();
  TextEditingController staController=TextEditingController();
  TextEditingController medicament_reliquatController=TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.laboratoire;
    presContoller.text = note.pres?.toString() ;
    ciController.text = note.ci?.toString();
    cmnConroller.text=note.cmn?.toString();
    cmxController.text=note.cmx?.toString();
    volController.text=note.volumInitial?.toString();
    prixController.text=note.prix?.toString();
    staController.text=note.sta?.toString();
    medicament_reliquatController.text=note.reliquat?.toString() ?? "0";


    return  Scaffold(
          key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

          body: Container(
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
                  child: Image.asset("assets/pharm.png"),
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
                  child: Text("Medicine", style: TextStyle(
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
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              SizedBox(height: 10,),
                               TextField(
                                  controller: titleController,
                                  style: textStyle,
                                  onChanged: (value) {
                                    updateTitle();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Name of Medicine",
                                    labelText: "Name of Medicine",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              SizedBox(height: 10,),
                              TextField(
                                  controller: descriptionController,
                                  style: textStyle,
                                  onChanged: (value) {

                                    updateDescription();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Laboratory",
                                    labelText: "Laboratory",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),


                              SizedBox(height: 10,),
                               TextField(
                                  controller: presContoller,
                                  style: textStyle,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updatePrestation();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Presentation",
                                    labelText: ' Presentation (mg)',
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              SizedBox(height: 10,),
                               TextField(
                                  controller: ciController,
                                  style: textStyle,
                                 keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateConcentration();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Initial Concentration (mg/ml)",
                                    labelText: ' Initial Concentration (mg/ml)',
                                    hintStyle: TextStyle(color: Colors.grey[600]),

                                  ),
                                ),
                              SizedBox(height: 10,),
                              TextField(
                                  controller: cmnConroller,
                                  style: textStyle,
                                keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateConcentrationm();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Minimum Concentration (mg/ml)",
                                    labelText: ' Minimum Concentration (mg/ml)',
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),

                              SizedBox(height: 10,),
                               TextField(
                                  controller: cmxController,
                                  style: textStyle,
                                 keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateConcentrationmx();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Maximum Concentration (mg/ml)",
                                    labelText: ' Maximum Concentration (mg/ml)',
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),

                               TextField(
                                  controller: volController,
                                  style: textStyle,
                                 keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updatevol();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Initial Volume (mg/ml)",
                                      labelText: ' Initial Volume (mg/ml)',
                                      labelStyle: textStyle,

                                  ),
                                ),
                              SizedBox(height: 10,),
                               TextField(
                                  controller:prixController,
                                  style: textStyle,
                                 keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateprix();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Mg Price",
                                    labelText: "mg price (DA)",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              SizedBox(height: 10,),
                               TextField(
                                  controller:staController ,
                                  style: textStyle,
                                 keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updatesta();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Stability",
                                    labelText: "Stability (hours)",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),

                              TextField(
                                controller:medicament_reliquatController,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Realiquat",
                                  labelText: "Realiquat (ml)",
                                  enabled: false,
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              // Fourth Element
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),


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
            //padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
           /* */
          ),
        );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
  // Convert the String priority in the form of integer before saving it to Database
  // Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }
  // Update the description of Note object
  void updateDescription() {
    note.labo = descriptionController.text;
  }
  // Save data to database
  void _save() async {

    //Checks for fields
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        presContoller.text.isNotEmpty &&
        ciController.text.isNotEmpty &&
    prixController.text.isNotEmpty && staController.text.isNotEmpty
    ){

      note.date = DateFormat.yMMMd().format(DateTime.now());
      note.reliquat = double.parse(medicament_reliquatController.text);
      int result;
      if (note.id != null) {  // Case 1: Update operation
        result = await helper.updateMedecament(note);
      } else { // Case 2: Insert Operation
        result = await helper.insertMedecament(note);
      }

      if (result != 0) {  // Success
        await _showAlertDialog('Status', 'Medicine Saved Successfully');
        moveToLastScreen();
      } else {  // Failure
        await _showAlertDialog('Status', 'Problem Saving Note');
        moveToLastScreen();
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please fill all the fields"),));
    }


  }

  void _delete() async {

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Medicine was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteMedecament(note.id);
    if (result != 0) {
      await _showAlertDialog('Status', 'Medicine Deleted Successfully');
      moveToLastScreen();
    } else {
      await _showAlertDialog('Status', 'Error Occured while Deleting Medicine');
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
// Update the concentration of Note object
  void updateConcentration() {
    note.ci = double.parse(ciController.text.toString());

  }

  void updatePrestation() {
    note.pres = double.parse(presContoller.text.toString());
  }
  void updateConcentrationm(){
    note.cmn=double.parse(cmnConroller.text.toString());
  }
  void updateConcentrationmx(){
    note.cmx=double.parse(cmxController.text.toString());
  }
  void updatevol(){
    note.volumInitial=double.parse(volController.text.toString());
  }
  void updateprix(){
    note.prix=double.parse(prixController.text.toString());
  }
  void updatesta(){
    note.sta=double.parse(staController.text.toString());
  }


}
