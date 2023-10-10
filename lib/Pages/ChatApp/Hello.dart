import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:pranoti_task/Pages/ChatApp/thumbVideo.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'controller.dart';

class Chat_app9 extends StatefulWidget {
  const Chat_app9({Key? key}) : super(key: key);

  @override
  State<Chat_app9> createState() => _Chat_app9State();
}

class _Chat_app9State extends State<Chat_app9> {
  MyController myController = Get.put(MyController());
  final ScrollController _scrollController = ScrollController();

  // String? path1;
  // String? path2;

  DateTime now = DateTime.now();

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
                  itemCount: myController.jsondata1.value.length,
                  itemBuilder: (context, index) {
                    return myController.jsondata1.value[index]["messageType"] ==
                            "Text"
                        ? InkWell(
                            onTap: () {
                              // setState(() {
                              myController.messageController = myController
                                  .jsondata1.value[index]["message"]!;
                              myController.prevMsgType.value = "Text1";
                              // });
                            },
                            child: Align(
                              alignment: myController.jsondata1.value[index]
                                          ["sender"] ==
                                      "user1"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding:
                                    const EdgeInsets.all(4).copyWith(bottom: 8),
                                margin: myController.jsondata1.value[index]
                                            ["sender"] ==
                                        "user1"
                                    ? EdgeInsets.only(
                                        left: 100, right: 8, top: 8)
                                    : EdgeInsets.only(
                                        right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: myController.jsondata1
                                              .value[index]["sender"] ==
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
                                      if (myController.jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Text1" &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
                                              null &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
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
                                          child: Text(myController.jsondata1
                                              .value[index]["preMsg"]!),
                                        )
                                      else if (myController
                                                      .jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Video1" &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
                                              null &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
                                              '')
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            Get.to(VideoPage(
                                                videoUrl: myController.jsondata1
                                                    .value[index]["preMsg"]!));
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
                                                  myController.jsondata1
                                                      .value[index]["preMsg"]!),
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
                                      else if (myController
                                                      .jsondata1.value[index]
                                                  ["prevMsgType"] ==
                                              "Image1" &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
                                              null &&
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
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
                                                        if (myController.jsondata1
                                                                            .value[
                                                                        index][
                                                                    "preText"] !=
                                                                null &&
                                                            myController.jsondata1
                                                                            .value[
                                                                        index][
                                                                    "preText"] !=
                                                                '')
                                                          Text(myController
                                                                  .jsondata1
                                                                  .value[index]
                                                              ["preText"]),
                                                      ],
                                                    )
                                                  ]),
                                              Image.file(
                                                File(myController.jsondata1
                                                    .value[index]["preMsg"]!),
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        Container(width: 0),
                                      _buildCustomLinkPreview(
                                          context,
                                          myController.jsondata1.value[index]
                                              ["message"]!),
                                      if (myController.jsondata1.value[index]
                                                      ["message"] !=
                                                  null &&
                                              myController.jsondata1
                                                          .value[index]
                                                      ["message"] !=
                                                  '' &&
                                              myController.jsondata1
                                                      .value[index]["preMsg"] !=
                                                  null ||
                                          myController.jsondata1.value[index]
                                                  ["preMsg"] !=
                                              '')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                                child: Text(myController
                                                    .jsondata1
                                                    .value[index]["message"]!)),
                                            Transform.translate(
                                              offset: Offset(0, 6.0),
                                              child: Text(
                                                myController.jsondata1
                                                    .value[index]["date"]!,
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
                        : myController.jsondata1.value[index]["messageType"] ==
                                "Video"
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    myController.messageController =
                                        myController.jsondata1.value[index]
                                            ["message"]!;
                                    myController.prevMsgType.value = "Video1";
                                    myController.preTextMsgController =
                                        myController.jsondata1.value[index]
                                            ["text"]!;
                                  });
                                },
                                child: Align(
                                  alignment: myController.jsondata1.value[index]
                                              ["sender"] ==
                                          "user1"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: myController.jsondata1.value[index]
                                                ["sender"] ==
                                            "user1"
                                        ? EdgeInsets.only(
                                            left: 100, right: 8, top: 8)
                                        : EdgeInsets.only(
                                            right: 100, left: 8, top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: myController.jsondata1
                                                  .value[index]["sender"] ==
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
                                        if (myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                '' &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                null)
                                          Card(
                                            color: Colors.lightBlue,
                                            child: myController.jsondata1[index]
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
                                                              child: Text(myController
                                                                      .jsondata1
                                                                      .value[index]
                                                                  ["preMsg"]!),
                                                            ),
                                                          ],
                                                        )),
                                                  )
                                                : myController.jsondata1
                                                                .value[index]
                                                            ["prevMsgType"] ==
                                                        "Video1"
                                                    ? InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (context) =>
                                                          Get.to(VideoPage(
                                                              videoUrl: myController
                                                                      .jsondata1
                                                                      .value[index]
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
                                                                  myController
                                                                          .jsondata1
                                                                          .value[index]
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
                                                        File(myController
                                                                .jsondata1
                                                                .value[index]
                                                            ["preMsg"]!),
                                                        width: 80,
                                                        height: 80,
                                                      ),
                                          ),
                                        _buildCustomLinkPreview(
                                            context,
                                            myController.jsondata1.value[index]
                                                ["message"]!),
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
                                                          videoUrl: myController
                                                                  .jsondata1
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
                                                              myController
                                                                      .jsondata1
                                                                      .value[index]
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
                                                  Text(myController.jsondata1
                                                      .value[index]["text"]),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              myController.jsondata1
                                                  .value[index]["date"]!,
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
                                    myController.messageController =
                                        myController.jsondata1.value[index]
                                            ["message"]!;
                                    myController.prevMsgType.value = "Image1";
                                    myController.preTextMsgController =
                                        myController.jsondata1.value[index]
                                            ["text"]!;
                                  });
                                },
                                child: Align(
                                  alignment: myController.jsondata1.value[index]
                                              ["sender"] ==
                                          "user1"
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: myController.jsondata1.value[index]
                                                ["sender"] ==
                                            "user1"
                                        ? const EdgeInsets.only(
                                            left: 100, right: 8, top: 8)
                                        : const EdgeInsets.only(
                                            right: 100, left: 8, top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: myController.jsondata1
                                                  .value[index]["sender"] ==
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
                                        if (myController.jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Text1" &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                null &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
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
                                                      child: Text(myController
                                                              .jsondata1
                                                              .value[index]
                                                          ["preMsg"]!),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        else if (myController
                                                        .jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Video1" &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                null &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                '')
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              Get.to(VideoPage(
                                                  videoUrl: myController
                                                          .jsondata1
                                                          .value[index]
                                                      ["preMsg"]!));
                                              //   ),
                                              // );
                                            },
                                            child: Container(
                                                height: 200,
                                                child: FutureBuilder<String?>(
                                                  future: generateThumbnail(
                                                      myController.jsondata1
                                                              .value[index]
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
                                        else if (myController
                                                        .jsondata1.value[index]
                                                    ["prevMsgType"] ==
                                                "Image1" &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                null &&
                                            myController.jsondata1.value[index]
                                                    ["preMsg"] !=
                                                '')
                                          Image.file(
                                            File(myController.jsondata1
                                                .value[index]["preMsg"]!),
                                            width: 80,
                                            height: 80,
                                          )
                                        else
                                          Container(width: 0),
                                        _buildCustomLinkPreview(
                                            context,
                                            myController.jsondata1.value[index]
                                                ["message"]!),
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
                                                    File(myController.jsondata1
                                                            .value[index]
                                                        ["message"]!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Flexible(
                                                    child: Container(
                                                  width: 200,
                                                  child: Text(myController
                                                      .jsondata1
                                                      .value[index]["text"]),
                                                )),
                                              ],
                                            ),
                                            Text(
                                              myController.jsondata1
                                                  .value[index]["date"]!,
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
                if (myController.messageController == '*.jpg' ||
                    myController.messageController != '' &&
                        myController.prevMsgType.value == 'Image1')
                  Image.file(File(myController.messageController.toString()),
                      height: 100, width: 100)
                else if (myController.messageController == '*.mp4' ||
                    myController.messageController != '' &&
                        myController.prevMsgType.value == 'Video1')
                  Flexible(
                    child: Container(
                        height: 100,
                        width: 171,
                        child: Chewie(
                            controller: ChewieController(
                          videoPlayerController: VideoPlayerController.network(
                              myController.messageController.toString()),
                          autoInitialize: true,
                          looping: true,
                        ))),
                  )
                else if (myController.messageController != '' ||
                    myController.prevMsgType.value == 'Text1')
                  Text(myController.messageController.value)
                else
                  Text(''),
                myController.pickedVideo != null
                    ? Obx(() => (myController.isVideoPicked.value &&
                            myController.pickedVideo != null)
                        ? Flexible(
                            child: Container(
                                height: 100,
                                width: 171,
                                child: Chewie(
                                    controller: ChewieController(
                                  videoPlayerController:
                                      VideoPlayerController.network(myController
                                          .pickedVideo!.path
                                          .toString()),
                                  autoInitialize: true,
                                  looping:
                                      true, // Set to true if you want the video to loop
                                ))),
                          )
                        : Container())
                    : Obx(() => (myController.isImagePicked.value &&
                            myController.pickedFile != null)
                        ? Image.file(File(myController.pickedFile!.path))
                        : Flexible(
                            child: SingleChildScrollView(
                              child: _buildCustomLinkPreview(
                                  context, myController.textController1.text),
                            ),
                          )),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: myController.textController1,
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
                          if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Text1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Video1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Image1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Image1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Text1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Video1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Image1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Image1",
                                myController.textController1.text,
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '' &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Text1",
                                "",
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '' &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user1",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Video1",
                                "",
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '') {
                            myController.getTextFromUser(
                                "user1",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Image1",
                                "",
                                myController.preTextMsgController);
                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });

                        myController.messageController.value = '';
                        myController.pickedVideo = null;
                        myController.pickedFile = null;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.looks_two_outlined,
                          color: Colors.blueAccent),
                      onPressed: () {
                        setState(() {
                          if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Text1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Video1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedVideo != null &&
                              myController.prevMsgType.value == "Image1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedVideo!.path,
                                "Video",
                                myController.messageController,
                                "Image1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Text1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Video1",
                                myController.textController1.text,
                                "");
                          } else if (myController.pickedFile != null &&
                              myController.prevMsgType.value == "Image1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.pickedFile!.path,
                                "image",
                                myController.messageController,
                                "Image1",
                                myController.textController1.text,
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '' &&
                              myController.prevMsgType.value == "Text1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Text1",
                                "",
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '' &&
                              myController.prevMsgType.value == "Video1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Video1",
                                "",
                                "");
                          } else if (myController.textController1.text !=
                                  null &&
                              myController.textController1.text != '' &&
                              myController.prevMsgType.value == "Image1") {
                            myController.getTextFromUser(
                                "user2",
                                myController.textController1.text,
                                "Text",
                                myController.messageController,
                                "Image1",
                                "",
                                "");

                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        myController.messageController.value = '';
                        myController.pickedVideo = null;
                        myController.pickedFile = null;
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            myController.getFromCamera();
                            myController.textController1.clear();
                          });
                        },
                        icon:
                            const Icon(Icons.image, color: Colors.blueAccent)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            myController.getFromVideo();
                            myController.textController1.clear();
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
  // _getFromVideo() async {
  //   //isVideoPicked.value = true;
  //   pickedVideo = await ImagePicker().getVideo(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedVideo != null) {
  //     setState(() {
  //       // path2 = pickedVideo!.path;
  //       //print("Video path$path2");
  //     });
  //   }
  // }

  // _getTextFromUser(sender, msg, type, preMsg, preType, textMsg, preTextMsg) {
  //   //setState(() {
  //   Map<String, String> mydata = {
  //     "sender": sender,
  //     "message": msg,
  //     "messageType": type,
  //     "date": "${intl.DateFormat.jm().format(DateTime.now())}",
  //     "preMsg": preMsg,
  //     "prevMsgType": preType,
  //     "text": textMsg,
  //     "preText": preTextMsg,
  //   };
  //   myController.jsondata1.add(mydata);
  //   textController1.clear();
  //   // });
  // }

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
