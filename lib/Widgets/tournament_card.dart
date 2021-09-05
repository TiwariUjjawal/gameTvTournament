import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  final String name;
  final String gameName;
  final String coverUrl;
  TournamentCard(this.name, this.coverUrl, this.gameName);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.1;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        elevation: 5,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                coverUrl,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              title: Text(
                name,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: size / 5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  gameName,
                  style: TextStyle(fontSize: size / 6, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
