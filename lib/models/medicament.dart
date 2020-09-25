class Medicament {

  int _id;
  String _Name;
  String _labo;
  String _date;
  int _priority;
  double  _pres;
  double _ci;
  double _cmn;
  double _cmx;
  double _volInitial;
  double _prix;
  double _sta;
  double _reliquat;
  String _reliquatDate;


  Medicament(this._Name, this._date,this._priority, this._pres,this._labo);
  Medicament.withId(this._id, this._Name, this._date,this._priority, this._pres, this._labo);


  int get id => _id;
  String get title => _Name;
  String get laboratoire => _labo;

  int get priority => _priority;
  String get date => _date;
  double get pres =>_pres ;
  double get ci => _ci;
  double get cmn => _cmn;
  double get cmx => _cmx;
  double get volumInitial => _volInitial;
  double get prix=> _prix;
  double get sta =>_sta;
  double get reliquat =>_reliquat;
  String get reliquatDate => _reliquatDate;

  //kechma kayna get laobb ?



  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._Name = newTitle;
    }
  }

  set labo(String newlabo) {
    if (newlabo.length <= 255) {
      this._labo = newlabo;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }


  set pres(double newpres) {
    if (newpres <= 1000 ) {
      this._pres = newpres;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set reliquatDate(String newreliquatDate) {
    this._reliquatDate = newreliquatDate;
  }

  set ci(double newci) {
    if (newci <= 1000 ) {
      this._ci = newci;
    }
  }

  set cmn(double newcmn) {
    if (newcmn <= 1000 ) {
      this._cmn = newcmn;
    }
  }

  set cmx(double newcmx) {
    if (newcmx <= 1000 ) {
      this._cmx = newcmx;
    }
  }

  set volumInitial(double newvol) {
    if (newvol <= 1000 ) {
      this._volInitial = newvol;
    }
  }

  set prix(double newprix) {
    if (newprix <= 1000 ) {
      this._prix = newprix;
    }
  }

  set sta(double newsta) {
    if (newsta <= 1000 ) {
      this._sta = newsta;
    }
  }

  set reliquat(double newreliquat) {
      this._reliquat = newreliquat;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _Name;
    map['description'] = _labo;
    map['priority'] = _priority;
    map['date'] = _date;
    map['reliquatDate'] = _reliquatDate;
    map['pres']=_pres;
    map['ci']=_ci;
    map['cmn']=_cmn;
    map['cmx']=_cmx;
    map['vol']=_volInitial;
    map['prix']=_prix;
    map['sta']=_sta;
    map['reliquat']=_reliquat;

    return map;
  }

  // Extract a Note object from a Map object
  Medicament.fromMapObject(Map<String, dynamic> map) {
    print(map);
    this._id = map['id'];
    this._Name = map['title'];
    this._labo = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._reliquatDate= map['reliquatDate'];
    this._pres=double.parse(map['pres'].toString());
    this._ci=double.parse(map['ci'].toString());
    this._cmn=double.parse(map['cmn'].toString());
    this._cmx=double.parse(map['cmx'].toString());
    this._volInitial=double.parse(map['vol'].toString());
    this._prix=double.parse(map['prix'].toString());
    this._sta=double.parse(map['sta'].toString());
    this._reliquat= double.parse(map['reliquat'].toString() ?? 0);

  }

  //custom comparing function to check if two users are equal
  bool isEqual(Medicament model) {
    return this?.id == model?.id;
  }
}




