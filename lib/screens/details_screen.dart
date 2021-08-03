import 'package:flutter/material.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:house_help/custom_widgets/custom_bottom.dart';
import 'package:house_help/constants.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DataBaseHelp a = DataBaseHelp();
  @override
  void initState() {
    z();
    super.initState();
  }

  void z() async {
    await a.readData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var height = media.height;
    var width = media.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAILS'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: (height * .3)),
        child: Center(
          child: Column(
            children: [
              Text(
                'Name : ${a.fullName}',
                style: kMainTextStyle.copyWith(fontSize: (height * .03)),
              ),
              SizedBox(
                height: (height * .1),
              ),
              Text(
                'Number :${a.number} ',
                style: kMainTextStyle.copyWith(fontSize: (height * .03)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottom(
        height: height,
        width: width,
        text1: 'Booking',
        text2: 'Log-out',
        f: () {
          Navigator.pushNamed(context, '/Loggedin');
        },
      ),
    );
  }
}
