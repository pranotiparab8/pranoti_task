import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Chat_app extends StatefulWidget {
  const Chat_app({Key? key}) : super(key: key);

  @override
  State<Chat_app> createState() => _Chat_appState();
}

class _Chat_appState extends State<Chat_app> {
  PickedFile? pickedFile;
  PickedFile? pickedVideo;
  VideoPlayerController? _controller;
  File? _videoFile;

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller?.dispose();
  // }

  // var pickedFile2 = "";
  var jsondata = [
    {"user1": "Hello"},
    {"user2": "how r u?"},
    {"user1": "Hi"},
    {"user2": "m fine."},
    {"user2": "Ok"}
  ];
  final List<Map<String, dynamic>> jsondata1 = [
    // {"sender": "user1", "message": "Hello", "messageType": "Text"},
    // {"sender": "user2", "message": "how r u?", "messageType": "Text"},
    // {"sender": "user1", "message": "Hi", "messageType": "Text"},
    // {"sender": "user2", "message": "m fine.", "messageType": "Text"},
    // {"sender": "user2", "message": "Ok", "messageType": "Text"},
  ];
  TextEditingController textController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(Icons.arrow_back),
          SizedBox(width: 5),
          CircleAvatar(backgroundImage: AssetImage('images/cat.jpg')),
          SizedBox(width: 5),
          Text("User1"),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: jsondata1.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: jsondata1[index]["sender"] == "user1"
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: jsondata1[index]["messageType"] == "Text"
                      ? ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(jsondata1[index]["message"]!),
                              Text(jsondata1[index]["date"]!,
                                  style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        )
                      : ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.file(File(jsondata1[index]["message"]!),
                                  width: 100, height: 100),
                              Text(jsondata1[index]["date"]!,
                                  style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: pickedFile == null ? 65 : 151,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Column(
                      children: [
                        pickedFile != null //pickedVideo != null
                            ?
                            // Center(
                            //         child: _controller != null &&
                            //                 _controller!.value.isInitialized
                            //             ? Container(
                            //                 width:
                            //                     100.0, // Set the width as per your requirement
                            //                 height:
                            //                     100.0, // Set the height as per your requirement
                            //                 child: AspectRatio(
                            //                   aspectRatio:
                            //                       _controller!.value.aspectRatio,
                            //                   child: VideoPlayer(_controller!),
                            //                 ),
                            //               )
                            //             : Text('Select a video to play'),
                            //       )
                            Image.file(File(pickedFile!.path))
                            : Text(""),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                controller: textController1,
                                decoration: const InputDecoration(
                                    hintStyle:
                                        TextStyle(color: Colors.blueAccent),
                                    border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.looks_one_outlined,
                                  color: Colors.blueAccent),
                              onPressed: () {
                                setState(() {
                                  if (pickedFile != null) {
                                    _getTextFromUser(
                                        "user1", pickedFile!.path, "image");
                                  } else if (textController1.text != null) {
                                    _getTextFromUser(
                                        "user1", textController1.text, "Text");
                                  } else {
                                    _getTextFromUser(
                                        "user1", pickedVideo!.path, "Video");
                                  }
                                });
                                pickedFile = null;
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.looks_two_outlined,
                                  color: Colors.blueAccent),
                              onPressed: () {
                                print(textController1.toString());
                                setState(() {
                                  if (pickedFile != null) {
                                    _getTextFromUser(
                                        "user2", pickedFile!.path, "image");
                                  } else if (textController1.text != null) {
                                    _getTextFromUser(
                                        "user2", textController1.text, "Text");
                                  } else {
                                    _getTextFromUser(
                                        "user2", pickedVideo!.path, "Video");
                                  }
                                });
                                pickedFile = null;
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _getFromCamera();
                                    textController1.clear();
                                  });
                                },
                                icon: const Icon(Icons.image,
                                    color: Colors.blueAccent)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _getFromVideo();
                                    textController1.clear();
                                  });
                                },
                                icon: const Icon(Icons.video_call,
                                    color: Colors.blueAccent)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    if (pickedFile != null) {
      setState(() {});
    }
  }

  _getFromVideo() async {
    pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {
      setState(() {
        _videoFile = File(pickedFile!.path);
        print("path$_videoFile");
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  _getTextFromUser(sender, msg, type) {
    setState(() {
      jsondata1.add({
        "sender": sender,
        "message": msg,
        "messageType": type,
        "date": "12:12:12",
      });
      textController1.clear();
    });
  }
}
