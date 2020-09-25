import 'package:flutter/foundation.dart';
import 'package:phar/models/leftover.dart';
import 'package:phar/models/ordonnance.dart';
import 'package:phar/models/patient.dart';
import 'package:phar/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:phar/models/medicament.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

//***********************************medicamen Table***************************
  String _medicamentTable = 'medicaments';
  String _colId = 'id';
  String _colTitle = 'title';
  String _colDescription = 'description';
  String _colDate = 'date';
  String _colpres = 'pres';
  String _colpriority = "priority";
  String _medicamentcol_reliquat ="reliquat";
  String _colci = 'ci';
  String _colcmn = 'cmn';
  String _colcmx = 'cmx';
  String _colvol = 'vol';
  String _colprix = 'prix';
  String _colsta = 'sta';
  String _colreliquatDate ='reliquatDate';
//******************************************************************************

  //***********************************TABLE PATIENTS************************** d
  String _patient_Table = 'patients';
  String _patient_colname ='name';
  String _patient_colhei ='height';
  String _patient_colwei ='weight';
  String _patient_colsurf ='surface';
  //******************************************************************************


  //================================= TABLE USER ==================================//
  final String _tableUser = "User";
  final String _columnName = "name";
  final String _columnUserName = "username";
  final String _columnPassword = "password";

  //================================= END TABLE USER =============================//


  //**********************************Table ordonnance***************************//
  String _ordonnace_Table = 'ordonnance';
  String _ordonnace_colid = 'id';
  String _ordonnace_colDate = 'date';
  String _ordonnace_colReduction = 'reduction';
  String _ordonnace_colPosologie = 'posologie';
  String _ordonnace_colMedicament = "medicament_id";
  String _ordonnace_colPatient = "patient_id";
  String _ordonnace_coldosage = 'dosage';
  String _ordonnace_colvolum_a_adminitrer = 'volum_a_administrer';
  String _ordonnace_colreliquat = 'reliquat';
  String _ordonnace_type_poche = 'type_poche';

  //*************************************************************************************


  //************************************************ table leftover *********************
  String _lefteover_Table = 'leftover';
  String _lefteover_colid = 'id';
  String _lefteover_colDate = 'date';
  String _lefteover_colMedicament = "medicament_id";
  String _lefteover_colreliquat = 'reliquat';
  //*************************************************************************************

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //get _PatientsTable => null;

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'pharmacal.db';

//   if (kDebugMode) deleteDatabase(path);

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb, onConfigure: _onConfigure);
    return notesDatabase;
  }


  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  void _createDb(Database db, int newVersion) async {
    //************************************ CREATE TABLE medicine****************************************************
    await db.execute(
      'CREATE TABLE $_medicamentTable($_colId INTEGER PRIMARY KEY AUTOINCREMENT, $_colTitle TEXT, '
      '$_colDescription TEXT, $_colpres INTEGER, $_colDate TEXT, $_colpriority INT,$_colci INT,$_colcmn INT,$_colcmx INT,$_colvol INT,$_colprix INT,$_colsta INT,$_medicamentcol_reliquat INTEGER DEFAULT 0,$_colreliquatDate TEXT)',
    );
    //*************************************************************************************************************


    //**************************************CREATE TABLE PATIENT**************************************************
    await db.execute(
      'CREATE TABLE $_patient_Table($_colId INTEGER PRIMARY KEY AUTOINCREMENT, $_patient_colname TEXT, '
          '$_patient_colhei INTEGER, $_patient_colwei INT,$_patient_colsurf INT)',
    );
//***************************************************************************************************************

    // ***************************************CREATE TABLE USERS***********************************************
    await db.execute(
      "CREATE TABLE $_tableUser(id INTEGER PRIMARY KEY, $_columnName TEXT, $_columnUserName TEXT, $_columnPassword TEXT)",
    );
    //*************************************************************************************************************

    //*****************************************INSERT ADMIN OF THE APP*********************************************
    User admin = User(
      "test",
      "rahma",
      "123456",
    );
    await db.insert(_tableUser, admin.toMap());
    print("TableS created, Admin INSERTED");
    //***********************************************************************************************************************

    //************************************************CREATE TABLE ORDONNANCE **************************************
    /*
    ArtistId INTEGER NOT NULL,
  FOREIGN KEY(ArtistId) REFERENCES Artists(ArtistId)
     */
    await db.execute(
      'CREATE TABLE $_ordonnace_Table ('
          '$_ordonnace_colid INTEGER PRIMARY KEY AUTOINCREMENT, $_ordonnace_colReduction INTEGER, '
          '$_ordonnace_colPosologie INTEGER, $_ordonnace_colDate TEXT, '
          '$_ordonnace_colPatient INTEGER NOT NULL, $_ordonnace_colMedicament INTEGER NOT NULL, '
          '$_ordonnace_coldosage INTEGER, $_ordonnace_colvolum_a_adminitrer INTEGER, '
          '$_ordonnace_colreliquat INTEGER, $_ordonnace_type_poche INTEGER, '//jed virgule radi rani sure
          'FOREIGN KEY($_ordonnace_colMedicament) REFERENCES $_medicamentTable($_colId) ON DELETE CASCADE, '
          'FOREIGN KEY($_ordonnace_colPatient) REFERENCES $_patient_Table($_colId) ON DELETE CASCADE)'
      ,
    );

//*********************************************create table leftover***********************************************
    await db.execute(
      'CREATE TABLE $_lefteover_Table ('
          '$_lefteover_colid INTEGER PRIMARY KEY AUTOINCREMENT, '
          ' $_lefteover_colDate TEXT, '
          ' $_lefteover_colreliquat INTEGER, '
          ' $_lefteover_colMedicament INTEGER NOT NULL, '
          'FOREIGN KEY($_ordonnace_colMedicament) REFERENCES $_medicamentTable($_colId) '
          ')'
      ,
    );
    //**********************************************************************************************************
  }


  Future<List<Map<String, dynamic>>> getPatientMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(
      _patient_Table,
    );
    print("List patient ${result.length}");
    return result;

  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertMedecament(Medicament note) async {
    Database db = await this.database;
    var result = await db.insert(_medicamentTable, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateMedecament(Medicament note) async {
    var db = await this.database;
    var result = await db.update(_medicamentTable, note.toMap(),
        where: '$_colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteMedecament(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $_medicamentTable WHERE $_colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getMedicamentCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $_medicamentTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Medicament>> getMedecamentList({bool reliquat = false}) async {

    Database db = await this.database;
    var medicamentMapList;
    if (!reliquat) medicamentMapList = await db.query(_medicamentTable);
    if (reliquat) medicamentMapList = await db.query(_medicamentTable, where: '$_medicamentcol_reliquat > 0');
    print("la taille ta3 List Medecament ${medicamentMapList.length}");
    print(medicamentMapList.toString());

    int count = medicamentMapList.length; // Count the number of map entries in db table

    List<Medicament> medecamentList = List<Medicament>();
    // For loop to create a 'Medicament List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      Map<String, dynamic> medicamentMap = medicamentMapList[i];
      Medicament medicament = Medicament.fromMapObject(medicamentMap);
      medecamentList.add(medicament);
    }

    return medecamentList;
  }
  Future<int> insertPatient(Patient patient) async {
    Database db = await this.database;
    var result = await db.insert(_patient_Table, patient.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updatePatient(Patient patient) async {
    var db = await this.database;
    var result = await db.update(_patient_Table, patient.toMap(),
        where: '$_colId = ?', whereArgs: [patient.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deletePatient(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $_patient_Table WHERE $_colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getPatientCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $_patient_Table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Patient> ] and convert it to 'Patient List' [ List<Note> ]
  Future<List<Patient>> getPatientList() async {
    var patientMapList = await getPatientMapList(); // Get 'Map List' from database
    int count =
        patientMapList.length; // Count the number of map entries in db table

    List<Patient> patientList = List<Patient>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      patientList .add(Patient.fromMapObject(patientMapList[i]));
    }

    return patientList ;
  }
//====================================================================== ORDNANCE OPERATIONS ============================================
  // Insert Ordonnance to Database
  Future<int> insertOrdonance(Ordonnance ordonnance) async {
    Database db = await this.database;
    var result = await db.insert(_ordonnace_Table, ordonnance.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getOrdnancetMapList() async {
    Database db = await this.database;
    var result = await db.query(_ordonnace_Table);
    print("List ordonance ${result.length}");
    return result;
  }

  Future<List<Ordonnance>> getOrdonanceList() async {
    var ordonanceMapList = await getOrdnancetMapList(); // Get 'Map List' from database
    int count = ordonanceMapList.length;

    List<Ordonnance> ordonanceList = List<Ordonnance>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      ordonanceList .add(Ordonnance.fromMapObject(ordonanceMapList[i]));
    }

    return ordonanceList ;
  }

//=========================================================================== END ORDONANCE OPERATIONS ==================================
//====================================================================== Leftover OPERATIONS ============================================
  // Insert Ordonnance to Database
  Future<int> insertLeftover(Leftover leftover) async {
    Database db = await this.database;
    var result = await db.insert(_lefteover_Table, leftover.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getLeftovertMapList() async {
    Database db = await this.database;
    var result = await db.query(_lefteover_Table);
    print("List leftover ${result.length}");
    return result;
  }

  Future<List<Leftover>> getLeftoverList() async {
    var leftoverMapList = await getLeftovertMapList(); // Get 'Map List' from database
    int count = leftoverMapList.length;

    List<Leftover> leftoverList = List<Leftover>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      leftoverList .add(Leftover.fromMapObject(leftoverMapList[i]));
    }

    return leftoverList ;
  }




  Future<int> deleteLeftover(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $_lefteover_Table WHERE $_colId = $id');
    return result;
  }
//**************************************************************************************************************
  //This method checks if the code & password matches one of the admins
  Future<User> loginUser(User user) async {
    var dbClient = await this.database;
    List<Map> maps = await dbClient.query(_tableUser,
        columns: [_columnUserName, _columnPassword],
        where: "$_columnUserName = ? and $_columnPassword = ?",
        whereArgs: [user.username, user.password],
      limit: 1,
    );
    print(maps);
    if (maps.length > 0) {
      return user;
    } else {
      return null;
    }
  }
}
