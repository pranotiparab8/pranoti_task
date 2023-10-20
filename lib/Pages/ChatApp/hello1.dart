import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:pranoti_task/Pages/ChatApp/thumbVideo.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'GetxApp/controller.dart';

class Chat_app8 extends StatefulWidget {
  const Chat_app8({Key? key}) : super(key: key);

  @override
  State<Chat_app8> createState() => _Chat_app8State();
}

class _Chat_app8State extends State<Chat_app8> {
  MyController myController = Get.put(MyController());
  final ScrollController _scrollController = ScrollController();
  PickedFile? pickedFile;
  PickedFile? pickedVideo;
  String? path1;
  String? path2;

  final RxList<Map<String, dynamic>> jsondata1 = [
    {
      "sender": "user1",
      "message":
          "Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello ",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message":
          "how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? how r u? ",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user1",
      "message": "Hi",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "https://youtu.be/RLzC55ai0eo?si=VFDXG330V1wejWaf",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user1",
      "message": "Hello",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "how r u?",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user1",
      "message": "Hi",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "m fine.",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
    {
      "sender": "user2",
      "message": "Ok",
      "messageType": "Text",
      "date": "12:12PM",
      "preMsg": "",
      "preMsgType": "",
      "text": "",
    },
  ].obs;
  TextEditingController textController1 = TextEditingController();
  String messageController = "";
  String prevMsgType = "Text1";
  DateTime now = DateTime.now();
  String preTextMsgController = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Chewie buildChewie(int index, var videourl) {
    return Chewie(
        controller: ChewieController(
      videoPlayerController: VideoPlayerController.network(videourl),
      autoInitialize: true,
      looping: true,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("preTextMsgController$preTextMsgController");
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
            child: Obx(() => ListView.builder(
                  controller: _scrollController,
                  itemCount: jsondata1.value.length,
                  itemBuilder: (context, index) {
                    print(
                        "preTextMsgController${jsondata1.value[index]["preText"]}");
                    return jsondata1.value[index]["messageType"] == "Text"
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                messageController =
                                    jsondata1.value[index]["message"]!;
                                prevMsgType = "Text1";
                              });
                            },
                            child: Align(
                              alignment:
                                  jsondata1.value[index]["sender"] == "user1"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Container(
                                padding:
                                    const EdgeInsets.all(4).copyWith(bottom: 8),
                                margin:
                                    jsondata1.value[index]["sender"] == "user1"
                                        ? EdgeInsets.only(
                                            left: 100, right: 8, top: 8)
                                        : EdgeInsets.only(
                                            right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: jsondata1.value[index]
                                              ["sender"] ==
                                          "user1"
                                      ? BorderRadius.circular(8).copyWith(
                                          bottomRight: Radius.circular(0))
                                      : BorderRadius.circular(8).copyWith(
                                          bottomLeft: Radius.circular(0)),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Text1" &&
                                          jsondata1.value[index]["preMsg"] !=
                                              null &&
                                          jsondata1.value[index]["preMsg"] !=
                                              '')
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border(
                                                left: BorderSide(
                                              color: Colors.yellow,
                                              width: 4.0,
                                            )),
                                          ),
                                          child: Text(jsondata1.value[index]
                                              ["preMsg"]!),
                                        )
                                      else if (jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Video1" &&
                                          jsondata1.value[index]["preMsg"] !=
                                              null &&
                                          jsondata1.value[index]["preMsg"] !=
                                              '')
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            Get.to(VideoPage(
                                                videoUrl: jsondata1.value[index]
                                                    ["preMsg"]!));
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            height: 200,
                                            child:
                                                // buildChewie(
                                                //     index, jsondata1[index]["preMsg"]!),
                                                FutureBuilder<String?>(
                                              future: generateThumbnail(
                                                  jsondata1.value[index]
                                                      ["preMsg"]!),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    return Stack(
                                                      children: [
                                                        Image.file(File(
                                                            snapshot.data!)),
                                                        Center(
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.black54,
                                                            radius: 30,
                                                            child: Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_right,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Text(
                                                        'Thumbnail not available');
                                                  }
                                                } else {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      else if (jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Image1" &&
                                          jsondata1.value[index]["preMsg"] !=
                                              null &&
                                          jsondata1.value[index]["preMsg"] !=
                                              '')
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border(
                                                left: BorderSide(
                                              color: Colors.yellow,
                                              width: 4.0,
                                            )),
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("You"),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.photo),
                                                        if (jsondata1.value[
                                                                        index][
                                                                    "preText"] !=
                                                                null &&
                                                            jsondata1.value[
                                                                        index][
                                                                    "preText"] !=
                                                                '')
                                                          Text(jsondata1
                                                                  .value[index]
                                                              ["preText"]),
                                                      ],
                                                    )
                                                  ]),
                                              Image.file(
                                                File(jsondata1.value[index]
                                                    ["preMsg"]!),
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        Container(width: 0),
                                      _buildCustomLinkPreview(context,
                                          jsondata1.value[index]["message"]!),
                                      if (jsondata1.value[index]
                                                      ["message"] !=
                                                  null &&
                                              jsondata1.value[index]
                                                      ["message"] !=
                                                  '' &&
                                              jsondata1.value[index]
                                                      ["preMsg"] !=
                                                  null ||
                                          jsondata1.value[index]["preMsg"] !=
                                              '')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                                child: Text(jsondata1
                                                    .value[index]["message"]!)),
                                            Transform.translate(
                                              offset: Offset(0, 6.0),
                                              child: Text(
                                                jsondata1.value[index]["date"]!,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                textAlign: TextAlign.right,
                                              ),
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : jsondata1.value[index]["messageType"] == "Video"
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    messageController =
                                        jsondata1.value[index]["message"]!;
                                    prevMsgType = "Video1";
                                    preTextMsgController =
                                        jsondata1.value[index]["text"]!;
                                  });
                                },
                                child: Align(
                                  alignment: jsondata1.value[index]["sender"] ==
                                          "user1"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: jsondata1.value[index]["sender"] ==
                                            "user1"
                                        ? EdgeInsets.only(
                                            left: 100, right: 8, top: 8)
                                        : EdgeInsets.only(
                                            right: 100, left: 8, top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: jsondata1.value[index]
                                                  ["sender"] ==
                                              "user1"
                                          ? BorderRadius.circular(8).copyWith(
                                              bottomRight:
                                                  const Radius.circular(0))
                                          : BorderRadius.circular(8).copyWith(
                                              bottomLeft:
                                                  const Radius.circular(0)),
                                      color: Colors.lightBlueAccent,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (jsondata1.value[index]["preMsg"] !=
                                                '' &&
                                            jsondata1.value[index]["preMsg"] !=
                                                null)
                                          Card(
                                            color: Colors.lightBlue,
                                            child: jsondata1[index]
                                                        ["prevMsgType"] ==
                                                    "Text1"
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          border: Border(
                                                              left: BorderSide(
                                                            color:
                                                                Colors.yellow,
                                                            width: 4.0,
                                                          )),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(
                                                                width: 9.0),
                                                            Flexible(
                                                              child: Text(jsondata1
                                                                          .value[
                                                                      index]
                                                                  ["preMsg"]!),
                                                            ),
                                                          ],
                                                        )),
                                                  )
                                                : jsondata1.value[index]
                                                            ["prevMsgType"] ==
                                                        "Video1"
                                                    ? InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) =>
                                                          Get.to(VideoPage(
                                                              videoUrl: jsondata1
                                                                          .value[
                                                                      index]
                                                                  ["preMsg"]!));
                                                          //   ),
                                                          // );
                                                        },
                                                        child: Container(
                                                            height: 200,
                                                            child:
                                                                FutureBuilder<
                                                                    String?>(
                                                              future: generateThumbnail(
                                                                  jsondata1.value[
                                                                          index]
                                                                      [
                                                                      "preMsg"]!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .done) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    return Stack(
                                                                      children: [
                                                                        Image.file(
                                                                            File(snapshot.data!)),
                                                                        CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.black54,
                                                                            radius: 30),
                                                                        Center(
                                                                          child: Icon(
                                                                              Icons.arrow_right,
                                                                              size: 50,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                        'Thumbnail not available');
                                                                  }
                                                                } else {
                                                                  return Center(
                                                                      child:
                                                                          CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
                                                                }
                                                              },
                                                            )),
                                                      )
                                                    : Image.file(
                                                        File(jsondata1
                                                                .value[index]
                                                            ["preMsg"]!),
                                                        width: 80,
                                                        height: 80,
                                                      ),
                                          ),
                                        _buildCustomLinkPreview(context,
                                            jsondata1.value[index]["message"]!),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      Get.to(VideoPage(
                                                          videoUrl: jsondata1
                                                                  .value[index]
                                                              ["message"]!));
                                                      //   ),
                                                      // );
                                                    },
                                                    child: Container(
                                                        height: 200,
                                                        child:
                                                            // buildChewie(
                                                            //     index,
                                                            //     jsondata1[index]
                                                            //         ["message"]!),
                                                            FutureBuilder<
                                                                String?>(
                                                          future: generateThumbnail(
                                                              jsondata1.value[
                                                                      index]
                                                                  ["message"]!),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return Stack(
                                                                  children: [
                                                                    Image.file(File(
                                                                        snapshot
                                                                            .data!)),
                                                                    Center(
                                                                      child: CircleAvatar(
                                                                          backgroundColor: Colors
                                                                              .black54,
                                                                          radius:
                                                                              30),
                                                                    ),
                                                                    Center(
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_right,
                                                                          size:
                                                                              50,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                return Text(
                                                                    'Thumbnail not available');
                                                              }
                                                            } else {
                                                              return Center(
                                                                  child:
                                                                      CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
                                                            }
                                                          },
                                                        )),
                                                  ),
                                                  Text(jsondata1.value[index]
                                                      ["text"]),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              jsondata1.value[index]["date"]!,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    messageController =
                                        jsondata1.value[index]["message"]!;
                                    prevMsgType = "Image1";
                                    preTextMsgController =
                                        jsondata1.value[index]["text"]!;

                                    print(preTextMsgController);
                                  });
                                },
                                child: Align(
                                  alignment: jsondata1.value[index]["sender"] ==
                                          "user1"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: jsondata1.value[index]["sender"] ==
                                            "user1"
                                        ? const EdgeInsets.only(
                                            left: 100, right: 8, top: 8)
                                        : const EdgeInsets.only(
                                            right: 100, left: 8, top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: jsondata1.value[index]
                                                  ["sender"] ==
                                              "user1"
                                          ? BorderRadius.circular(8).copyWith(
                                              bottomRight:
                                                  const Radius.circular(0))
                                          : BorderRadius.circular(8).copyWith(
                                              bottomLeft:
                                                  const Radius.circular(0)),
                                      color: Colors.lightBlueAccent,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Text1" &&
                                            jsondata1.value[index]["preMsg"] !=
                                                null &&
                                            jsondata1.value[index]["preMsg"] !=
                                                '')
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                            child: Container(
                                                //width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  border: Border(
                                                      left: BorderSide(
                                                    color: Colors.yellow,
                                                    width: 4.0,
                                                  )),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 9.0),
                                                    Flexible(
                                                      child: Text(
                                                          jsondata1.value[index]
                                                              ["preMsg"]!),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        else if (jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Video1" &&
                                            jsondata1.value[index]["preMsg"] !=
                                                null &&
                                            jsondata1.value[index]["preMsg"] !=
                                                '')
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              Get.to(VideoPage(
                                                  videoUrl:
                                                      jsondata1.value[index]
                                                          ["preMsg"]!));
                                              //   ),
                                              // );
                                            },
                                            child: Container(
                                                height: 200,
                                                child: FutureBuilder<String?>(
                                                  future: generateThumbnail(
                                                      jsondata1.value[index]
                                                          ["preMsg"]!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      if (snapshot.hasData) {
                                                        return Stack(
                                                          children: [
                                                            Image.file(File(
                                                                snapshot
                                                                    .data!)),
                                                            CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black54,
                                                                radius: 30),
                                                            Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_right,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return Text(
                                                            'Thumbnail not available');
                                                      }
                                                    } else {
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
                                                    }
                                                  },
                                                )),
                                          )
                                        else if (jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Image1" &&
                                            jsondata1.value[index]["preMsg"] !=
                                                null &&
                                            jsondata1.value[index]["preMsg"] !=
                                                '')
                                          Image.file(
                                            File(jsondata1.value[index]
                                                ["preMsg"]!),
                                            width: 80,
                                            height: 80,
                                          )
                                        else
                                          Container(width: 0),
                                        _buildCustomLinkPreview(context,
                                            jsondata1.value[index]["message"]!),
                                        const SizedBox(height: 2),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          //mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 300,
                                                  child: Image.file(
                                                    File(jsondata1.value[index]
                                                        ["message"]!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Flexible(
                                                    child: Container(
                                                  width: 200,
                                                  child: Text(jsondata1
                                                      .value[index]["text"]),
                                                )),
                                              ],
                                            ),
                                            Text(
                                              jsondata1.value[index]["date"]!,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                  },
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (messageController == '*.jpg' ||
                    messageController != '' && prevMsgType == 'Image1')
                  Image.file(File(messageController.toString()),
                      height: 100, width: 100)
                else if (messageController == '*.mp4' ||
                    messageController != '' && prevMsgType == 'Video1')
                  Flexible(
                    child: Container(
                        height: 100,
                        width: 171,
                        child:
                            // FlickVideoPlayer(
                            //   flickManager: FlickManager(
                            //     videoPlayerController: VideoPlayerController.network(
                            //         messageController.toString()),
                            //   ),
                            // ),
                            Chewie(
                                controller: ChewieController(
                          videoPlayerController: VideoPlayerController.network(
                              messageController.toString()),
                          autoInitialize: true,
                          looping:
                              true, // Set to true if you want the video to loop
                        ))),
                  )
                else if (messageController != '' || prevMsgType == 'Text1')
                  Text(messageController)
                else
                  Text(''),
                pickedVideo != null
                    ? Flexible(
                        child: Container(
                            height: 100,
                            width: 171,
                            child:
                                // FlickVideoPlayer(
                                //   flickManager: FlickManager(
                                //     videoPlayerController:
                                //         VideoPlayerController.network(
                                //             pickedVideo!.path.toString()),
                                //   ),
                                // ),
                                Chewie(
                                    controller: ChewieController(
                              videoPlayerController:
                                  VideoPlayerController.network(
                                      pickedVideo!.path.toString()),
                              autoInitialize: true,
                              looping:
                                  true, // Set to true if you want the video to loop
                            ))),
                      )
                    : Obx(
                        () => (myController.isImagePicked.value &&
                                myController.pickedFile != null)
                            ? Image.file(File(myController.pickedFile!.path))
                            : Flexible(
                                child: SingleChildScrollView(
                                  child: _buildCustomLinkPreview(
                                      context, textController1.text),
                                ),
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
                        print(
                            "Button1preTextMsgController$preTextMsgController");
                        setState(() {
                          if (pickedVideo != null && prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Text1",
                                textController1.text,
                                "");
                          } else if (pickedVideo != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Video1",
                                textController1.text,
                                "");
                          } else if (pickedVideo != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Image1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Text1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Video1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Image1",
                                textController1.text,
                                "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Text1") {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController, "Text1", "", "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Video1") {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController, "Video1", "", "");
                          } else if (textController1.text != null &&
                              textController1.text != '') {
                            _getTextFromUser(
                                "user1",
                                textController1.text,
                                "Text",
                                messageController,
                                "Image1",
                                "",
                                preTextMsgController);
                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        print("preTextMsgController$preTextMsgController");
                        messageController = '';
                        pickedVideo = null;
                        myController.pickedFile = null;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.looks_two_outlined,
                          color: Colors.blueAccent),
                      onPressed: () {
                        setState(() {
                          if (pickedVideo != null && prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user2",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Text1",
                                textController1.text,
                                "");
                          } else if (pickedVideo != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user2",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Video1",
                                textController1.text,
                                "");
                          } else if (pickedVideo != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user2",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Image1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Text1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Video1",
                                textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                messageController,
                                "Image1",
                                textController1.text,
                                "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Text1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Text1", "", "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Video1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Video1", "", "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Image1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Image1", "", "");

                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        messageController = '';
                        pickedVideo = null;
                        myController.pickedFile = null;
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            myController.getFromCamera();
                            textController1.clear();
                          });
                        },
                        icon:
                            const Icon(Icons.image, color: Colors.blueAccent)),
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
        ],
      ),
    );
  }

  // _getFromCamera() async {
  //   //isImagePicked.value = true;
  //   pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 100,
  //     maxHeight: 100,
  //   );
  //   if (pickedFile != null) {
  //     // isImagePicked.value = true;
  //     //  setState(() {});
  //   }
  // }

  // path1 = pickedFile!.path;
  // print(pickedFile!.path);
  _getFromVideo() async {
    //isVideoPicked.value = true;
    pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {
      setState(() {
        path2 = pickedVideo!.path;
        //print("Video path$path2");
      });
    }
  }

  _getTextFromUser(sender, msg, type, preMsg, preType, textMsg, preTextMsg) {
    //setState(() {
    Map<String, String> mydata = {
      "sender": sender,
      "message": msg,
      "messageType": type,
      "date": "${intl.DateFormat.jm().format(DateTime.now())}",
      "preMsg": preMsg,
      "prevMsgType": preType,
      "text": textMsg,
      "preText": preTextMsg,
    };
    jsondata1.add(mydata);
    textController1.clear();
    // });
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

  Future<String?> generateThumbnail(String videoPath) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );

    return thumbnailPath;
  }
}
