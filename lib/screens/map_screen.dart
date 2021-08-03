import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:house_help/utilities/authentication_helper.dart';
import 'package:house_help/utilities/database_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool loading = false;
  late CameraPosition initialCameraPosition;
  Completer<GoogleMapController> _controller = Completer();
  var bitmapIcon;
  void initState() {
    getIcon();
    super.initState();
  }

  void getIcon() async {
    print('start');
    bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20, 20)), 'images/ymarker.png');
    setState(() {});
    print('end');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var height = media.height;
    var width = media.width;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    double latitude = arg['latitude'];
    double longitude = arg['longitude'];
    String chore = arg['chore'];
    Map<String, LatLng> workers = arg['workers'];
    List<Marker> markers = [
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
            title: 'Your location', snippet: 'This is your location'),
      ),
    ];
    void setMark() {
      int a = 2;
      workers.forEach((key, value) async {
        print(value);
        markers.add(
          Marker(
              markerId: MarkerId('marker$a'),
              position: value,
              icon: bitmapIcon,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                Map<String, dynamic> j = await DataBaseHelp().findWorker(key);

                Navigator.pushNamed(context, '/Worker', arguments: {
                  'data': j,
                });
                setState(() {
                  loading = false;
                });
                //either use a map to send data or use the class object that u have created(worker_data class)
              }),
        );
        a += 1;
      });
      setState(() {
        print(markers.length);
      });
    }

    setMark();
    return loading
        ? Scaffold(
            body: SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          )
        : Scaffold(
            body: Stack(children: [
              GoogleMap(
                markers: Set.from(markers),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude), zoom: 14),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
                bottom: (height * .12),
                right: (width * .005),
                child: TextButton(
                    onPressed: () async {
                      await AuthenticationHelper().logOut();
                      Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      color: Colors.grey,
                      child: Text(
                        'Log-Out',
                        style: TextStyle(
                            fontSize: (height * .03), color: Colors.black),
                      ),
                    )),
              ),
            ]),
          );
  }
}
