class User {
  String _name;
  String _username;
  String _password;



  User(this._name, this._username, this._password);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;

    return map;
  }
}