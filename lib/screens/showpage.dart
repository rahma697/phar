
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:phar/models/medicament.dart';
import 'package:phar/models/ordonnance.dart';
import 'package:phar/models/patient.dart';
import 'package:phar/screens/fadeanimation.dart';
class DetailPage extends StatefulWidget {

  final Patient patient;
  final Medicament medicament;
  final Ordonnance ordonnance;

  const DetailPage({Key key, this.patient, this.medicament, this.ordonnance}) : super(key: key);

  @override
  State<StatefulWidget> createState() {

    return DetailPageState();
  }
}
const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: Color(0xFF303030),
  fontWeight: FontWeight.bold,
);
class DetailPageState extends State<DetailPage> {
  final List<BoxShadow> myShadows = <BoxShadow>[
    new BoxShadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(2.0, 2.0))
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.teal[700],
                  Colors.teal[400],
                  Colors.white,
                ]
            )
        ),

        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top:20, right: 20),
              child: FlatButton(
                onPressed: (){},
                child: IconButton(icon: Icon(
                  Icons.arrow_back,color: Colors.white,),
                    onPressed: () {
                      // Write some code to control things, when user press back button in AppBar
                      Navigator.of(context).pop();
                    }
                ),
              ),
            ),
              //alignment: Alignment.topRight,

            Container(
              margin: EdgeInsets.only(left: 90.0, top: 40.0),
              child: FadeAnimation( 2.4,Image.asset('assets/rahm2.png',width: 200,)),
            ),
            Container(
              margin: EdgeInsets.only(  top:230.0),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: myShadows,
              ),
              child:ListView(
                children: <Widget>[
                  Padding(

                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(2.4,Text("Final medical report", style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 2
                        ))),
                        SizedBox(height: 30),
                        FadeAnimation(4,PatientCard(
                          text: " body surface: ${widget.patient.surface}",
                          image: "assets/marw2.png",
                          title: widget.patient.name,
                        )),
                        if (widget.ordonnance.type_poche == 1000)
                        FadeAnimation(5,PatientCard(
                          text: "less than 250 or greater than 500",
                          image: "assets/marw4.png",
                          title: "serum bag",
                        )),
                        if (widget.ordonnance.type_poche <=500)
                          FadeAnimation(5,PatientCard(
                            text: "${widget.ordonnance.type_poche} ml",
                            image: "assets/marw4.png",
                            title: "serum bag",
                          )),
                        SizedBox(height:5),
                        FadeAnimation(6,CalculatedCard(
                          number: widget.ordonnance.dosage,

                          image: "assets/mar3.png",
                          title: "required dose(mg)",
                        )),
                        if (widget.ordonnance.reliquat > 0) ...[
                          SizedBox(height: 20),
                          FadeAnimation(7,CalculatedCard(

                            number: widget.medicament.reliquat ,
                            image: "assets/marw5.png",
                            title: "Leftover(ml)",
                          )),
                          SizedBox(height: 10),

                          FadeAnimation(7,PatientCard(
                            text: "${DateTime.parse(widget.medicament.reliquatDate).add(Duration(hours: widget.medicament.sta.toInt()))}",
                            image: "assets/marw1.png",
                            title: "expiration date",
                          )),
                        ],

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PatientCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PatientCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,left: 30),
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.centerLeft,

          children: <Widget>[
            Container(
              alignment: FractionalOffset.center,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color:Colors.white,
                  ),
                ],
              ),
            ),
            Image.asset(image,alignment: Alignment.topCenter,width: 50,height: 100,),
            Positioned(
              left: 80,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CalculatedCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  final double number;
  const CalculatedCard({
    Key key,
    this.image,
    this.title,
    this.text,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,left: 30),
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.centerLeft,

          children: <Widget>[
            Container(
              alignment: FractionalOffset.center,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color:Colors.white,
                  ),
                ],
              ),
            ),
            Image.asset(image,alignment: Alignment.topCenter,width: 50,height: 150,),
            Positioned(
              left: 80,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$number",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}