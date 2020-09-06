import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phar/models/medicament.dart';
import 'package:phar/models/ordonnance.dart';
import 'package:phar/models/patient.dart';
import 'package:phar/screens/showpage.dart';
import 'package:phar/utils/database_helper.dart';

class CalculPage extends StatefulWidget {
  @override
  _CalculPageState createState() => _CalculPageState();
}

class _CalculPageState extends State<CalculPage> {
  final List<BoxShadow> myShadows = <BoxShadow>[
    new BoxShadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(2.0, 2.0))
  ];

  DatabaseHelper databaseHelper = DatabaseHelper();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Controllers - Textfields
  TextEditingController _laboController = TextEditingController();

  Ordonnance _ordonnance = Ordonnance();

  Patient currentSelectedPatient;
  Medicament currentSelectedMedicament;

  List<Medicament> _listMedicament = List();
  List<Patient> _listPatient = List();

  TextEditingController _presentationcontroller = TextEditingController();
  TextEditingController _posologieController = TextEditingController();
  TextEditingController _reductionController = TextEditingController();
  TextEditingController _dosage_inject_Controller = TextEditingController();
  TextEditingController _volumfinalController = TextEditingController();
  TextEditingController _reliquatContoller = TextEditingController();
  TextEditingController _volum_after_preparation =TextEditingController();

  double volume;
  double newReliquat = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      _listMedicament = await databaseHelper.getMedecamentList();
      _listPatient = await databaseHelper.getPatientList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_posologieController.text=_ordonnance.posologie?.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.teal[600],
          Colors.white,
        ])),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 250, top: 20.0, bottom: 300.0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    // Write some code to control things, when user press back button in AppBar
                    Navigator.of(context).pop();
                  }),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 190.0, right: 30.0, top: 70.0, bottom: 60.0),
              child: Image.asset("assets/rahma4.png"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 20.0, right: 90.0, top: 90.0, bottom: 60.0),
              child: Text("Let's",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0)),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 80.0, right: 90.0, top: 120.0, bottom: 60.0),
              child: Text("Start",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 25.0)),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 220.0, bottom: 50.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: myShadows,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView(
                      //scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButton<Patient>(
                          hint: Text('Name of Patient'),
                          value: currentSelectedPatient,
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          elevation: 16,
                          isExpanded: true,
                          items: _listPatient
                              .map(
                                (patient) => DropdownMenuItem<Patient>(
                                  child: Text(patient.name),
                                  value: patient,
                                ),
                              )
                              .toList(),
                          onChanged: (newValue) {
                            setState(
                              () {
                                currentSelectedPatient = newValue;
                              },
                            );

                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        DropdownButton<Medicament>(
                          value: currentSelectedMedicament,
                          isExpanded: true,
                          isDense: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          elevation: 16,
                          hint: Text("Choose medicament"),
                          items: _listMedicament.map((Medicament medicament) {
                            return DropdownMenuItem<Medicament>(
                              child: Text(
                                  "${medicament?.title} - ${medicament.pres} ml"),
                              value: medicament,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              currentSelectedMedicament = value;
                              _laboController.text =
                                  currentSelectedMedicament.description;
                              _presentationcontroller.text =
                                  currentSelectedMedicament.pres.toString();
                            });
                            //_calculate();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Laboratory",
                            labelText: "Laboratory",
                            border: OutlineInputBorder(),
                          ),
                          controller: _laboController,
                          enabled: false,
                        ),
                        /*    SizedBox(
                          height: 20,
                        ),
                            TextFormField(
                          decoration: InputDecoration(
                            hintText: "Prestentation",
                            labelText: "Prestentation",
                            border: OutlineInputBorder(),
                          ),
                          controller: 56 ,
                          enabled: false,
                        ),*/
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Dosage mg/m2",
                            labelText: "Doage mg/m2",
                            border: OutlineInputBorder(),
                          ),
                          controller: _posologieController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Reduction",
                            labelText: "Reduction",
                            border: OutlineInputBorder(),
                          ),
                          controller: _reductionController,

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " Dose to inject  mg",
                              labelText: "Dosage to inject  mg",
                              border: OutlineInputBorder()),
                          controller: _dosage_inject_Controller,
                          enabled: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " Final volum  ml",
                              labelText: "Final volum  ml",
                              border: OutlineInputBorder()),
                          controller: _volumfinalController,
                          enabled: false,

                        ),
                       /* SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " Volum after preparation  ml",
                              labelText: " Volum after preparation ml",
                              border: OutlineInputBorder()),
                          controller: _volum_after_preparation,
                          enabled: false,

                        ),*/


                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Leftover mg ",
                              labelText: "Leftover  mg",
                              border: OutlineInputBorder()),
                          controller: _reliquatContoller,
                          enabled: false,
                        ),

                        SizedBox(
                          height: 20,

                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                onPressed: () {
                                  _calculate();
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (_) => DetailPage()),
//                                  );
                                },
                                padding: EdgeInsets.all(12),
                                color: Colors.cyan[700],
                                child: Text('Calculate',
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _calculate() async {
    if (currentSelectedPatient != null && currentSelectedMedicament != null &&
        _posologieController.text.isNotEmpty &&
        _reductionController.text.isNotEmpty

    ) {
      double dosage = currentSelectedPatient.surface *
          (double.parse((_posologieController.text ?? 0))) *
          (double.parse((_reductionController.text ?? 0)));


      volume = dosage / currentSelectedMedicament.ci;


      if(currentSelectedMedicament.reliquat > 0){
        //current medicament 3ado reliquat
        print("############################## MEDICAMENT HAS PREVIOUS REIQUAT #########################################");
        double _rest = volume - currentSelectedMedicament.reliquat;
        //check if the rest either >0 || ==0 || <0
        if (_rest > 0){
          //mazal volume lazem nakhadmoh, y7al flacon jdod
          print(" LE RESTE >>>>>> 0 ");
          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("We will use ALL the reliquat")));
          volume = volume - currentSelectedMedicament.reliquat;
          _calculeVolumeAndReliquat();


        } else if (_rest == 0){
          //reliquat tekfi bach nakhadmi volume hada
          print("LE  RESTE  ===========0");
          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("We will use ALL the reliquat, reste = 0 ")));
          //update reliquat f la base de donnee
          currentSelectedMedicament.reliquat = 0;
          //

        } else {
          // reliquat tekfi w tfadhel
          print("LE RESTE <<<<<<<<<<<  0 ");
          newReliquat = currentSelectedMedicament.reliquat - volume;



        }
      } else {
        //current medicament ma 3andouche reliqat
        print("############################## MEDICAMENT HAS NO NO NO PREVIOUS REIQUAT #########################################");
        _calculeVolumeAndReliquat();


      }

      //Affichage du resultat dans les champs qui correspondant
      _dosage_inject_Controller.text = dosage.toString();
      _volumfinalController.text = volume.toString();
      _reliquatContoller.text = newReliquat.toString();



      _ordonnance.dosage = dosage;
      _ordonnance.patient_id = currentSelectedPatient.id;
      _ordonnance.medicament_id = currentSelectedMedicament.id;
      _ordonnance.date = DateTime.now().toString();
      _ordonnance.posologie = double.parse(_posologieController.text);
      _ordonnance.reduction =int.parse(_reductionController.text);
      _ordonnance.volum_a_administer = volume;

      if (newReliquat > 0){
        currentSelectedMedicament.reliquat = newReliquat;
        currentSelectedMedicament.reliquatDate = DateTime.now().toString();
        _ordonnance.reliquat = newReliquat;
      } else {
        currentSelectedMedicament.reliquat = 0.0;
        _ordonnance.reliquat = 0;
      }

      print("######### ORDONANCE #######");
      print(_ordonnance.toMap());
      print("######### MEDICAMENT #######");
      print(currentSelectedMedicament.toMap());
      //Save the ordonance
      int result = await databaseHelper.insertOrdonance(_ordonnance);
      await databaseHelper.updateMedecament(currentSelectedMedicament);


      if (result>0) {
        print("yeeees");
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(
          patient: currentSelectedPatient,
          medicament: currentSelectedMedicament,
          ordonnance: _ordonnance,
        ),),);
      }


    }
  }

  void _calculeVolumeAndReliquat() {
    //Calcule ta3 reliquat, tji after we check if there is some previous reliquat
    double reliquat = currentSelectedMedicament.volumInitial - volume;



    if( reliquat > 0){
      print("Reliquat is >>> 0 ===> $reliquat +ml");
      //todo: mba3da naffichihom f showpage
      newReliquat = reliquat;
    }else{
      print("Reliquat is <<<< 0");
      double resultOf9isma = volume / currentSelectedMedicament.volumInitial;
      //print("reliquat dakheel  else is $reliquat");
      if((resultOf9isma % 1)==0){// reliquat is an integer
        print("nombre de flacon utilisé $resultOf9isma");
        resultOf9isma=0;
        print("Reliquat is $resultOf9isma");
      }else{

        double fraction = reliquat - reliquat.truncate();
        print("flacon $reliquat");
        //truncate() function for double type which returns the integer part discarding the fractional part.
        double tahwil= fraction*currentSelectedMedicament.volumInitial;
        reliquat = currentSelectedMedicament.volumInitial - tahwil;
        print( "reliquat final $reliquat");

//        print("srface ${currentSelectedPatient.surface}");
//        print("c_minimal ${currentSelectedMedicament.cmn} ");
//        print("c_maximal ${currentSelectedMedicament.cmx}");
        print("tahwil $tahwil");
        print("vvol ${currentSelectedMedicament.volumInitial}");

      }
      _reliquatContoller.text = reliquat.toString();
      newReliquat = reliquat;
    }

    if (volume >=
        currentSelectedMedicament.cmn * 250 &&
        volume <=
            250 * currentSelectedMedicament.cmx) {
      print("use a serum bag of 250 ml");
      _ordonnance.type_poche = 250;

    } else if (volume >=
        currentSelectedMedicament.cmn * 500 &&
        volume <=
            500 * currentSelectedMedicament.cmx) {

      print("use a serum bag of 500 ml");
      _ordonnance.type_poche = 500;
    } else {
      //Sinn
      _ordonnance.type_poche = 1000;

    }
  }
}
