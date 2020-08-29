
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phar/models/user.dart';
import 'package:phar/screens/foldable.dart';
import 'package:phar/screens/medicament_list.dart';
import 'package:phar/utils/database_helper.dart';


class LoginPage extends StatelessWidget {
  TextEditingController psConroller=TextEditingController();
  TextEditingController codeContorller=TextEditingController();
  DatabaseHelper helper = DatabaseHelper();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 350,
              height: 250,
              child: Image.asset("assets/pharm1.jpg"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),

              //padding: EdgeInsets.only(left: 5, top: 200, right: 20),
              height: 30,
              width: 70,
              child: Text('Pharmacal ',style: TextStyle(fontSize: (25.0),letterSpacing: 3.0 ,fontWeight: FontWeight.bold),),
              alignment: Alignment.center,

            ),
             Container(
               height: 60,
               child: TextFormField(

                 controller:codeContorller,
                 keyboardType: TextInputType.text,
                 decoration: InputDecoration(
                   labelText: "User Name",
//                   border: new OutlineInputBorder(
//                       borderRadius: const BorderRadius.all(const Radius.circular(30.0),)
//                   ),
                   labelStyle: TextStyle(
                     color: Colors.black38,
                     fontWeight: FontWeight.w400,
                     fontSize: 20,
                   ),
                 ),
                 style: TextStyle(fontSize: 20),
               ),
             ),

            Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 15),
              child:TextFormField(

                controller: psConroller,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "password",
//                  border: new OutlineInputBorder(
//                      borderRadius: const BorderRadius.all(const Radius.circular(30.0),)
//                  ),
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),



            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal:20, vertical: 5),
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [
                    Color(0xFF00897B),
                    Color(0XFFB2DFDB),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                  onPressed: () {
                    //verification
                    // ctrl 1 . text . length <5 => show msg " code lazem ykon ...."
                    // else ... ctrl 2
                    _login(context);

                  },
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical:3),

              height: 20,
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {


                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    //logic ta3 login,

    if(codeContorller.text.length < 5 || psConroller.text.length < 5){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Code and password should be at least 5 characters")));
    }
    else{
      // raho dakhal les info bien, > 5 characters, bghaal berk, kaz
      User user = User("", codeContorller.text.toString().trim(), psConroller.text.toString().trim());
      User result = await helper.loginUser(user);
      if (result != null){
        //User exist, info are correct
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyHomePage()));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Code or password is not correct")));

      }

    }



    //f la fin
  }
}
