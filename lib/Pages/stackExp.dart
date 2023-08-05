import 'package:flutter/material.dart';

class stackExp extends StatelessWidget {
  const stackExp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack Example"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.green,
            height: 300,
            width: 300,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                NewContainer(colour: Colors.yellow, h: 100, w: 100),
              ],
            ),
          ),
          NewContainer(colour: Colors.red, h: 200, w: 200),
          // NewContainer(colour: Colors.green, h: 300, w: 300),
        ],
      ),
    );
  }
}

class NewContainer extends StatelessWidget {
  Color colour;
  double h;
  double w;

  NewContainer({required this.colour, required this.h, required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colour,
      height: h,
      width: w,
    );
  }
}
