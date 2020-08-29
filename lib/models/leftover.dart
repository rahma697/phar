 class Leftover{
   int _id;
   int _medicmanet_id;
   String _date;
   double _reliquat;



   Leftover({int_id,String_date,double_reliquat, int medicament_id}){
     this._id= _id;
     this._medicmanet_id = medicament_id;
     this._date =_date;
     this._reliquat =_reliquat;

   }
   Leftover.fromMapObject(dynamic ord){
     print("Test ord fromMzpObject");
     print(ord);
     this._id = ord['id'];
     this._medicmanet_id = int.parse(ord["medicament_id"].toString());
     this._date = ord['date'];
     this._reliquat = double.parse(ord['reliquat'].toString());


   }

   int  get id => _id;
   int get medicament_id => medicament_id;
   String get date => _date;
   double get reliquat => _reliquat;
   double get type_poche => type_poche;


   set medicament_id(int medid){
     this._medicmanet_id = medid;
   }
   set date(String date){
     this._date = date;
   }
   set reliquat(double reliquat){
     this._reliquat = reliquat;
   }


   Map<String, dynamic> toMap() {
     var map = new Map<String, dynamic>();
     map["id"] = _id;
     map["medicament_id"] = _medicmanet_id;
     map["date"] = _date;
     map["reliquat"] = _reliquat;



     return map;
   }
}