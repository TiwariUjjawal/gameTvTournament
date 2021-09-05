import 'package:assignment/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/auth_screen.dart';

bool isLoggedIn = false;
String username = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool("isLoggedIn") ?? false; // stores Login Status.
  username = prefs.getString("loggedInUser") ??
      ""; // stores current username if loggedin.
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//##########################################################################################//
//                                                                                          //
//       If user is not logged in User Authentication Screen will be rendered first.        //
//       Otherwise HomeScreen will be visible directly.                                     //
//                                                                                          //
//##########################################################################################//

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomeScreen(username) : AuthScreen(),
    );
  }
}
