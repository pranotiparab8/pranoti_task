import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:video_player/video_player.dart';

import 'chat_Model.dart';
import 'chat_data.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final List<ChatMessage> chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  PickedFile? pickedFile;
  PickedFile? pickedVideo;
  String? path1;
  String? path2;
  TextEditingController textController1 = TextEditingController();
  String messageController = "";
  String prevMsgType = "Text1";
  DateTime now = DateTime.now();
  // RxBool isImagePicked = false.obs;
  // RxBool isVideoPicked = false.obs;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Chewie buildChewie(int index, var text) {
    return Chewie(
        controller: ChewieController(
      videoPlayerController: VideoPlayerController.network(text),
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
            child: ListView.builder(
              itemCount: widget.chat.length,
              itemBuilder: (context, index) {
                return widget.chat[index].messageType == "Text"
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            messageController = widget.chat[index].message!;
                            prevMsgType = "Text1";
                          });
                        },
                        child: Align(
                          alignment: widget.chat[index].sender == "user1"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding:
                                const EdgeInsets.all(4).copyWith(bottom: 8),
                            margin: widget.chat[index].sender == "user1"
                                ? EdgeInsets.only(left: 100, right: 8, top: 8)
                                : EdgeInsets.only(right: 100, left: 8, top: 8),
                            decoration: BoxDecoration(
                              borderRadius: widget.chat[index].sender == "user1"
                                  ? BorderRadius.circular(8)
                                      .copyWith(bottomRight: Radius.circular(0))
                                  : BorderRadius.circular(8)
                                      .copyWith(bottomLeft: Radius.circular(0)),
                              color: Colors.lightBlueAccent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.chat[index].preMsgType == "Text1" &&
                                    widget.chat[index].preMsg != null &&
                                    widget.chat[index].preMsg != '')
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Container(
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        border: Border(
                                            left: BorderSide(
                                          color: Colors.yellow,
                                          width: 4.0,
                                        )),
                                      ),
                                      child: Flexible(
                                        child: Text(widget.chat[index].preMsg!),
                                      ),
                                    ),
                                  )
                                else if (widget.chat[index].preMsgType ==
                                        "Video1" &&
                                    widget.chat[index].preMsg != null &&
                                    widget.chat[index].preMsg != '')
                                  Container(
                                      child: buildChewie(
                                          index, widget.chat[index].preMsg!))
                                else if (widget.chat[index].preMsgType ==
                                        "Image1" &&
                                    widget.chat[index].preMsg != null &&
                                    widget.chat[index].preMsg != '')
                                  Image.file(
                                    File(widget.chat[index].preMsg!),
                                    width: 80,
                                    height: 80,
                                  )
                                else
                                  Container(width: 0),
                                _buildCustomLinkPreview(
                                    context, widget.chat[index].message!),
                                if (widget.chat[index].message != null &&
                                        widget.chat[index].message != '' &&
                                        widget.chat[index].preMsg != null ||
                                    widget.chat[index].preMsg != '')
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(
                                              widget.chat[index].message!)),
                                      Transform.translate(
                                        offset: Offset(0, 6.0),
                                        child: Text(
                                          widget.chat[index].date!,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.right,
                                        ),
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : widget.chat[index].messageType == "Video"
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                messageController = widget.chat[index].message!;
                                prevMsgType = "Video1";
                              });
                            },
                            child: Align(
                              alignment: widget.chat[index].sender == "user1"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: widget.chat[index].sender == "user1"
                                    ? EdgeInsets.only(
                                        left: 100, right: 8, top: 8)
                                    : EdgeInsets.only(
                                        right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: widget.chat[index].sender ==
                                          "user1"
                                      ? BorderRadius.circular(8).copyWith(
                                          bottomRight: const Radius.circular(0))
                                      : BorderRadius.circular(8).copyWith(
                                          bottomLeft: const Radius.circular(0)),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (widget.chat[index].preMsg != '' &&
                                        widget.chat[index].preMsg != null)
                                      Card(
                                        color: Colors.lightBlue,
                                        child: widget.chat[index].preMsgType ==
                                                "Text1"
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.0),
                                                child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      border: Border(
                                                          left: BorderSide(
                                                        color: Colors.yellow,
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
                                                          child: Text(widget
                                                              .chat[index]
                                                              .preMsg!),
                                                        ),
                                                      ],
                                                    )),
                                              )
                                            : widget.chat[index].preMsgType ==
                                                    "Video1"
                                                ? Flexible(
                                                    child: Container(
                                                      child: buildChewie(
                                                          index,
                                                          widget.chat[index]
                                                              .preMsg!),
                                                    ),
                                                  )
                                                : Image.file(
                                                    File(widget
                                                        .chat[index].preMsg!),
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                      ),
                                    _buildCustomLinkPreview(
                                        context, widget.chat[index].message!),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                    height: 200,
                                                    child: buildChewie(
                                                        index,
                                                        widget.chat[index]
                                                            .message!)),
                                              ),
                                              Text(widget.chat[index].text),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          widget.chat[index].date!,
                                          style: const TextStyle(fontSize: 12),
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
                                messageController = widget.chat[index].message!;
                                prevMsgType = "Image1";
                              });
                            },
                            child: Align(
                              alignment: widget.chat[index].sender == "user1"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: widget.chat[index].sender == "user1"
                                    ? const EdgeInsets.only(
                                        left: 100, right: 8, top: 8)
                                    : const EdgeInsets.only(
                                        right: 100, left: 8, top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: widget.chat[index].sender ==
                                          "user1"
                                      ? BorderRadius.circular(8).copyWith(
                                          bottomRight: const Radius.circular(0))
                                      : BorderRadius.circular(8).copyWith(
                                          bottomLeft: const Radius.circular(0)),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (widget.chat[index].preMsgType ==
                                            "Text1" &&
                                        widget.chat[index].preMsg != null &&
                                        widget.chat[index].preMsg != '')
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
                                                  child: Text(widget
                                                      .chat[index].preMsg!),
                                                ),
                                              ],
                                            )),
                                      )
                                    else if (widget.chat[index].preMsgType ==
                                            "Video1" &&
                                        widget.chat[index].preMsg != null &&
                                        widget.chat[index].preMsg != '')
                                      Container(
                                          child: buildChewie(index,
                                              widget.chat[index].preMsg!))
                                    else if (widget.chat[index].preMsgType ==
                                            "Image1" &&
                                        widget.chat[index].preMsg != null &&
                                        widget.chat[index].preMsg != '')
                                      Image.file(
                                        File(widget.chat[index].preMsg!),
                                        width: 80,
                                        height: 80,
                                      )
                                    else
                                      Container(width: 0),
                                    _buildCustomLinkPreview(
                                        context, widget.chat[index].message!),
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
                                                File(widget
                                                    .chat[index].message!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Flexible(
                                                child: Container(
                                              width: 200,
                                              child:
                                                  Text(widget.chat[index].text),
                                            )),
                                          ],
                                        ),
                                        Text(
                                          widget.chat[index].date!,
                                          style: const TextStyle(fontSize: 12),
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
                    : (pickedFile != null)
                        ? Image.file(File(pickedFile!.path.toString()))
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
                          if (pickedVideo != null && prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Text1",
                                textController1.text);
                          } else if (pickedVideo != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Video1",
                                textController1.text);
                          } else if (pickedVideo != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user1",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Image1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user1",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Text1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user1",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Video1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user1",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Image1",
                                textController1.text);
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Text1") {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController, "Text1", "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Video1") {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController, "Video1", "");
                            print("Video1");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Image1") {
                            _getTextFromUser("user1", textController1.text,
                                "Text", messageController, "Image1", "");
                            print("Image1");

                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        messageController = '';
                        pickedVideo = null;
                        pickedFile = null;
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
                                textController1.text);
                          } else if (pickedVideo != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user2",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Video1",
                                textController1.text);
                          } else if (pickedVideo != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user2",
                                pickedVideo!.path,
                                "Video",
                                messageController,
                                "Image1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Text1") {
                            _getTextFromUser(
                                "user2",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Text1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Video1") {
                            _getTextFromUser(
                                "user2",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Video1",
                                textController1.text);
                          } else if (pickedFile != null &&
                              prevMsgType == "Image1") {
                            _getTextFromUser(
                                "user2",
                                pickedFile!.path,
                                "image",
                                messageController,
                                "Image1",
                                textController1.text);
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Text1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Text1", "");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Video1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Video1", "");
                            print("Video1");
                          } else if (textController1.text != null &&
                              textController1.text != '' &&
                              prevMsgType == "Image1") {
                            _getTextFromUser("user2", textController1.text,
                                "Text", messageController, "Image1", "");
                            print("Image1");

                            // FocusScope.of(context).unfocus();
                          }
                          _scrollToBottom();
                        });
                        messageController = '';
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

  _getFromCamera() async {
    //isImagePicked.value = true;
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    if (pickedFile != null) {
      // isImagePicked.value = true;
      setState(() {});
    }
  }

  // path1 = pickedFile!.path;
  _getFromVideo() async {
    //isVideoPicked.value = true;
    pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {
      setState(() {
        path2 = pickedVideo!.path;
      });
    }
  }

  _getTextFromUser(sender, msg, type, preMsg, preType, textMsg) {
    setState(() {
      jsondata2.add(ChatMessage(
        sender: sender,
        message: msg,
        messageType: type,
        date: intl.DateFormat.jm().format(DateTime.now()),
        preMsg: preMsg,
        preMsgType: preType,
        text: textMsg,
      ));
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
