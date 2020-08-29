import 'package:phar/models/patient.dart';

class Ordonnance {
  int _id;
  int _reduction;
  double _posologie;
  int _medicmanet_id;
  int _patient_id;
  String _date;
  double _dosage;
  double _volum_a_administrer;
  double _reliquat;
  double _type_poche;

  //

  Ordonnance({int_id,double_red,double_poso, int medicament_id, int patient_id}){
    this._id= _id;
    this._reduction = _reduction;
    this._posologie = _posologie;
    this._medicmanet_id = medicament_id;
    this._patient_id = patient_id;
    this._date =_date;
    this._dosage =_dosage;
    this._volum_a_administrer;
    this._reliquat =_reliquat;
    this.type_poche =type_poche;


  }
  Ordonnance.fromMapObject(dynamic ord){
    print("Test ord fromMzpObject");
    print(ord);
    this._id = ord['id'];
    this._reduction = ord['reduction'];
    this._posologie = double.parse(ord['posologie'].toString());
    this._medicmanet_id = int.parse(ord["medicament_id"].toString());
    this._patient_id = int.parse(ord["patient_id"].toString());
    this._date = ord['date'];
    this._dosage = double.parse(ord['dosage'].toString());
    this._volum_a_administrer = double.parse(ord['volum a administrer'].toString());
    this._reliquat = double.parse(ord['reliquat'].toString());
    this.type_poche = double.parse(ord['type poche'].toString());

  }

  int  get id => _id;
  int  get reduction => _reduction;
  int get medicament_id => medicament_id;
  int get patient_id => _patient_id;
  String get date => _date;
  double get dosage => _dosage;
  double get posologie => _posologie;
  double get volum_a_administrer => _volum_a_administrer;
  double get reliquat => _reliquat;
  double get type_poche => _type_poche;

  set reduction(int red){
    this._reduction = red;
  }
  set posologie(double posologie){
    this._posologie = posologie;
  }

  set medicament_id(int medid){
    this._medicmanet_id = medid;
  }

  set patient_id(int patID){
    this._patient_id = patID;
  }
set date(String date){
    this._date = date;
  }
set dosage(double dosage){
    this._dosage = dosage;
  }
set  volum_a_administer(double volum_a_administer){
    this._volum_a_administrer= volum_a_administer;
  }
set reliquat(double reliquat){
    this._reliquat = reliquat;
  }
set type_poche(double type_poche){
    this._type_poche = type_poche;
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["reduction"] = _reduction;
    map["posologie"] = _posologie;
    map["medicament_id"] = _medicmanet_id;
    map["date"] = _date;
    map["dosage"] = _dosage;
    map["volum_a_administrer"] = _volum_a_administrer;
    map["reliquat"] = _reliquat;
    map["type_poche"] = _type_poche;
    map["patient_id"] = _patient_id;


    return map;
  }

}