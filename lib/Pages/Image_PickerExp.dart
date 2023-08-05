import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Image_PickerExp extends StatefulWidget {
  const Image_PickerExp({Key? key}) : super(key: key);

  @override
  State<Image_PickerExp> createState() => _Image_PickerExpState();
}

class _Image_PickerExpState extends State<Image_PickerExp> {
  var height;
  var weight;
  ImagePicker picker = ImagePicker();
  XFile? image;
  var size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 25,
                  );
                  final bytes = File(image!.path).readAsBytesSync();
                  final decodedImage = await decodeImageFromList(bytes);
                  height = decodedImage.height;
                  weight = decodedImage.width;
                  size = (await File(image!.path).lengthSync()) / 1024;
                  setState(() {});
                },
                child: Text("Pick Image")),
            Container(
              height: 40.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 25,
                  );

                  final bytes = File(image!.path).readAsBytesSync();
                  final decodedImage = await decodeImageFromList(bytes);
                  height = decodedImage.height;
                  weight = decodedImage.width;
                  setState(() {});

                  size = (await File(image!.path).lengthSync()) / 1024;
                },
                child: Text("PICK FROM CAMERA")),
            image == null
                ? Container()
                : Image.file(
                    File(
                      image!.path,
                    ),
                    height: 200,
                  ),
            Text("Image Path :- ${image?.path}"),
            Text("Image name :- ${image?.name}"),
            Text("Image runtime type :- ${image?.runtimeType}"),
            Text(height.toString()),
            Text(weight.toString()),
            Text(size.toString() + " KB"),
          ],
        ),
      ),
    );
  }
}
