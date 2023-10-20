import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player_custom/flick_video_player_custom.dart';
import 'package:flutter/material.dart';
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../ChatApp/thumbVideo.dart';
import '../provider/chat_screen_provider.dart';

class Chat_app10 extends StatefulWidget {
  const Chat_app10({Key? key}) : super(key: key);

  @override
  State<Chat_app10> createState() => _Chat_app10State();
}

class _Chat_app10State extends State<Chat_app10> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   provider.scrollToBottom();
    // });
  }

  @override
  void dispose() {
    //provider.scrollController.dispose();
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
      body: Consumer<ChatScreenProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: value.scrollController,
                  itemCount: value.jsondata1.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          if (value.jsondata1[index]["messageType"] == "Text") {
                            value.setmessageController(
                                value.jsondata1[index]["message"]!);
                            value.setprevMsgType("Text1");
                          } else if (value.jsondata1[index]["messageType"] ==
                              "Video") {
                            value.setmessageController(
                                value.jsondata1[index]["message"]!);
                            value.setprevMsgType("Video1");
                          } else if (value.jsondata1[index]["messageType"] ==
                              "image") {
                            value.setmessageController(
                                value.jsondata1[index]["message"]!);
                            value.setprevMsgType("Image1");
                            value.setpreTextMsgController(
                                value.jsondata1[index]["text"]);
                          }
                        },
                        child: Align(
                          alignment: value.jsondata1[index]["sender"] == "user1"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding:
                                const EdgeInsets.all(4).copyWith(bottom: 8),
                            margin: value.jsondata1[index]["sender"] == "user1"
                                ? EdgeInsets.only(left: 100, right: 8, top: 8)
                                : EdgeInsets.only(right: 100, left: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: value.jsondata1[index]["sender"] ==
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
                                  preMsgView(value, index),
                                  msgView(value, index),
                                ],
                              ),
                            ),
                          ),
                        ));
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
                    if (value.messageController == '*.jpg' ||
                        value.messageController != '' &&
                            value.prevMsgType == 'Image1')
                      Image.file(File(value.messageController.toString()),
                          height: 70, width: 70)
                    else if (value.messageController == '*.mp4' ||
                        value.messageController != '' &&
                            value.prevMsgType == 'Video1')
                      Flexible(
                        child: Container(
                          height: 100,
                          width: 171,
                          child: FlickVideoPlayer(
                            flickManager: FlickManager(
                              videoPlayerController:
                                  VideoPlayerController.network(
                                      value.messageController.toString()),
                            ),
                          ),
                        ),
                      )
                    else
                      Text(value.messageController.toString()),
                    // Text(''),
                    value.pickedVideo != null
                        ? Flexible(
                            child: Container(
                              height: 100,
                              width: 171,
                              child: FlickVideoPlayer(
                                flickManager: FlickManager(
                                  videoPlayerController:
                                      VideoPlayerController.network(
                                          value.pickedVideo!.path.toString()),
                                ),
                              ),
                            ),
                          )
                        : (value.pickedFile != null)
                            ? Image.file(
                                File(value.pickedFile!.path.toString()))
                            : Flexible(
                                child: SingleChildScrollView(
                                  child: _buildCustomLinkPreview(
                                      context, value.textController1.text),
                                ),
                              ),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: value.textController1,
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.blueAccent),
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.looks_one_outlined,
                              color: Colors.blueAccent),
                          onPressed: () {
                            if (value.pickedVideo != null &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Text1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedVideo != null &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Video1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedVideo != null &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Image1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Text1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Video1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Image1",
                                  value.textController1.text,
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Text1",
                                  "",
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Video1",
                                  "",
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user1",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Image1",
                                  "",
                                  value.preTextMsgController.toString());

                              // FocusScope.of(context).unfocus();
                            }
                            value.scrollToBottom();

                            value.setmessageController('');
                            value.setpickedVideo(null);
                            value.setpickedFile(null);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.looks_two_outlined,
                              color: Colors.blueAccent),
                          onPressed: () {
                            if (value.pickedVideo != null &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Text1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedVideo != null &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Video1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedVideo != null &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedVideo!.path,
                                  "Video",
                                  value.messageController,
                                  "Image1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Text1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Video1",
                                  value.textController1.text,
                                  "");
                            } else if (value.pickedFile != null &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.pickedFile!.path,
                                  "image",
                                  value.messageController,
                                  "Image1",
                                  value.textController1.text,
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Text1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Text1",
                                  "",
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Video1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Video1",
                                  "",
                                  "");
                            } else if (value.textController1.text != null &&
                                value.textController1.text != '' &&
                                value.prevMsgType == "Image1") {
                              value.getTextFromUser(
                                  "user2",
                                  value.textController1.text,
                                  "Text",
                                  value.messageController,
                                  "Image1",
                                  "",
                                  value.preTextMsgController.toString());

                              // FocusScope.of(context).unfocus();
                            }
                            value.scrollToBottom();

                            value.setmessageController('');
                            value.setpickedVideo(null);
                            value.setpickedFile(null);
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              value.getFromCamera();
                              value.textController1.clear();
                            },
                            icon: const Icon(Icons.image,
                                color: Colors.blueAccent)),
                        IconButton(
                            onPressed: () {
                              value.getFromVideo();
                              value.textController1.clear();
                            },
                            icon: const Icon(Icons.video_call,
                                color: Colors.blueAccent)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row buildImage(ChatScreenProvider value, int index) {
    print("value.jsondata1[index][tex]${value.jsondata1[index]["text"]}");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 300,
              child: Image.file(
                File(value.jsondata1[index]["message"]!),
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
                child: Container(
              width: 200,
              child: Text(value.jsondata1[index]["text"]),
            )),
          ],
        ),
        Text(
          value.jsondata1[index]["date"]!,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Row buildVideo(ChatScreenProvider value, int index) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPage(
                          videoUrl: value.jsondata1[index]["message"]!),
                    ),
                  );
                },
                child: Container(
                    height: 200,
                    child:
                        // buildChewie(
                        //     index,
                        //     myController.jsondata1[index]
                        //         ["message"]!),
                        FutureBuilder<String?>(
                      future: value.generateThumbnail(
                          value.jsondata1[index]["message"]!),
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
              Text(value.jsondata1[index]["text"]),
            ],
          ),
        ),
        Text(
          value.jsondata1[index]["date"]!,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Row buildText(ChatScreenProvider value, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(value.jsondata1[index]["message"]!)),
        Transform.translate(
          offset: Offset(0, 6.0),
          child: Text(
            value.jsondata1[index]["date"]!,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  Widget prevImage(ChatScreenProvider value, int index) {
    print(
        "value.jsondata1[index][preText]${value.jsondata1[index]["preText"]}");
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
                if (value.jsondata1[index]["preText"] != null &&
                    value.jsondata1[index]["preText"] != '')
                  Text(value.jsondata1[index]["preText"]),
              ],
            )
          ]),
          Image.file(
            File(value.jsondata1[index]["preMsg"]!),
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }

  InkWell PrevVideo(BuildContext context, ChatScreenProvider value, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoPage(videoUrl: value.jsondata1[index]["preMsg"]!)),
        );
      },
      child: Container(
        height: 200,
        child: FutureBuilder<String?>(
          future: generateThumbnail(value.jsondata1[index]["preMsg"]!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Image.file(File(snapshot.data!)),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 30,
                        child: Center(
                          child: Icon(Icons.arrow_right,
                              size: 50, color: Colors.white),
                        ),
                      ),
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
        ),
      ),
    );
  }

  Container PrevText(ChatScreenProvider value, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(
            left: BorderSide(
          color: Colors.yellow,
          width: 4.0,
        )),
      ),
      child: Text(value.jsondata1[index]["preMsg"]!),
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

  Future<String?> generateThumbnail(String videoPath) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );

    return thumbnailPath;
  }

  Widget preMsgView(ChatScreenProvider value, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value.jsondata1[index]["prevMsgType"] == "Text1" &&
            value.jsondata1[index]["preMsg"] != null &&
            value.jsondata1[index]["preMsg"] != '')
          PrevText(value, index)
        else if (value.jsondata1[index]["prevMsgType"] == "Video1" &&
            value.jsondata1[index]["preMsg"] != null &&
            value.jsondata1[index]["preMsg"] != '')
          PrevVideo(context, value, index)
        else if (value.jsondata1[index]["prevMsgType"] == "Image1" &&
            value.jsondata1[index]["preMsg"] != null &&
            value.jsondata1[index]["preMsg"] != '')
          prevImage(value, index)
        else
          Container(width: 0),
        _buildCustomLinkPreview(context, value.jsondata1[index]["message"]!),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget msgView(ChatScreenProvider value, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value.jsondata1[index]["messageType"] == "Text")
          buildText(value, index)
        else if (value.jsondata1[index]["messageType"] == "Video")
          buildVideo(value, index)
        else if (value.jsondata1[index]["messageType"] == "image")
          buildImage(value, index)
        else
          Container(),
        // _buildCustomLinkPreview(
        //     context, myController.jsondata1[index]["message"]!),
        const SizedBox(height: 2),
      ],
    );
  }
}
