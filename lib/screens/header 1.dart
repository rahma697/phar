import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:phar/screens/constant.dart';
import 'package:phar/screens/info_screen.dart';
import 'package:phar/screens/info_screen.dart';

class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  const MyHeader(
      {Key key, this.image, this.textTop, this.textBottom, this.offset})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}
class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 5, top:20, right: 5),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors:
            [
              Colors.teal[700],
              Colors.teal[200],
              Colors.white,
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/ma11.png"),

          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            /*Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Icon(Icons.clear_all, color: Colors.white,size: 35,),
                onTap: () {
                 setState(() {

                 });
                },

              ),
            ),*/
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    child: Image.asset(
                      widget.image,
                      width: 170,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Positioned(
                    top: 90- widget.offset / 2,
                    left: 180,

                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                        fontSize:17.0,
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}