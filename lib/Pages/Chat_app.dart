import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player_custom/flick_video_player_custom.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:video_player/video_player.dart';

class Chat_app4 extends StatefulWidget {
  const Chat_app4({Key? key}) : super(key: key);

  @override
  State<Chat_app4> createState() => _Chat_app4State();
}

class _Chat_app4State extends State<Chat_app4> {
  final ScrollController _scrollController = ScrollController();
  PickedFile? pickedFile;
  PickedFile? pickedVideo;
  String? path1;
  String? path2;

  var jsondata = [
    {"user1": "Hello "},
    {"user2": "how r u?"},
    {"user1": "Hi"},
    {"user2": "m fine."},
    {"user2": "Ok"}
  ];
  final List<Map<String, dynamic>> jsondata1 = [
    {
      "sender": "user1",
      "message":
          "Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello ",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message":
          "how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? ",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user1",
      "message": "Hi",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "https://youtu.be/RLzC55ai0eo?si=VFDXG330V1wejWaf",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user1",
      "message": "Hello",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "how r u?",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user1",
      "message": "Hi",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
    },
  ];
  TextEditingController textController1 = TextEditingController();
  TextEditingController messageController = TextEditingController();
  DateTime now = DateTime.now();
  bool a = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              controller: _scrollController,
              itemCount: jsondata1.length,
              itemBuilder: (context, index) {
                return jsondata1[index]["messageType"] == "Text"
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            a = true;
                            messageController.text =
                                jsondata1[index]["message"]!;
                          });
                        },
                        child: Align(
                          alignment: jsondata1[index]["sender"] == "user1"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: jsondata1[index]["sender"] == "user1"
                                ? EdgeInsets.only(left: 100, right: 8, top: 8)
                                : EdgeInsets.only(right: 100, left: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: jsondata1[index]["sender"] ==
                                      "user1"
                                  ? BorderRadius.circular(8)
                                      .copyWith(bottomRight: Radius.circular(0))
                                  : BorderRadius.circular(8)
                                      .copyWith(bottomLeft: Radius.circular(0)),
                              color: Colors.lightBlueAccent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // if (jsondata1[index]["date"]! ==
                                //     intl.DateFormat.jm().format(DateTime.now()))
                                if (jsondata1[index]["preMsg"] != '' &&
                                    jsondata1[index]["preMsg"] != null)
                                  Card(
                                      color: Colors.lightBlue,
                                      child: Text(jsondata1[index]["preMsg"]!)),
                                _buildCustomLinkPreview(
                                    context, jsondata1[index]["message"]!),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                        child:
                                            Text(jsondata1[index]["message"]!)),
                                    Text(
                                      jsondata1[index]["date"]!,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.right,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : jsondata1[index]["messageType"] == "Video"
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                a = true;
                                messageController.text =
                                    jsondata1[index]["message"]!;
                              });
                            },
                            child: Align(
                              alignment: jsondata1[index]["sender"] == "user1"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: jsondata1[index]["sender"] == "user1"
                                    ? EdgeInsets.only(
                                        left: 100, right: 8, top: 8)
                                    : EdgeInsets.only(
                                        right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: jsondata1[index]["sender"] ==
                                          "user1"
                                      ? BorderRadius.circular(8).copyWith(
                                          bottomRight: const Radius.circular(0))
                                      : BorderRadius.circular(8).copyWith(
                                          bottomLeft: const Radius.circular(0)),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Column(
                                  children: [
                                    if (jsondata1[index]["preMsg"] != '' &&
                                        jsondata1[index]["preMsg"] != null)
                                      Card(
                                          color: Colors.lightBlue,
                                          child: Text(
                                              jsondata1[index]["preMsg"]!)),
                                    _buildCustomLinkPreview(
                                        context, jsondata1[index]["message"]!),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 150,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  jsondata1[index]["message"]!,
                                                ),
                                              ),
                                            ),
                                            child: AspectRatio(
                                              aspectRatio: 3 / 4,
                                              child: FlickVideoPlayer(
                                                flickManager: FlickManager(
                                                  videoPlayerController:
                                                      VideoPlayerController
                                                          .network(
                                                              jsondata1[index]
                                                                  ["message"]!),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          jsondata1[index]["date"]!,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    Text(path2!),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                a = true;
                                messageController.text =
                                    jsondata1[index]["message"]!;
                              });
                            },
                            child: Align(
                              alignment: jsondata1[index]["sender"] == "user1"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: jsondata1[index]["sender"] == "user1"
                                    ? const EdgeInsets.only(
                                        left: 100, right: 8, top: 8)
                                    : const EdgeInsets.only(
                                        right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: jsondata1[index]["sender"] ==
                                          "user1"
                                      ? BorderRadius.circular(8).copyWith(
                                          bottomRight: const Radius.circular(0))
                                      : BorderRadius.circular(8).copyWith(
                                          bottomLeft: const Radius.circular(0)),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Column(
                                  children: [
                                    if (jsondata1[index]["preMsg"] != '' &&
                                        jsondata1[index]["preMsg"] != null)
                                      Card(
                                          color: Colors.lightBlue,
                                          child: Text(
                                              jsondata1[index]["preMsg"]!)),
                                    _buildCustomLinkPreview(
                                        context, jsondata1[index]["message"]!),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  jsondata1[index]["message"]!,
                                                ),
                                              ),
                                            ),
                                            child: Image.file(
                                              File(
                                                  jsondata1[index]["message"]!),
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          jsondata1[index]["date"]!,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    //Text(path1!),
                                  ],
                                ),
                              ),
                            ),
                          );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (a == true || messageController.text != '')
                  Text(messageController.text),
                pickedVideo != null
                    ? Container(
                        height: 100,
                        width: 171,
                        child: FlickVideoPlayer(
                            flickManager: FlickManager(
                          videoPlayerController:
                              VideoPlayerController.network(pickedVideo!.path),
                        )),
                      )
                    : pickedFile != null
                        ? Image.file(File(pickedFile!.path))
                        // : (a == true || messageController.text != '')
                        //     ? Text(messageController.text)
                        : Flexible(
                            child: SingleChildScrollView(
                              child: _buildCustomLinkPreview(
                                  context, textController1.text),
                            ),
                          ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: textController1,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.blueAccent),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.looks_one_outlined,
                          color: Colors.blueAccent),
                      onPressed: () {
                        setState(() {
                          if (pickedVideo != null) {
                            _getTextFromUser("user1", pickedVideo!.path,
                                "Video", messageController.text);
                          } else if (pickedFile != null) {
                            _getTextFromUser("user1", pickedFile!.path, "image",
                                messageController.text);
                          } else {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController.text);

                            FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        messageController.text = '';
                        pickedVideo = null;
                        pickedFile = null;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.looks_two_outlined,
                          color: Colors.blueAccent),
                      onPressed: () {
                        setState(() {
                          if (pickedVideo != null) {
                            _getTextFromUser("user2", pickedVideo!.path,
                                "Video", messageController.text);
                          } else if (pickedFile != null) {
                            _getTextFromUser("user2", pickedFile!.path, "image",
                                messageController.text);
                          } else {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController.text);
                            FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        messageController.text = '';
                        pickedVideo = null;
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
                        icon:
                            const Icon(Icons.image, color: Colors.blueAccent)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _getFromVideo();
                            print("path${pickedVideo!.path}");
                            textController1.clear();
                          });
                        },
                        icon: const Icon(Icons.video_call,
                            color: Colors.blueAccent)),
                  ],
                ),
              ],
            ),
          )
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
      setState(() {
        path1 = pickedFile!.path;
      });
    }
  }

  _getFromVideo() async {
    pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {
      setState(() {
        path2 = pickedVideo!.path;
      });
    }
  }

  _getTextFromUser(sender, msg, type, preMsg) {
    setState(() {
      jsondata1.add({
        "sender": sender,
        "message": msg,
        "messageType": type,
        "date": intl.DateFormat.jm().format(DateTime.now()),
        "preMsg": preMsg,
      });
      textController1.clear();
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget _buildCustomLinkPreview(BuildContext context, String url) {
    return FlutterLinkPreview(
      key: ValueKey("${url}211"),
      url: url,
      builder: (info) {
        if (info == null) return const SizedBox.shrink();
        if (info is WebImageInfo) {
          return CachedNetworkImage(
            imageUrl: info.image,
            fit: BoxFit.contain,
          );
        }

        final WebInfo webInfo = info as WebInfo;
        if (!WebAnalyzer.isNotEmpty(str: webInfo.title)) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF0F1F2),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: webInfo.icon ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.contain,
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.link);
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  webInfo.title != null
                      ? Expanded(
                          child: Text(
                            webInfo.title!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              if (webInfo.description != null &&
                  WebAnalyzer.isNotEmpty(str: webInfo.description)) ...[
                const SizedBox(height: 8),
                Text(
                  webInfo.description!,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (webInfo.image != null &&
                  WebAnalyzer.isNotEmpty(str: webInfo.image)) ...[
                const SizedBox(height: 8),
                CachedNetworkImage(
                  imageUrl: webInfo.image!,
                  fit: BoxFit.contain,
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
