import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:phar/models/note.dart';
import 'package:phar/screens/note_detail.dart';
import 'package:phar/utils/database_helper.dart';
import 'package:path_provider/path_provider.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<medecament> noteList;
  int count = 0;
  int currentTab=0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<medecament>();
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
                      'Medicines List',
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

          navigateToDetail(medecament('', '', 0, 0, ''), 'Add Medicine', 554);
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
                          setState(() {
                            // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: currentTab == 2 ? Colors.teal[700] : Colors.grey[700],
                            ),
                            Text(
                              'Search',
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
            leading: Image.asset('assets/rahma5.png'),
            title: Text(
              this.noteList[position].title,
              style: titleStyle,
            ),
            subtitle: Row(
              children: <Widget>[
                Text(this.noteList[position].date),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              navigateToDetail(this.noteList[position], '', 2);
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

  void _delete(BuildContext context, medecament note) async {
    int result = await databaseHelper.deleteMedecament(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Medicine Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(medecament note, String title, int pres) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

//
  void updateListView() {
    Future<List<medecament>> noteListFuture = databaseHelper.getmedecamentList();
    noteListFuture.then((noteList) {
      setState(() {
        this.noteList = noteList;
        this.count = noteList.length;
      });
    });
  }
}
