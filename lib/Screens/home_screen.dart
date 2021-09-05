import 'dart:io';
import 'package:assignment/Screens/auth_screen.dart';
import 'package:assignment/Widgets/profile.dart';
import 'package:assignment/Widgets/stats_capsule.dart';
import 'package:assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assignment/ApiHandler/fetch_data.dart';
import 'package:assignment/Model/tournament.dart';
import 'package:assignment/Widgets/tournament_card.dart';

//##########################################################################################//
//                                                                                          //
//                                      Home Screen.                                        //
//                                                                                          //
//##########################################################################################//

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen(this.username);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();
  List<Tournament> tournaments = [];
  int index = 0;
  int limit = 10;
  String cursor = "";
  late Future<List<Tournament>> _future;

  bool isConnected = false;

//########## Checking Internet Connectivity ############//

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {
          isConnected = true;
          print('conn');
        });
      }
    } on SocketException catch (err) {
      setState(() {
        isConnected = false;
      });
      print(err);
    }
  }

  void initState() {
    _checkInternetConnection();
    _future = fetchData(limit, cursor);

//##########################################################################################//
//                                  Pagenation                                              //
//        if user is scrolled till bottom new list of tournaments will be added             //                              //
//##########################################################################################//
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          cursor = tournaments.last.cursor;
          _future = fetchData(limit, cursor);
          _checkInternetConnection();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(context),
              Profile(widget.username),
              SizedBox(
                height: 10,
              ),
              StatsCapsule(),
              SizedBox(
                height: 15,
              ),
              if (isConnected)
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    "Recommended for you",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              isConnected
                  ? getTournamentList(index, limit, cursor)
                  : Center(
                      child: Column(
                      children: [
                        Image.asset(
                          "images/waiting.png",
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "No Internet Connection!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }

  // #### Header containing Logout Dropdown Also #### //

  Widget header(BuildContext ctx) {
    double size = MediaQuery.of(ctx).size.height * 0.05;
    return Container(
      height: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Expanded(
            child: Text(
              "Flyingwolf",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size / 2,
              ),
            ),
          ),
          logOutDropDown(),
        ],
      ),
    );
  }

  Widget logOutDropDown() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ],
              ),
            ),
            value: 'logout',
          ),
        ],
        onChanged: (itemIdentifier) async {
          if (itemIdentifier == 'logout') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("isLoggedIn", false);
            isLoggedIn = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AuthScreen();
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget getTournamentList(int index, int limit, String cursor) {
    return FutureBuilder<List<Tournament>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Some Internal Error Occures!",
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          if (tournaments.length == 0 ||
              tournaments.last.cursor != snapshot.data?[0].cursor) {
            for (var tournament in snapshot.data ?? []) {
              tournaments.add(tournament);
            }
          }
          return Column(
            children: [
              ...tournaments.map((tournament) {
                return TournamentCard(
                  tournament.name,
                  tournament.coverUrl,
                  tournament.gameName,
                );
              })
            ],
          );
        }
      },
    );
  }
}
