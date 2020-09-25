class Patient {
  int _id;
  String _name;
  double _height;
  double _weight;
  double _surface;


  Patient({int id,String name, double height, double weight, double surface}){
    this._id = id;
    this._name = name;
    this._height = height;
    this._weight = weight;
    this._surface = surface;

  }

  Patient.fromMapObject(dynamic obj) {
    print("Test Patient fromMzpObject");
    print(obj);
    this._id = obj['id'];
    this._name = obj['name'];
    this._height = double.parse(obj['height'].toString());
    this._weight = double.parse(obj[ 'weight'].toString());
    this._surface = double.parse(obj['surface'].toString());
}

  int  get id => _id;
  String get name => _name;
  double get height => _height;
  double get weight => _weight;
  double get surface => _surface;


  set name(String name){
    this._name = name;
  }
  set height(double height){
    this._height = height;
  }
  set weight(double weight){
    this._weight = weight;
  }
  set surface(double surface){
    this._surface = surface;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["height"] = _height;
    map["weight"] = _weight;
    map["surface"] = _surface;

    return map;
  }

  //custom comparing function to check if two users are equal
  bool isEqual(Patient model) {
    return this?.id == model?.id;
  }
}