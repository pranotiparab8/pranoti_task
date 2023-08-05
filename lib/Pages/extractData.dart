import 'dart:async';

import 'package:flutter/material.dart';

class ExtractData extends StatelessWidget {
  const ExtractData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = new Image.asset("images/cat.jpg");
    Completer completer = new Completer();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
      var width = info.image.width.toDouble();
      var height = info.image.height.toDouble();
      print("width and height $width and $height");
    }));
    return Scaffold();
  }
}
