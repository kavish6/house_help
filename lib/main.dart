import 'package:flutter/material.dart';
import 'package:house_help/screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/loggedin_screen.dart';
import 'utilities/authentication_helper.dart';
import 'screens/info_screen.dart';
import 'utilities/database_helper.dart';
import 'screens/details_screen.dart';
import 'screens/map_screen.dart';
import 'screens/worker_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool x = await DataBaseHelp().readData();
  runApp(MyApp(x));
}

AuthenticationHelper authenticationHelper = AuthenticationHelper();

class MyApp extends StatelessWidget {
  MyApp(this.x);
  final bool x;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Color(0xff25232c)),
      initialRoute: authenticationHelper.checkStatus()
          ? (x ? '/Loggedin' : '/Info')
          : '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Register': (context) => RegistrationScreen(),
        '/Login': (context) => LoginScreen(),
        '/Loggedin': (context) => LoggedInScreen(),
        '/Info': (context) => InfoScreen(),
        '/Detail': (context) => DetailsScreen(),
        '/Map': (context) => MapScreen(),
        '/Worker': (context) => WorkerScreen(),
      },
    );
  }
}
