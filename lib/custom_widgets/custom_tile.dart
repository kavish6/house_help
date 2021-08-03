import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {required this.height,
      required this.workerData,
      required this.label,
      required this.field});

  final double height;
  final Map<String, dynamic> workerData;
  final String label;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: (height * .02)),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$label:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: (height * .03),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${workerData[field]}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: (height * .03),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
