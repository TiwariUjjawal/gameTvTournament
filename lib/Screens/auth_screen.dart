import 'package:assignment/Screens/home_screen.dart';
import 'package:assignment/Widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//##########################################################################################//
//                                                                                          //
//                             User Authentication Screen.                                  //
//                                                                                          //
//##########################################################################################//

class AuthScreen extends StatelessWidget {
  void submitFn(
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//########## If user is signing up! #############//

    if (isLogin == false) {
      String userExists = prefs.getString(username) ?? "";
      if (userExists != "") {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("User already exists, please log in!"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      } else {
        prefs.setString(username, password);
        prefs.setString("loggedInUser", username);
        prefs.setBool("isLoggedIn", true);
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (ctx) {
              return HomeScreen(
                  username); // if authentication is approved ==> Navigation to HomeScreen.
            },
          ),
        );
      }
    }

//########## If user is logging in! #############//
    else {
      String passwordSP = prefs.getString(username) ?? "";
      if (passwordSP == password) {
        prefs.setBool("isLoggedIn", true);
        prefs.setString("loggedInUser", username);
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (ctx) {
              return HomeScreen(
                  username); // if authentication is approved ==> Navigation to HomeScreen.
            },
          ),
        );
      } else if (passwordSP != "") {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Wrong password, please try again!"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("User does not exists, please register first!"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthForm(
        submitFn,
      ),
    );
  }
}
