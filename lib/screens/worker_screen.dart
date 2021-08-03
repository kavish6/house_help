import 'package:flutter/material.dart';
import 'package:house_help/custom_widgets/custom_tile.dart';

class WorkerScreen extends StatefulWidget {
  @override
  _WorkerScreenState createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var height = media.height;
    var width = media.width;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Map<String, dynamic> workerData = arg['data'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff25232c),
        title: Text('Worker Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: (height * .05), horizontal: (width * .05)),
        child: Column(
          children: [
            CustomTile(
              height: height,
              workerData: workerData,
              label: 'Name',
              field: 'name',
            ),
            SizedBox(
              height: (height * .05),
            ),
            CustomTile(
              height: height,
              workerData: workerData,
              label: 'Chore',
              field: 'chore',
            ),
            SizedBox(
              height: (height * .05),
            ),
            CustomTile(
              height: height,
              workerData: workerData,
              label: 'Hourly Rate',
              field: 'hourly rate',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all((height * .01)),
        child: ElevatedButton(
          child: Text('Book'),
          onPressed: () {},
        ),
      ),
    );
  }
}
