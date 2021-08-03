import 'package:flutter/material.dart';
import 'package:house_help/constants.dart';

class ChoreContainer extends StatelessWidget {
  ChoreContainer(
      {required this.height,
      required this.width,
      required this.imageAsset,
      required this.label,
      required this.tap});

  final double height;
  final double width;
  final String imageAsset;
  final String label;
  final Function tap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tap();
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: (height * .02), horizontal: (width * .05)),
          color: Color(0xff1e1c24),
          child: Row(
            children: [
              Image.asset(
                imageAsset,
                height: (height * .15),
                width: (width * .35),
              ),
              SizedBox(
                width: (width * .1),
              ),
              Text(
                label,
                style: kMainTextStyle.copyWith(fontSize: (height * .03)),
              ),
            ],
          )),
    );
  }
}
