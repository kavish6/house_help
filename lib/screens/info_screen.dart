import 'package:flutter/material.dart';
import 'package:house_help/custom_widgets/custom_textfield.dart';
import 'package:house_help/constants.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool loading = false;
  DataBaseHelp dataBaseHelp = DataBaseHelp();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  String name = '';
  String number = '';
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
              backgroundColor: Colors.white,
              title: Text(
                'Info',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: (height * .02)),
              child: Column(
                children: [
                  Text(
                    'Enter Details',
                    style: kMainTextStyle.copyWith(fontSize: (height * .03)),
                  ),
                  SizedBox(
                    height: (height * .05),
                  ),
                  CustomTextField(height, 'Name', false, _focusNode, (temp) {
                    name = temp;
                  }),
                  SizedBox(
                    height: (height * .07),
                  ),
                  CustomTextField(height, 'Number', false, _focusNode1, (temp) {
                    number = temp;
                  }),
                  SizedBox(
                    height: (height * .03),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
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
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await dataBaseHelp.addUser(name, number);
                      Navigator.pushNamed(context, '/Loggedin');
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (height * .03),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // todo:a later todo but when the keyboard comes up add a responsive animation..
  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }
}
