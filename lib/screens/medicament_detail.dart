import 'package:flutter/material.dart';
import 'package:phar/screens/note_list.dart';
import 'package:phar/screens/showpage.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phar/models/note.dart';
import 'package:phar/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final medecament note;
  NoteDetail(this. note, this.appBarTitle );
  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  medecament note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController presContoller=TextEditingController();
  TextEditingController ciController= TextEditingController();
  TextEditingController cmnConroller=TextEditingController();
  TextEditingController cmxController=TextEditingController();
  TextEditingController volController=TextEditingController();
  TextEditingController prixController=TextEditingController();
  TextEditingController staController=TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;
    presContoller.text = note.pres?.toString();
    ciController.text = note.ci?.toString();
    cmnConroller.text=note.cmn?.toString();
    cmxController.text=note.cmx?.toString();
    volController.text=note.cmx?.toString();
    prixController.text=note.prix?.toString();
    staController.text=note.sta?.toString();


    return  Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
              Icons.arrow_back),
              onPressed: () {
                // Write some code to control things, when user press back button in AppBar
                Navigator.of(context).pop();
              }
          ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {

                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Laboratory',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),

                ),

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: presContoller,
                      style: textStyle,
                      onChanged: (value) {
                        updatePrestation();
                      },
                      decoration: InputDecoration(
                          labelText: 'Presentation',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: ciController,
                    style: textStyle,
                    onChanged: (value) {
                      updateConcentration();
                    },
                    decoration: InputDecoration(
                        labelText: 'Initial Concentration',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: cmnConroller,
                    style: textStyle,
                    onChanged: (value) {
                     updateConcentrationm();
                    },
                    decoration: InputDecoration(
                        labelText: 'Minimum Concentration',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: cmxController,
                    style: textStyle,
                    onChanged: (value) {
                      updateConcentrationmx();
                    },
                    decoration: InputDecoration(
                        labelText: 'Maximum Concentration',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: volController,
                    style: textStyle,
                    onChanged: (value) {
                     updatevol();
                    },
                    decoration: InputDecoration(
                        labelText: 'Volume after Preparation',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller:prixController,
                    style: textStyle,
                    onChanged: (value) {
                      updateprix();
                    },
                    decoration: InputDecoration(
                        labelText: 'Mg Price',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller:staController ,
                    style: textStyle,
                    onChanged: (value) {
                      updatesta();
                    },
                    decoration: InputDecoration(
                        labelText: 'Stability',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(width: 5.0,),

                    ],
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
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && presContoller.text.isNotEmpty && ciController.text.isNotEmpty){

      note.date = DateFormat.yMMMd().format(DateTime.now());
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
    note.ci = int.parse(ciController.text.toString());

  }

  void updatePrestation() {
    note.pres = int.parse(presContoller.text.toString());
  }
  void updateConcentrationm(){
    note.cmn=int.parse(cmnConroller.text.toString());
  }
  void updateConcentrationmx(){
    note.cmx=int.parse(cmxController.text.toString());
  }
  void updatevol(){
    note.vol=int.parse(volController.text.toString());
  }
  void updateprix(){
    note.prix=int.parse(prixController.text.toString());
  }
  void updatesta(){
    note.sta=int.parse(staController.text.toString());
  }


}
