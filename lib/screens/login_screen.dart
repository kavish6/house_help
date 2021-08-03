import 'package:flutter/material.dart';
import 'package:house_help/constants.dart';
import 'package:house_help/custom_widgets/custom_textfield.dart';
import 'package:house_help/utilities/authentication_helper.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  DataBaseHelp dataBaseHelp = DataBaseHelp();
  AuthenticationHelper authenticationHelper = AuthenticationHelper();
  String email = '';
  String password = '';
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  bool keyboard = false;
  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus)
        setState(() {
          keyboard = true;
        });
    });
    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus)
        setState(() {
          keyboard = true;
        });
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xff25232b),
              title: Text('Login'),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: (height * .02), horizontal: (width * .02)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                            radius: (height * .1),
                            backgroundImage:
                                AssetImage('images/homeimage.jpg')),
                      ),
                      SizedBox(width: (width * .04)),
                      Text(
                        'LOGIN',
                        style:
                            kMainTextStyle.copyWith(fontSize: (height * .025)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: (height * .02),
                  ),
                  CustomTextField(height, 'Email', false, _focusNode, (text) {
                    email = text;
                  }),
                  SizedBox(
                    height: (height * .02),
                  ),
                  CustomTextField(height, 'Password', true, _focusNode2,
                      (text) {
                    password = text;
                  }),
                  SizedBox(
                    height: keyboard ? (height * .01) : (height * .35),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await authenticationHelper.loginUser(email, password);
                      bool x = await dataBaseHelp.readData();
                      if (!x)
                        Navigator.pushNamed(context, '/Info');
                      else
                        Navigator.pushNamed(context, '/Loggedin');
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: (height * .02))),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: (width * .2),
                            vertical: (height * .02))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                ],
              ),
            ),
          );
  }
}
