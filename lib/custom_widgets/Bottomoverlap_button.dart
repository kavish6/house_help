import 'package:flutter/material.dart';

class BottomOverlapButton extends StatelessWidget {
  const BottomOverlapButton({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.directional(
            start: (width * .42),
            textDirection: TextDirection.ltr,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(20.0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                )),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: (height * .025), horizontal: (width * .133))),
                backgroundColor: MaterialStateProperty.all(Color(0xff25232b)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/Login');
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: (height * .03),
                ),
              ),
            ),
          ),
          Positioned.directional(
            start: -(width * .036),
            textDirection: TextDirection.ltr,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(20.0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: (height * .025), horizontal: (width * .133))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/Register');
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Color(0xff191720),
                  fontSize: (height * .03),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
