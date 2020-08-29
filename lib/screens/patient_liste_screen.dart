import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:phar/models/medicament.dart';
import 'package:phar/models/patient.dart';
import 'package:phar/screens/calcul.dart';
import 'package:phar/screens/patient_add.dart';
import 'package:phar/utils/database_helper.dart';


class PatientList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PatientListState();
  }
}

class PatientListState extends State<PatientList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Patient> patientList;
  int count = 0;
  int currentTab=0;
  @override
  Widget build(BuildContext context) {
    if (patientList == null) {
      patientList = List<Patient>();
      updateListView();
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
            ),
            child: Column(
              children: <Widget>[
                //padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                Padding(
                  padding: EdgeInsets.only(top:100.0, bottom: 15.0),
                  child:Center(
                    child: new Text(
                      'Patients List',
                      style: TextStyle(
                        letterSpacing: 3,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
      backgroundColor: Colors.white,
      primary: false,
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Patient(
            name: "",
            height: 0,
            weight: 0,
            surface: 0,
          ));
        },
        tooltip: 'Add a Medicine',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height:70,
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 70,
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: currentTab == 1 ? Colors.teal[700] : Colors.grey[700],
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: currentTab == 1 ? Colors.teal[700] : Colors.grey,fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Right Tab bar icons
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CalculPage()));
                          setState(() {
                            // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon(

                              Icons.content_paste,
                              color: currentTab == 2 ? Colors.teal[700] : Colors.grey[700],
                            ),
                            Text(
                              'Calculate',
                              style: TextStyle(
                                color: currentTab == 2 ? Colors.teal[700]: Colors.grey[700],fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                )
              ]
          ),
        ),
      ),
    );
  }
  ListView getNoteListView() {
    Container(
        color: Colors.white,
        width: 125.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ));
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      padding: EdgeInsets.only(top: 50.0),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: Image.asset('assets/ma6.png'),
            title: Text(
              this.patientList[position].name,
              style: titleStyle,
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, patientList[position]);
              },
            ),
            onTap: () {
              navigateToDetail(this.patientList[position]);
            },
          ),
        );
      },
    );
  }
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }
  void _delete(BuildContext context, Patient note) async {
    int result = await databaseHelper.deletePatient(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Patient Deleted Successfully');
      updateListView();
    }
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  void navigateToDetail(Patient patient) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return  PatientDetail(patient);
    }));

    if (result == true) {
      updateListView();
    }
  }
//
  void updateListView() {
    Future<List<Patient>> noteListFuture = databaseHelper.getPatientList();
    noteListFuture.then((noteList) {
      setState(() {
        this.patientList = noteList;
        this.count = noteList.length;
      });
    });
  }
}
