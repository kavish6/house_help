import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:house_help/constants.dart';
import 'package:house_help/custom_widgets/chore_container.dart';
import 'package:house_help/custom_widgets/custom_bottom.dart';
import 'package:house_help/utilities/location_helper.dart';
import 'package:geocoder/geocoder.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoggedInScreen extends StatefulWidget {
  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  bool loading = false;
  late double latitude;

  late double longitude;

  Future<void> getLoc() async {
    Position currentPosition = await determinePosition();
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
  }

  List<Marker> customMarker = [];

  Future<void> implementChore(BuildContext context, String chore) async {
    setState(() {
      loading = true;
    });
    var workerLoc = await DataBaseHelp().workerData(chore);
    await getLoc();
    final coordinates = new Coordinates(latitude, longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    DataBaseHelp().updateUser(first.addressLine);

    Navigator.pushNamed(context, '/Map', arguments: {
      'latitude': latitude,
      'longitude': longitude,
      'chore': chore,
      'workers': workerLoc,
    });
    setState(() {
      loading = false;
    });
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
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: (height * .07)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Chores',
                    style: kMainTextStyle.copyWith(fontSize: (height * .05)),
                  ),
                  SizedBox(
                    height: (height * .05),
                  ),
                  ChoreContainer(
                    height: height,
                    width: width,
                    imageAsset: 'images/clean2.jpg',
                    label: 'CLEANING',
                    tap: () async {
                      implementChore(context, 'cleaning');
                    },
                  ),
                  SizedBox(
                    height: (height * .028),
                  ),
                  ChoreContainer(
                    height: height,
                    width: width,
                    imageAsset: 'images/cooking.jfif',
                    label: 'COOKING',
                    tap: () async {
                      implementChore(context, 'cooking');
                    },
                  ),
                  SizedBox(
                    height: (height * .028),
                  ),
                  ChoreContainer(
                    height: height,
                    width: width,
                    imageAsset: 'images/washing1.jpg',
                    label: 'WASHING',
                    tap: () async {
                      implementChore(context, 'washing');
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottom(
              width: width,
              height: height,
              text1: 'Details',
              text2: 'Log-out',
              f: () {
                Navigator.pushNamed(context, '/Detail');
              },
            ),
          );
  }
}
