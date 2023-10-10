import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class MyController extends GetxController {
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
  RxString messageController = "".obs;
  RxString prevMsgType = "Text1".obs;
  RxString preTextMsgController = "".obs;
  TextEditingController textController1 = TextEditingController();
  var isImagePicked = false.obs;
  var isVideoPicked = false.obs;
  var isTextFromUser = false.obs;
  PickedFile? pickedFile;
  PickedFile? pickedVideo;
  void getFromCamera() async {
    isImagePicked.value = true;
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    isImagePicked.refresh();

    if (pickedFile != null) {
      //isImagePicked.value = true;
      //  setState(() {});
    }
  }

  void getFromVideo() async {
    isVideoPicked.value = true;
    pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    isVideoPicked.refresh();
    if (pickedVideo != null) {
      // setState(() {
      // path2 = pickedVideo!.path;
      //print("Video path$path2");
      // });
    }
  }

  void getTextFromUser(
      sender, msg, type, preMsg, preType, textMsg, preTextMsg) {
    isTextFromUser.value = true;
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
}
