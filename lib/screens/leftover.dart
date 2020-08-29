import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phar/models/leftover.dart';
import 'dart:async';
import 'package:phar/models/medicament.dart';
import 'package:phar/models/patient.dart';
import 'package:phar/screens/calcul.dart';
import 'package:phar/screens/patient_add.dart';
import 'package:phar/utils/database_helper.dart';


class leftoverList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<leftoverList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Medicament> medReliquatList;
  Leftover _leftover = Leftover();

  int count = 0;
  int currentTab=0;
  @override
  Widget build(BuildContext context) {

    if (medReliquatList == null) {
      medReliquatList = List<Medicament>();
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
                      'Leftsover List',
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
        DateTime reliqDate = DateTime.parse(medReliquatList[position].reliquatDate);
        DateTime premptionDate = reliqDate.add(Duration(hours: medReliquatList[position].sta.toInt()));
        String formattedDate = DateFormat("dd/MM/yyyy hh:mm:ss").format(premptionDate);
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: Image.asset('assets/marw5.png'),
            title: Text(
              "${medReliquatList[position].title.toString()} - ${medReliquatList[position].reliquat} ml",
              style: titleStyle,
            ),
            subtitle: Text("Péremption : $formattedDate"),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
//                _delete(context, leftoverList[position]);
              },
            ),
            onTap: () {

            },
          ),
        );
      },
    );
  }


  void _delete(BuildContext context, Leftover leftover) async {
    int result = await databaseHelper.deletePatient(leftover.id);
    if (result != 0) {
      _showSnackBar(context, 'Leftover Deleted Successfully');

    }
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    Future<List<Medicament>> noteListFuture = databaseHelper.getMedecamentList(reliquat: true);
    noteListFuture.then((noteList) {
      setState(() {
        this.medReliquatList = noteList;
        this.count = noteList.length;
      });
    });
  }

}
