import 'package:flutter/material.dart';
import 'package:phar/screens/change_password_screen.dart';
import 'package:phar/screens/change_username_screen.dart';
import 'package:phar/screens/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;
  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/rah2.jpg",
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Pharmacist",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1,),)
                ],
              )),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ChangePasswordPage()));
            },
            leading: Icon(Icons.phonelink_setup),
            title: Text(
                "change the password"
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChangeUserNamePage()));
            },
            leading: Icon(Icons.border_color),
            title: Text("Change the code"),
          ),

          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
                    (Route<dynamic> route) => false,
              );
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out" ),
          ),
        ],
      ),
    );
  }
}