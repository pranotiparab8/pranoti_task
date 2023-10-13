import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:pranoti_task/Pages/ChatApp/thumbVideo.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';

class Chat_appGetx extends StatefulWidget {
  const Chat_appGetx({Key? key}) : super(key: key);

  @override
  State<Chat_appGetx> createState() => _Chat_appGetxState();
}

class _Chat_appGetxState extends State<Chat_appGetx> {
  MyController myController = Get.put(MyController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      myController.scrollToBottom();
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
    myController.scrollController.dispose();
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
                  controller: myController.scrollController,
                  itemCount: myController.jsondata1.value.length,
                  itemBuilder: (context, index) {
                    if (myController.jsondata1[index]["messageType"] ==
                        "Text") {
                      return InkWell(
                        onTap: () {
                          myController.messageController.value =
                              myController.jsondata1.value[index]["message"]!;
                          myController.prevMsgType.value = "Text1";
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
                                ? EdgeInsets.only(left: 100, right: 8, top: 8)
                                : EdgeInsets.only(right: 100, left: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: myController.jsondata1.value[index]
                                          ["sender"] ==
                                      "user1"
                                  ? BorderRadius.circular(8)
                                      .copyWith(bottomRight: Radius.circular(0))
                                  : BorderRadius.circular(8)
                                      .copyWith(bottomLeft: Radius.circular(0)),
                              color: Colors.lightBlueAccent,
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  preMsgView(index),
                                  buildText(index),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (myController.jsondata1.value[index]
                            ["messageType"] ==
                        "Video") {
                      return InkWell(
                        onTap: () {
                          myController.messageController.value =
                              myController.jsondata1.value[index]["message"]!;
                          myController.prevMsgType.value = "Video1";
                          myController.preTextMsgController.value =
                              myController.jsondata1.value[index]["text"]!;
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
                                ? EdgeInsets.only(left: 100, right: 8, top: 8)
                                : EdgeInsets.only(right: 100, left: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: myController.jsondata1.value[index]
                                          ["sender"] ==
                                      "user1"
                                  ? BorderRadius.circular(8).copyWith(
                                      bottomRight: const Radius.circular(0))
                                  : BorderRadius.circular(8).copyWith(
                                      bottomLeft: const Radius.circular(0)),
                              color: Colors.lightBlueAccent,
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  preMsgView(index),
                                  buildVideo(index),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          myController.messageController.value =
                              myController.jsondata1.value[index]["message"]!;
                          myController.prevMsgType.value = "Image1";
                          myController.preTextMsgController.value =
                              myController.jsondata1.value[index]["text"]!;
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
                              borderRadius: myController.jsondata1.value[index]
                                          ["sender"] ==
                                      "user1"
                                  ? BorderRadius.circular(8).copyWith(
                                      bottomRight: const Radius.circular(0))
                                  : BorderRadius.circular(8).copyWith(
                                      bottomLeft: const Radius.circular(0)),
                              color: Colors.lightBlueAccent,
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  preMsgView(index),
                                  buildImage(index)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
                Obx(() => (myController.messageController.value == '*.jpg' ||
                        myController.messageController.value != '' &&
                            myController.prevMsgType.value == 'Image1')
                    ? Image.file(File(myController.messageController.value),
                        height: 100, width: 100)
                    : Container()),

                Obx(() => (myController.messageController.value == '*.mp4' ||
                        myController.messageController.value != '' &&
                            myController.prevMsgType.value == 'Video1')
                    ? Flexible(
                        child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width / 2, //171,
                            child: Chewie(
                                controller: ChewieController(
                              videoPlayerController:
                                  VideoPlayerController.network(myController
                                      .messageController.value
                                      .toString()),
                              autoInitialize: false,
                              looping:
                                  true, // Set to true if you want the video to loop
                            ))),
                      )
                    : Container()),
                if (myController.prevMsgType.value == 'Text1' &&
                    myController.messageController.value != '*.jpg' &&
                    myController.messageController.value != '*.mp4')
                  Obx(() => (myController.messageController.value != '' ||
                          myController.prevMsgType.value == 'Text1')
                      ? Text(myController.messageController.value.toString())
                      : Container()),

                //pickedVideo != null

                //myController.pickedVideo.toString() != null
                //myController.pickedVideo.isBlank != false
                // ? Flexible(
                //     child: Container(
                //         height: 100,
                //         width: 171,
                //         child: Chewie(
                //             controller: ChewieController(
                //           videoPlayerController:
                //               VideoPlayerController.network(
                //                   pickedVideo!.path.toString()),
                //           autoInitialize: true,
                //           looping:
                //               true, // Set to true if you want the video to loop
                //         ))),
                //   )
                Obx(() => (myController.isVideoPicked.value &&
                        myController.pickedVideo != null)
                    ? Flexible(
                        child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width / 2, //171,
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
                    : Container()),
                Obx(() => (myController.isImagePicked.value &&
                        myController.pickedFile != null)
                    ? Image.file(File(myController.pickedFile!.path.toString()))
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
                        if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedVideo!.path,
                              "Video",
                              myController.messageController.value,
                              "Text1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedVideo!.path.toString(),
                              "Video",
                              myController.messageController.value,
                              "Video1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Image1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedVideo!.path.toString(),
                              "Video",
                              myController.messageController.value,
                              "Image1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Text1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Video1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Image1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Image1",
                              myController.textController1.text,
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '' &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value,
                              "Text1",
                              "",
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '' &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user1",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value,
                              "Video1",
                              "",
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '') {
                          myController.getTextFromUser(
                              "user1",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value,
                              "Image1",
                              "",
                              myController.preTextMsgController.value
                                  .toString());
                          // FocusScope.of(context).unfocus();
                        }
                        myController.scrollToBottom();

                        myController.messageController.value = '';
                        myController.pickedVideo = null;
                        myController.pickedFile = null;
                        myController.isVideoPicked.value = false;
                        myController.isImagePicked.value = false;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.looks_two_outlined,
                          color: Colors.blueAccent),
                      onPressed: () {
                        if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedVideo!.path.toString(),
                              "Video",
                              myController.messageController.value,
                              "Text1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedVideo!.path.toString(),
                              "Video",
                              myController.messageController.value,
                              "Video1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedVideo != null &&
                            myController.prevMsgType.value == "Image1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedVideo!.path.toString(),
                              "Video",
                              myController.messageController.value,
                              "Image1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Text1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Video1",
                              myController.textController1.text,
                              "");
                        } else if (myController.pickedFile != null &&
                            myController.prevMsgType.value == "Image1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.pickedFile!.path,
                              "image",
                              myController.messageController.value,
                              "Image1",
                              myController.textController1.text,
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '' &&
                            myController.prevMsgType.value == "Text1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value.toString(),
                              "Text1",
                              "",
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '' &&
                            myController.prevMsgType.value == "Video1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value.toString(),
                              "Video1",
                              "",
                              "");
                        } else if (myController.textController1.text != null &&
                            myController.textController1.text != '' &&
                            myController.prevMsgType.value == "Image1") {
                          myController.getTextFromUser(
                              "user2",
                              myController.textController1.text,
                              "Text",
                              myController.messageController.value.toString(),
                              "Image1",
                              "",
                              "");

                          // FocusScope.of(context).unfocus();
                        }
                        myController.scrollToBottom();

                        myController.messageController.value = '';
                        myController.pickedVideo = null;
                        myController.pickedFile = null;
                        myController.isVideoPicked.value = false;
                        myController.isImagePicked.value = false;
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          myController.getFromCamera();
                          myController.textController1.clear();
                        },
                        icon:
                            const Icon(Icons.image, color: Colors.blueAccent)),
                    IconButton(
                        onPressed: () {
                          myController.getFromVideo();
                          myController.textController1.clear();
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

  Row buildImage(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      //mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 300,
              child: Image.file(
                File(myController.jsondata1.value[index]["message"]!),
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
                child: Container(
              width: 200,
              child: Text(myController.jsondata1.value[index]["text"]),
            )),
          ],
        ),
        Text(
          myController.jsondata1.value[index]["date"]!,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Row buildVideo(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
                      videoUrl: myController.jsondata1.value[index]
                          ["message"]!));
                  //   ),
                  // );
                },
                child: Container(
                    height: 200,
                    child:
                        // buildChewie(
                        //     index,
                        //     myController.jsondata1[index]
                        //         ["message"]!),
                        FutureBuilder<String?>(
                      future: myController.generateThumbnail(
                          myController.jsondata1.value[index]["message"]!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                Image.file(File(snapshot.data!)),
                                Center(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      radius: 30),
                                ),
                                Center(
                                  child: Icon(Icons.arrow_right,
                                      size: 50, color: Colors.white),
                                ),
                              ],
                            );
                          } else {
                            return Text('Thumbnail not available');
                          }
                        } else {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
                        }
                      },
                    )),
              ),
              Text(myController.jsondata1.value[index]["text"]),
            ],
          ),
        ),
        Text(
          myController.jsondata1.value[index]["date"]!,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Row buildText(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(myController.jsondata1.value[index]["message"]!)),
        Transform.translate(
          offset: Offset(0, 6.0),
          child: Text(
            myController.jsondata1.value[index]["date"]!,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  Container PrevText(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(
            left: BorderSide(
          color: Colors.yellow,
          width: 4.0,
        )),
      ),
      child: Text(myController.jsondata1.value[index]["preMsg"]!),
    );
  }

  InkWell PrevVideo(int index) {
    return InkWell(
      onTap: () {
        Get.to(VideoPage(
            videoUrl: myController.jsondata1.value[index]["preMsg"]!));
      },
      child: Container(
          height: 200,
          child: FutureBuilder<String?>(
            future: myController.generateThumbnail(
                myController.jsondata1.value[index]["preMsg"]!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Image.file(File(snapshot.data!)),
                      CircleAvatar(backgroundColor: Colors.black54, radius: 30),
                      Center(
                        child: Icon(Icons.arrow_right,
                            size: 50, color: Colors.white),
                      ),
                    ],
                  );
                } else {
                  return Text('Thumbnail not available');
                }
              } else {
                return Center(
                    child:
                        CircularProgressIndicator()); // Display a loading indicator while generating the thumbnail.
              }
            },
          )),
    );
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

  Widget preMsgView(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (myController.jsondata1.value[index]["prevMsgType"] == "Text1" &&
            myController.jsondata1.value[index]["preMsg"] != null &&
            myController.jsondata1.value[index]["preMsg"] != '')
          PrevText(index)
        else if (myController.jsondata1.value[index]["prevMsgType"] ==
                "Video1" &&
            myController.jsondata1.value[index]["preMsg"] != null &&
            myController.jsondata1.value[index]["preMsg"] != '')
          PrevVideo(index)
        else if (myController.jsondata1.value[index]["prevMsgType"] ==
                "Image1" &&
            myController.jsondata1.value[index]["preMsg"] != null &&
            myController.jsondata1.value[index]["preMsg"] != '')
          prevImage(index)
        else
          Container(width: 0),
        _buildCustomLinkPreview(
            context, myController.jsondata1.value[index]["message"]!),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget prevImage(int index) {
    return Container(
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("You"),
            Row(
              children: [
                const Icon(Icons.photo),
                if (myController.jsondata1.value[index]["preText"] != null &&
                    myController.jsondata1.value[index]["preText"] != '')
                  Text(myController.jsondata1.value[index]["preText"]),
              ],
            )
          ]),
          Image.file(
            File(myController.jsondata1.value[index]["preMsg"]!),
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
