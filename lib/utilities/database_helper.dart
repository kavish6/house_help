import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DataBaseHelp {
  String fullName = '';
  String number = '';
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addUser(String fullName, String number) {
    var currentUser = auth.currentUser;
    CollectionReference users = fireStore.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUser?.uid)
        .set({'full_name': fullName, 'number': number})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> readData() async {
    var currentUser = auth.currentUser;
    CollectionReference users = fireStore.collection('users');
    DocumentSnapshot snapshot = await users.doc(currentUser?.uid).get();
    if (!snapshot.exists) {
      print('no document snapshot found ${currentUser?.uid}');
      return false;
    } else {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print('${data['full_name']}   ${data['number']} ');
      fullName = data['full_name'];
      number = data['number'];
      return true;
    }
  }

  Future<void> updateUser(String address) {
    var currentUser = auth.currentUser;
    CollectionReference users = fireStore.collection('users');
    return users
        .doc(currentUser?.uid)
        .update({'location': address})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<Map<String, LatLng>> workerData(String chore) async {
    Map<String, LatLng> workers1 = {};
    // List<LatLng> workers = [];
    await FirebaseFirestore.instance
        .collection('workers')
        .where('chore', isEqualTo: chore)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        GeoPoint x = doc['location'];
        // workers.add(LatLng(x.latitude, x.longitude));
        workers1[doc.id] = LatLng(x.latitude, x.longitude);
        print('${x.latitude}  ${x.longitude}');
      });
    });
    return workers1;
  }

  Future<Map<String, dynamic>> findWorker(String id) async {
    CollectionReference workers = fireStore.collection('workers');
    DocumentSnapshot snapshot = await workers.doc(id).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print('${data['name']} ${data['hourly rate']} ');
    return data;
  }
}
