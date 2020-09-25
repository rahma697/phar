import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:phar/screens/constant.dart';
import 'package:phar/screens/foldable.dart';
import 'package:phar/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        padding: EdgeInsets.only(left: 40, top: 50, right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors:
            [
              Colors.teal[700],
              Colors.teal[400],
              Colors.white,
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/virus.png"),
          ),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 1.0, top: 0.0),
                      child: IconButton(icon: Icon(Icons.arrow_back_ios,  color: Colors.white),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyHomePage();
                                },
                              ),
                            );
                          }
                      )
                  ),
                  Container(

                      child: IconButton(icon: Icon(Icons.arrow_forward_ios,  color: Colors.white),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return InfoScreen();
                                },
                              ),
                            );
                          }
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    child: Image.asset(
                      widget.image,
                      width: 180,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Positioned(
                    top: 20 - widget.offset / 2,
                    left: 160,
                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
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