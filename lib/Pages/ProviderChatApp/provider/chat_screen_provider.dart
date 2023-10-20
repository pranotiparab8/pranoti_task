import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatScreenProvider with ChangeNotifier {
  String _messageController = "";
  String get messageController => _messageController;
  String _prevMsgType = "Text1";
  String get prevMsgType => _prevMsgType;
  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  PickedFile? _pickedVideo;
  PickedFile? get pickedVideo => _pickedVideo;
  String _preTextMsgController = "";
  String get preTextMsgController => _preTextMsgController;
  DateTime _now = DateTime.now();
  DateTime get now => _now;
  List<Map<String, dynamic>> _jsondata1 = [
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
  ];
  List<Map<String, dynamic>> get jsondata1 => _jsondata1;
  TextEditingController _textController1 = TextEditingController();
  TextEditingController get textController1 => _textController1;
  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  void getFromCamera() async {
    _pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    if (_pickedFile != null) {}
    notifyListeners();
  }

  void getFromVideo() async {
    _pickedVideo = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {}
    notifyListeners();
  }

  void getTextFromUser(
      sender, msg, type, preMsg, preType, textMsg, preTextMsg) {
    //setState(() {
    jsondata1.add({
      "sender": sender,
      "message": msg,
      "messageType": type,
      "date": intl.DateFormat.jm().format(DateTime.now()),
      "preMsg": preMsg,
      "prevMsgType": preType,
      "text": textMsg,
      "preText": preTextMsg,
    });
    textController1.clear();
    notifyListeners();
    //});
  }

  void scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
    notifyListeners();
  }

  void setscrollController(ScrollController value) {
    _scrollController = value;
    notifyListeners();
  }

  void settextController1(TextEditingController value) {
    _textController1 = value;
    notifyListeners();
  }

  void setjsondata1(List<Map<String, dynamic>> value) {
    _jsondata1 = value;
    notifyListeners();
  }

  void setmessageController(String value) {
    _messageController = value;
    notifyListeners();
  }

  void setprevMsgType(String value) {
    _prevMsgType = value;
    notifyListeners();
  }

  void setpickedFile(PickedFile? value) {
    _pickedFile = value;
    notifyListeners();
  }

  void setpickedVideo(PickedFile? value) {
    _pickedVideo = value;
    notifyListeners();
  }

  void setnow(DateTime value) {
    _now = value;
    notifyListeners();
  }

  void setpreTextMsgController(String value) {
    _preTextMsgController = value;
    notifyListeners();
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
