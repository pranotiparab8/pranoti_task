import 'package:flutter/material.dart';

import 'SimulatorScreenShot.dart';

class GridViewEXP extends StatelessWidget {
  List list = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            // GridView.count(
            //   mainAxisSpacing: 50,
            //   crossAxisCount: 2,
            //   scrollDirection: Axis.vertical,
            //   crossAxisSpacing: 30,
            //   padding: EdgeInsets.all(4),
            //   children: [
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.all(5),
            //     ),
            //   ],
            // ),
            //
            GridView.builder(
          itemCount: list.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SimulatorScreenShot()));
              },
              child: Container(
                color: Colors.red,
                margin: EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  (list[index]),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
              ),
            );
          },
        ),
        //
        // body: GridView(
        //   gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        //   children: [
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //     Container(
        //       color: Colors.blue,
        //       margin: EdgeInsets.all(5),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
