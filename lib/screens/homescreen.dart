import 'package:flutter/material.dart';
import 'package:phar/screens/calcul.dart';
import 'package:phar/screens/foldable.dart';
import 'package:phar/screens/info_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:phar/screens/counter.dart';
import 'constant.dart';
import 'my_header.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  int currentTab=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

//      bottomNavigationBar: BottomAppBar(
//        shape: CircularNotchedRectangle(),
//        notchMargin: 10,
//        child: Container(
//          height:70,
//          child:Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    MaterialButton(
//                      minWidth: 70,
//                      onPressed: () {
//                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyApp()));
//                        setState(() {
//                          currentTab = 0;
//                        });
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Icon(
//                            Icons.home,
//                            color: currentTab == 1 ? Colors.teal[700] : Colors.grey[700],
//                          ),
//                          Text(
//                            'Home',
//                            style: TextStyle(
//                              color: currentTab == 1 ? Colors.teal[700] : Colors.grey,fontSize: 15,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//                // Right Tab bar icons
//                Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      MaterialButton(
//                        minWidth: 40,
//                        onPressed: () {
//                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => InfoScreen()));
//                          setState(() {
//                            // if user taps on this dashboard tab will be active
//                            currentTab = 2;
//                          });
//                        },
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//
//                            Icon(
//
//                              Icons.assignment,
//                              color: currentTab == 2 ? Colors.teal[700] : Colors.grey[700],
//                            ),
//                            Text(
//                              'More',
//                              style: TextStyle(
//                                color: currentTab == 2 ? Colors.teal[700]: Colors.grey[700],fontSize: 15,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ]
//                )
//              ]
//          ),
//        ),
//      ),
      body: SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.only(left: 0, top:0, right: 0),
        child: Column(
          children: <Widget>[


               MyHeader(
                  image: "assets/ma1.png",
                  textTop: "You need to",
                  textBottom: "stay at home.",
                  offset: offset,
                  topRightIcon: Icons.arrow_back,
                  topLeftIcon: Icons.arrow_forward,
                  iconColor: Colors.white,
                  onIconTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => InfoScreen()));
               },
                ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),

              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),

                  SizedBox(width: 20),
                  Expanded(

                    child: Text('Algeria',style: TextStyle(fontWeight: FontWeight.bold),),

                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update Aug 4",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Text('see Details', style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),),
                        onTap:(){
                         launch('https://news.google.com/covid19/map?hl=fr&mid=%2Fm%2F0h3y&gl=FR&ceid=FR%3Afr');
                          } ,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: 3250,
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: 1248,
                          title: "Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: 2237,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      InkWell(
                        child: Text('see Details', style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),),
                        onTap:(){
                          launch('https://www.worldometers.info/coronavirus/');
                           } ,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/ma7.png",
                      fit: BoxFit.fill,
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