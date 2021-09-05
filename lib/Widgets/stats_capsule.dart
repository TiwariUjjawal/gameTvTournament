import 'package:flutter/material.dart';

class StatsCapsule extends StatelessWidget {
  const StatsCapsule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double size = MediaQuery.of(context).size.height * 0.1;
    return Container(
      width: sizeWidth,
      height: size + 8,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: statsContent("34", "Tournaments", "played", size),
                ),
              ),
            ),
            SizedBox(
              width: 1,
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: statsContent("09", "Tournaments", "won", size),
                ),
              ),
            ),
            SizedBox(
              width: 1,
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: statsContent("26%", "Winning", "percentage", size),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsContent(
      String numLabel, String label1, String label2, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            numLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: size / 4,
            ),
          ),
        ),
        Center(
          child: Text(
            label1,
            style: TextStyle(
              color: Colors.white,
              fontSize: size / 6,
            ),
          ),
        ),
        Center(
          child: Text(
            label2,
            style: TextStyle(
              color: Colors.white,
              fontSize: size / 6,
            ),
          ),
        ),
      ],
    );
  }
}
