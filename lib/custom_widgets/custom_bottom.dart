import 'package:flutter/material.dart';
import 'package:house_help/utilities/authentication_helper.dart';

class CustomBottom extends StatelessWidget {
  CustomBottom(
      {required this.width,
      required this.height,
      required this.text1,
      required this.text2,
      required this.f});

  final double width;
  final double height;
  final String text1;
  final String text2;
  final Function f;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff25232c),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: (width * .15), vertical: (height * .015)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                f();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1e1c24),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: (height * .02), horizontal: (width * .04)),
                child: Text(
                  text1,
                  style: TextStyle(
                      fontSize: (height * .03), color: Colors.white60),
                ),
              ),
            ),
            SizedBox(
              width: (width * .12),
            ),
            GestureDetector(
              onTap: () async {
                await AuthenticationHelper().logOut();
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1e1c24),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: (height * .02), horizontal: (width * .04)),
                child: Text(text2,
                    style: TextStyle(
                        fontSize: (height * .03), color: Colors.white60)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
