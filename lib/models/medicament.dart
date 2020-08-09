class medecament {

  int _id;
  String _Name;
  String _labo;
  String _date;
  String _np;
  int _priority;
  int _pres;
  int _ci;
  int _cmn;
  int _cmx;
  int _vol;
  int _prix;
  int _sta;
  int _hei;
  int _wei;
  int _sf;

  medecament(this._Name, this._date,this._priority, this._pres,this._labo);
  medecament.withId(this._id, this._Name, this._date,this._priority, this._pres, this._labo);


  int get id => _id;
  String get title => _Name;
  String get description => _labo;
  String get name => _np;
  int get priority => _priority;
  String get date => _date;
  int get pres =>_pres;
  int get ci => _ci;
  int get cmn => _cmn;
  int get cmx => _cmx;
  int get vol => _vol;
  int get prix=> _prix;
  int get sta =>_sta;
  int get height =>_hei;
  int get weidht =>_wei;
  int get surface =>_sf;



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
  set name(String newname) {
    if (newname.length <= 255 ) {
      this._np = newname ;
    }
  }

  set pres(int newpres) {
    if (newpres <= 1000 ) {
      this._pres = newpres;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set ci(int newci) {
    if (newci <= 1000 ) {
      this._ci = newci;
    }
  }

  set cmn(int newcmn) {
    if (newcmn <= 1000 ) {
      this._cmn = newcmn;
    }
  }

  set cmx(int newcmx) {
    if (newcmx <= 1000 ) {
      this._cmx = newcmx;
    }
  }

  set vol(int newvol) {
    if (newvol <= 1000 ) {
      this._vol = newvol;
    }
  }

  set prix(int newprix) {
    if (newprix <= 1000 ) {
      this._prix = newprix;
    }
  }

  set sta(int newsta) {
    if (newsta <= 1000 ) {
      this._sta = newsta;
    }
  }
  set height(int newheight) {
    if (newheight <= 1000 ) {
      this._hei = newheight ;
    }
  }
  set weidht(int newweidht) {
    if (newweidht <= 1000 ) {
      this._wei = newweidht ;
    }
  }
  set surface(int newsurface) {
    if (newsurface <= 1000 ) {
      this._sf = newsurface ;
    }
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
    map['pres']=_pres;
    map['ci']=_ci;
    map['cmn']=_cmn;
    map['cmx']=_cmx;
    map['vol']=_vol;
    map['prix']=_prix;
    map['name']=_np;
    map['height']=_hei;
    map['weidht']=_wei;
    map['surface']=_sf;

    return map;
  }

  // Extract a Note object from a Map object
  medecament.fromMapObject(Map<String, dynamic> map) {
    print(map);
    this._id = map['id'];
    this._Name = map['title'];
    this._labo = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._pres=map['pres'];
    this._ci=map['ci'];
    this._cmn=map['cmn'];
    this._cmx=map['cmx'];
    this._vol=map['vol'];
    this._prix=map['prix'];
    this._np=map['name'];
    this._hei=map['height'];
    this._wei=map['weidht'];
    this._sf=map['surface'];
  }
}




