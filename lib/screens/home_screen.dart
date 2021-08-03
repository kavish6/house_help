import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_help/constants.dart';
import 'package:house_help/custom_widgets/Bottomoverlap_button.dart';
import 'package:house_help/utilities/authentication_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  DataBaseHelp dataBaseHelp = DataBaseHelp();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var height = media.height;
    var width = media.width;
    return loading
        ? Scaffold(
            body: SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          )
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                  top: (height * .06),
                  left: (width * .07),
                  right: (width * .07)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: CircleAvatar(
                        radius: (height * .251),
                        backgroundImage: AssetImage('images/homeimage.jpg')),
                  ),
                  SizedBox(height: (height * .012)),
                  Text(
                    'House Help',
                    style: kMainTextStyle.copyWith(fontSize: (height * .05)),
                  ),
                  SizedBox(
                    height: (height * .012),
                  ),
                  Text(
                    'This application allows you to easily hire househelp at the touch of a button ,with the feeling of security.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        wordSpacing: 3.0,
                        color: Colors.grey.shade600,
                        fontFamily: 'DelaGothicOne',
                        fontSize: (height * .018)),
                  ),
                  SizedBox(
                    height: (height * .02),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(20.0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      )),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: (height * .025),
                          horizontal: (width * .133))),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff25232b)),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      bool a = await AuthenticationHelper().signInWithGoogle();
                      if (a) {
                        bool x = await dataBaseHelp.readData();
                        if (!x)
                          Navigator.pushNamed(context, '/Info');
                        else
                          Navigator.pushNamed(context, '/Loggedin');
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          EvaIcons.google,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: (width * .02),
                        ),
                        Text(
                          'Google sign in',
                          style: TextStyle(
                            fontSize: (height * .03),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomOverlapButton(width: width, height: height)
                ],
              ),
            ),
          );
  }
}
