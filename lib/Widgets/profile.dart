import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String username;
  Profile(this.username);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.1;
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                //  color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: AssetImage("images/avatar.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(size / 2)),
                // border: Border.all(
                //   color: Colors.orange[800] ?? Colors.orange,
                //   width: 2.0,
                // ),
              ),
            ),
            nameAndEloWidget(size),
          ]),
    );
  }

  Widget nameAndEloWidget(double size) {
    return Container(
      height: size,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            username,
            style: TextStyle(fontSize: size / 4, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent[400] ?? Colors.blue,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                Text(
                  "2150",
                  style: TextStyle(
                    fontSize: size / 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Elo rating",
                    style: TextStyle(
                      fontSize: size / 6,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
